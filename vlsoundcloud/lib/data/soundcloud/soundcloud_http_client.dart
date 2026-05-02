import 'package:http/http.dart' as http;

/// HTTP-клиент с заголовками, похожими на браузер на soundcloud.com.
///
/// Без `User-Agent` / `Origin` / `Referer` API часто отвечает 403 на шаге
/// разрешения `transcodings/{id}/stream?client_id=…`, и [getStreams] возвращает
/// пустой список — отсюда «No streams returned».
http.Client createSoundCloudHttpClient() => _SoundCloudHeaderClient();

final class _SoundCloudHeaderClient extends http.BaseClient {
  _SoundCloudHeaderClient() : _inner = http.Client();

  final http.Client _inner;

  static const _ua =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36';

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.putIfAbsent('User-Agent', () => _ua);
    request.headers.putIfAbsent('Accept', () => '*/*');
    request.headers.putIfAbsent('Accept-Language', () => 'en-US,en;q=0.9');
    request.headers.putIfAbsent('Origin', () => 'https://soundcloud.com');
    request.headers.putIfAbsent('Referer', () => 'https://soundcloud.com/');
    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
  }
}
