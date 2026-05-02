import '../models/sc_playlist.dart';
import '../models/sc_stream.dart';
import '../models/sc_track.dart';
import 'soundcloud_repository.dart';

/// Stub for the official SoundCloud API (OAuth 2.1 + PKCE).
///
/// Activate this repository once your app has been approved for credentials at
/// `https://soundcloud.com/you/apps` and you have set:
///   --dart-define=SC_CLIENT_ID=...
///   --dart-define=SC_CLIENT_SECRET=...
///
/// Implementation outline:
///   1. Authorize via PKCE: `https://api.soundcloud.com/connect`
///   2. Exchange auth code at `https://api.soundcloud.com/oauth2/token`
///   3. Persist tokens via [FlutterSecureStorage]; refresh on 401.
///   4. Wire endpoints `/search/tracks`, `/tracks/{id}`, `/tracks/{id}/streams`.
class OfficialApiRepository implements SoundCloudRepository {
  OfficialApiRepository({
    required this.clientId,
    required this.clientSecret,
  });

  final String clientId;
  final String clientSecret;

  @override
  Future<List<ScTrack>> searchTracks(String query, {int limit = 25}) {
    throw UnimplementedError(
        'OfficialApiRepository: implement OAuth2 search endpoint');
  }

  @override
  Future<List<ScPlaylist>> searchPlaylists(String query, {int limit = 25}) {
    throw UnimplementedError(
        'OfficialApiRepository: implement OAuth2 playlist search');
  }

  @override
  Future<ScTrack> getTrack(String id) {
    throw UnimplementedError(
        'OfficialApiRepository: GET /tracks/{id}');
  }

  @override
  Future<ScTrack> getTrackByUrl(String url) {
    throw UnimplementedError(
        'OfficialApiRepository: POST /resolve?url=...');
  }

  @override
  Future<ScStream> getStream(String trackId) {
    throw UnimplementedError(
        'OfficialApiRepository: GET /tracks/{id}/streams');
  }

  @override
  Future<List<ScTrack>> getTrendingTracks({int limit = 30}) {
    throw UnimplementedError(
        'OfficialApiRepository: GET /charts?kind=trending');
  }
}
