import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/sc_track.dart';
import 'explode_repository.dart';
import 'soundcloud_repository.dart';

/// Единый репозиторий SoundCloud.
///
/// [OfficialApiRepository] пока заглушка: если включить его через флаг при
/// наличии только `SC_CLIENT_ID`/`SECRET`, сломаются поиск и лента.
/// Идентификатор приложения из `--dart-define=SC_CLIENT_ID=…` всё равно
/// используется внутри [ExplodeRepository] / [SoundcloudStreamResolver] для
/// разрешения потоков.
final soundCloudRepositoryProvider = Provider<SoundCloudRepository>((ref) {
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
