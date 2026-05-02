import '../models/sc_playlist.dart';
import '../models/sc_stream.dart';
import '../models/sc_track.dart';

/// Source-agnostic SoundCloud data API.
///
/// Implementations must NOT leak transport-specific types into the rest of
/// the app — only the [Sc*] models defined under `data/models/`. This way we
/// can swap [ExplodeRepository] (scraping) for [OfficialApiRepository]
/// (OAuth) without touching UI code.
abstract class SoundCloudRepository {
  /// Free-text search across tracks. Returns up to [limit] hits.
  Future<List<ScTrack>> searchTracks(String query, {int limit = 25});

  /// Search across playlists/albums.
  Future<List<ScPlaylist>> searchPlaylists(String query, {int limit = 25});

  /// Resolve a single track by SoundCloud numeric id.
  Future<ScTrack> getTrack(String id);

  /// Resolve a track straight from a `soundcloud.com/<user>/<slug>` link.
  Future<ScTrack> getTrackByUrl(String url);

  /// Resolve a playable URL for the track. Picks the highest-quality stream
  /// available, preferring progressive MP3 (simpler, gapless) and falling
  /// back to HLS when only that is available.
  Future<ScStream> getStream(String trackId);

  /// Curated home-feed: a small grab-bag of suggestions. Implementations may
  /// fall back to a fixed search query.
  Future<List<ScTrack>> getTrendingTracks({int limit = 30});
}
