/// Build-time configuration.
///
/// Pass values via:
///   flutter run --dart-define=SC_CLIENT_ID=xxx --dart-define=SC_CLIENT_SECRET=yyy
///
/// When [soundCloudClientId] is empty the app falls back to the unofficial
/// scraping repository. The OAuth-backed [OfficialApiRepository] only kicks in
/// once both values are provided.
///
/// Для воспроизведения части треков в подписочном каталоге можно передать
/// `SC_OAUTH_TOKEN` (Bearer из сессии браузера / официального API) —
/// см. README.
class Env {
  Env._();

  static const String soundCloudClientId =
      String.fromEnvironment('SC_CLIENT_ID', defaultValue: '');

  static const String soundCloudClientSecret =
      String.fromEnvironment('SC_CLIENT_SECRET', defaultValue: '');

  /// Опционально: OAuth token пользователя для разрешения потоков,
  /// которые без логина не отдаются (не публикуй в открытых сборках).
  static const String soundCloudOAuthToken =
      String.fromEnvironment('SC_OAUTH_TOKEN', defaultValue: '');

  static const String soundCloudRedirectUri = String.fromEnvironment(
    'SC_REDIRECT_URI',
    defaultValue: 'org.vl.vlsoundcloud://oauth/callback',
  );

  static bool get hasOfficialCredentials =>
      soundCloudClientId.isNotEmpty && soundCloudClientSecret.isNotEmpty;
}
