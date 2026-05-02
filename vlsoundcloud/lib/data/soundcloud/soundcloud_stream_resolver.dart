import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/env.dart';
import '../models/sc_stream.dart';
import 'soundcloud_http_client.dart';

/// Обход ограничений пакета [soundcloud_explode_dart]: часть треков отдаёт
/// транскодинги только если к запросу добавить `track_authorization` из JSON
/// трека (как делает сайт / официальные клиенты). Без этого все запросы к
/// `…/media/…` возвращают ≠200 → список потоков пустой.
final class SoundcloudStreamResolver {
  SoundcloudStreamResolver([http.Client? httpClient])
      : _http = httpClient ?? createSoundCloudHttpClient();

  final http.Client _http;

  Future<ScStream?> resolvePlaybackUrl(String trackId) async {
    final cid = await _effectiveClientId();
    final trackUri = Uri.https(
      'api-v2.soundcloud.com',
      '/tracks/$trackId',
      {'client_id': cid},
    );

    final trackRes = await _http.get(trackUri);
    if (trackRes.statusCode != 200) return null;

    Map<String, dynamic> trackJson;
    try {
      trackJson = jsonDecode(trackRes.body) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }

    final auth = trackJson['track_authorization'] as String?;

    final media = trackJson['media'];
    if (media is! Map<String, dynamic>) return null;
    final trans = media['transcodings'];
    if (trans is! List<dynamic>) return null;

    final items = trans.whereType<Map<String, dynamic>>().toList()
      ..sort((a, b) => _rankTranscoding(b).compareTo(_rankTranscoding(a)));

    for (final t in items) {
      final urlStr = t['url'] as String?;
      if (urlStr == null) continue;

      final fmt = t['format'];
      final protocol =
          fmt is Map<String, dynamic> ? '${fmt['protocol']}' : '';
      final mimeType =
          fmt is Map<String, dynamic> ? fmt['mime_type'] as String? : null;
      final mimeParts = mimeType?.split(';').first.split('/') ?? const <String>[];
      final container =
          mimeParts.length > 1 ? mimeParts[1] : '';

      final base = Uri.parse(urlStr);
      final qp = Map<String, String>.from(base.queryParameters);
      qp['client_id'] = cid;
      if (auth != null && auth.isNotEmpty) {
        qp['track_authorization'] = auth;
      }
      final oauth = Env.soundCloudOAuthToken;
      if (oauth.isNotEmpty) {
        qp['oauth_token'] = oauth;
      }

      final streamMetaUri = base.replace(queryParameters: qp);

      final headers = <String, String>{
        if (oauth.isNotEmpty) 'Authorization': 'OAuth $oauth',
      };

      final metaRes = await _http.get(streamMetaUri, headers: headers);
      if (metaRes.statusCode != 200) continue;

      Map<String, dynamic> metaJson;
      try {
        metaJson = jsonDecode(metaRes.body) as Map<String, dynamic>;
      } catch (_) {
        continue;
      }

      final playbackUrl = metaJson['url'] as String?;
      if (playbackUrl == null || playbackUrl.isEmpty) continue;

      final isHls =
          protocol.contains('hls') || playbackUrl.contains('.m3u8');

      return ScStream(
        url: playbackUrl,
        format: isHls ? ScStreamFormat.hls : ScStreamFormat.progressive,
        mimeType: isHls
            ? 'application/vnd.apple.mpegurl'
            : 'audio/${container.isEmpty ? 'mpeg' : container}',
      );
    }

    return null;
  }

  Future<String> _effectiveClientId() async {
    final defined = Env.soundCloudClientId.trim();
    if (defined.isNotEmpty) return defined;
    return scrapeWebClientId(_http);
  }
}

/// Дублирует логику [SoundcloudController.getClientId] из soundcloud_explode.
Future<String> scrapeWebClientId(http.Client http) async {
  var response = await http.get(Uri.https('soundcloud.com', ''));
  if (response.statusCode != 200) {
    throw StateError(
      'soundcloud.com вернул ${response.statusCode}, не удалось вытащить client_id',
    );
  }

  final scripts = RegExp('<script.*?src="(.*?)"').allMatches(response.body);
  if (scripts.isEmpty) {
    throw StateError('Не найдены script-теги на soundcloud.com');
  }

  final scriptUrl = scripts.last.group(1);
  if (scriptUrl == null || scriptUrl.isEmpty) {
    throw StateError('Пустой URL скрипта на soundcloud.com');
  }

  response = await http.get(Uri.parse(scriptUrl));
  if (response.statusCode != 200) {
    throw StateError(
      'Скрипт soundcloud вернул ${response.statusCode}',
    );
  }

  final body = response.body;
  try {
    return body.split(',client_id')[1].split('"')[1];
  } catch (_) {
    throw StateError('Не удалось распарсить client_id из скрипта soundcloud');
  }
}

int _rankTranscoding(Map<String, dynamic> t) {
  final fmt = t['format'];
  final protocol =
      fmt is Map<String, dynamic> ? '${fmt['protocol']}' : '';
  final snipped = t['snipped'] == true;
  var score = 0;
  if (protocol.contains('progressive')) score += 100;
  if (!protocol.contains('encrypted')) score += 80;
  if (!snipped) score += 40;
  final q = fmt is Map<String, dynamic> ? '${fmt['quality']}' : '';
  if (q == 'hq') score += 15;
  if (q == 'sq') score += 8;
  return score;
}
