import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/env.dart';
import '../models/sc_track.dart';
import 'explode_repository.dart';
import 'official_repository.dart';
import 'soundcloud_repository.dart';

/// Single source of truth for repository selection.
///
/// Falls back to [ExplodeRepository] until official credentials are wired up.
final soundCloudRepositoryProvider = Provider<SoundCloudRepository>((ref) {
  if (Env.hasOfficialCredentials) {
    return OfficialApiRepository(
      clientId: Env.soundCloudClientId,
      clientSecret: Env.soundCloudClientSecret,
    );
  }
  return ExplodeRepository();
});

/// Trending feed for the home screen.
final trendingTracksProvider = FutureProvider<List<ScTrack>>((ref) async {
  final repo = ref.watch(soundCloudRepositoryProvider);
  return repo.getTrendingTracks();
});

/// Live search query state. Empty string → no results.
class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void set(String value) => state = value;
}

final searchQueryProvider =
    NotifierProvider<SearchQueryNotifier, String>(SearchQueryNotifier.new);

/// Auto-cancelling search results. Re-fires on every query change with a
/// 300ms debounce baked into the consumer (see SearchScreen).
final searchTracksProvider = FutureProvider<List<ScTrack>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.trim().isEmpty) return const [];
  final repo = ref.watch(soundCloudRepositoryProvider);
  return repo.searchTracks(query);
});
