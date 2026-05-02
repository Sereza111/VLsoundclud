import 'package:soundcloud_explode_dart/soundcloud_explode_dart.dart' as sc;

import '../models/sc_playlist.dart';
import '../models/sc_stream.dart';
import '../models/sc_track.dart';
import '../models/sc_user.dart';
import 'soundcloud_repository.dart';

/// SoundCloud data layer powered by `soundcloud_explode_dart`.
///
/// Scrapes the public web client_id and uses SoundCloud's internal v2 API.
/// Pros: zero credentials, ships immediately. Cons: lives in a grey zone of
/// the SoundCloud ToS — for production consider migrating to the OAuth-based
/// [OfficialApiRepository].
class ExplodeRepository implements SoundCloudRepository {
  ExplodeRepository({sc.SoundcloudClient? client})
      : _client = client ?? sc.SoundcloudClient();

  final sc.SoundcloudClient _client;

  @override
  Future<List<ScTrack>> searchTracks(String query, {int limit = 25}) async {
    if (query.trim().isEmpty) return const [];
    final results = <sc.TrackSearchResult>[];
    await for (final batch in _client.search.getTracks(query, limit: limit)) {
      results.addAll(batch);
      if (results.length >= limit) break;
    }
    return results.take(limit).map(_mapTrackSearch).toList(growable: false);
  }

  @override
  Future<List<ScPlaylist>> searchPlaylists(String query,
      {int limit = 25}) async {
    if (query.trim().isEmpty) return const [];
    final results = <sc.PlaylistSearchResult>[];
    await for (final batch in _client.search.getPlaylists(query, limit: limit)) {
      results.addAll(batch);
      if (results.length >= limit) break;
    }
    return results.take(limit).map(_mapPlaylistSearch).toList(growable: false);
  }

  @override
  Future<ScTrack> getTrack(String id) async {
    final track = await _client.tracks.get(int.parse(id));
    return _mapTrack(track);
  }

  @override
  Future<ScTrack> getTrackByUrl(String url) async {
    final track = await _client.tracks.getByUrl(url);
    return _mapTrack(track);
  }

  @override
  Future<ScStream> getStream(String trackId) async {
    final streams = await _client.tracks.getStreams(int.parse(trackId));
    if (streams.isEmpty) {
      throw StateError('No streams returned for track $trackId');
    }

    // Prefer progressive (gapless, simpler), then high-quality, then anything.
    final progressive = streams.where((s) => s.protocol == 'progressive');
    final pick = progressive.isNotEmpty ? progressive.first : streams.first;

    return ScStream(
      url: pick.url,
      format: pick.protocol == 'hls'
          ? ScStreamFormat.hls
          : ScStreamFormat.progressive,
      mimeType: pick.protocol == 'hls'
          ? 'application/vnd.apple.mpegurl'
          : 'audio/${pick.container.isEmpty ? 'mpeg' : pick.container}',
    );
  }

  @override
  Future<List<ScTrack>> getTrendingTracks({int limit = 30}) async {
    // The unofficial endpoint has no public "trending" feed, so we proxy a
    // popular query. UI labels this as «Лента» rather than «Тренды».
    return searchTracks('trending', limit: limit);
  }

  // ---------------------------------------------------------------------------
  // Mapping helpers
  // ---------------------------------------------------------------------------

  ScTrack _mapTrack(sc.Track t) => ScTrack(
        id: t.id.toString(),
        title: t.title,
        author: _mapMiniUser(t.user),
        artworkUrl: _hiResArtwork(t.artworkUrl?.toString()),
        permalinkUrl: t.permalinkUrl.toString(),
        description: t.description,
        duration: Duration(milliseconds: t.duration.toInt()),
        playCount: t.playbackCount.toInt(),
        likeCount: t.likesCount.toInt(),
        genres: [if (t.genre != null && t.genre!.isNotEmpty) t.genre!],
      );

  ScTrack _mapTrackSearch(sc.TrackSearchResult t) => ScTrack(
        id: t.id.toString(),
        title: t.title,
        author: _mapMiniUser(t.user),
        artworkUrl: _hiResArtwork(t.artworkUrl?.toString()),
        permalinkUrl: t.permalinkUrl.toString(),
        description: t.description,
        duration: Duration(milliseconds: t.duration.toInt()),
        playCount: t.playbackCount.toInt(),
        likeCount: t.likesCount.toInt(),
        genres: [if (t.genre != null && t.genre!.isNotEmpty) t.genre!],
      );

  ScPlaylist _mapPlaylistSearch(sc.PlaylistSearchResult p) => ScPlaylist(
        id: p.id.toString(),
        title: p.title,
        author: _mapMiniUser(p.user),
        artworkUrl: _hiResArtwork(p.artworkUrl?.toString()),
        permalinkUrl: p.permalinkUrl.toString(),
        trackCount: p.trackCount.toInt(),
      );

  /// Loose-typed because [sc.MiniUser] is not exported from the package's
  /// barrel file. We grab the public fields by structural access.
  ScUser _mapMiniUser(dynamic u) => ScUser(
        id: u.id.toString(),
        username: u.username as String,
        displayName: u.fullName as String?,
        avatarUrl: _hiResArtwork((u.avatarUrl as Uri?)?.toString()),
        permalinkUrl: (u.permalinkUrl as Uri).toString(),
        followerCount: (u.followersCount as num).toInt(),
      );

  /// SoundCloud serves `large` (100x100) artwork by default; bump to t500x500
  /// so cover art doesn't look pixelated on full-screen player.
  String? _hiResArtwork(String? url) =>
      url?.replaceAll('-large.', '-t500x500.');
}
