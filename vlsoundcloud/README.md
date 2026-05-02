# VL SoundCloud

Кастомный SoundCloud-клиент на Flutter под Android с авторской визуальной темой, реалтайм-визуализатором и слотом под Blender-анимацию.

## Стек

- **Flutter 3.38** / Dart 3.10
- **Аудио:** `just_audio` + `just_audio_background` (фон, lock-screen, Bluetooth)
- **State:** `flutter_riverpod` 3.x
- **Навигация:** `go_router`
- **Модели:** `freezed` + `json_serializable`
- **SoundCloud:** `soundcloud_explode_dart` (без ключей) с абстракцией под официальный OAuth
- **Визуализатор:** кастомный CustomPainter + `BlenderArtSlot` (видео или плейсхолдер)
- **Эквалайзер:** `AndroidEqualizer` из just_audio + сохранение пресетов в SharedPreferences

## Запуск

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d <android-device-id>
```

Если меняешь модели в `lib/data/models/` — снова прогоняй `build_runner`.

## Структура

```
lib/
├── main.dart                              # init JustAudioBackground
├── app.dart                               # MaterialApp + Router
├── core/
│   ├── env.dart                           # --dart-define конфиг
│   ├── theme/app_theme.dart               # цвета, типографика
│   └── router/app_router.dart             # go_router + shell route
├── data/
│   ├── models/                            # freezed: ScTrack, ScUser, ScPlaylist, ScStream
│   ├── soundcloud/
│   │   ├── soundcloud_repository.dart     # абстрактный интерфейс
│   │   ├── explode_repository.dart        # impl: scraping
│   │   ├── official_repository.dart       # impl: OAuth (заглушка)
│   │   └── soundcloud_providers.dart      # Riverpod провайдеры
│   └── audio/audio_controller.dart        # обёртка just_audio + EQ + провайдеры
├── features/
│   ├── home/home_screen.dart              # лента
│   ├── search/search_screen.dart          # дебаунс-поиск
│   ├── library/library_screen.dart        # заглушка (нужен OAuth)
│   └── player/
│       ├── player_screen.dart             # фулл-плеер с визуализатором
│       └── widgets/
│           ├── visualizer/fft_bars.dart        # синтезированный спектр
│           ├── visualizer/blender_art_slot.dart  # СЛОТ Blender
│           ├── equalizer/eq_panel.dart         # 5-полосный EQ
│           └── controls/transport_bar.dart
└── shared/widgets/                        # MainShell, MiniPlayer, TrackTile
```

## Замена Blender-анимации

`BlenderArtSlot` ищет ассет по имени, авто-детектит формат и подставляет его без правок кода.

1. **Готовь сцену в Blender** по контракту:
   - Размер: 1080×1920 (вертикаль)
   - Безопасная зона по центру 720×720 (туда лягут FFT-бары поверх)
   - Прозрачность обязательна (alpha-канал)
   - Бесшовный loop 4–8 секунд
   - 30 FPS

2. **Экспорт в WebM с альфой** (предпочтительный путь):

   ```bash
   ffmpeg -framerate 30 -i frame_%04d.png \
     -c:v libvpx-vp9 -pix_fmt yuva420p \
     -b:v 0 -crf 30 \
     visualizer_active.webm
   ```

3. **Положи файл** в `assets/animations/video/visualizer_active.webm`.

4. **Перезапусти приложение** (`flutter run`). `BlenderArtSlot` сам подхватит файл и заменит анимированный плейсхолдер.

Поддерживаемые имена и состояния (на будущее):
- `visualizer_idle.webm` — пауза / тишина
- `visualizer_active.webm` — обычное проигрывание
- `visualizer_burst.webm` — пик громкости

Сейчас плеер всегда подключает `visualizer_active`. Логику переключения по громкости добавим, когда подключим реальный FFT-стрим.

## Подключение официального SoundCloud API

API закрыт для регистрации с 2016 — заявки рассматривают вручную.

1. Зайди на `https://soundcloud.com/you/apps`, заполни форму, дождись одобрения.
2. Получишь `client_id` и `client_secret`.
3. Запусти приложение с этими переменными:

   ```bash
   flutter run \
     --dart-define=SC_CLIENT_ID=твой_id \
     --dart-define=SC_CLIENT_SECRET=твой_secret
   ```

4. `soundCloudRepositoryProvider` автоматически переключится с `ExplodeRepository` на `OfficialApiRepository` (его нужно дописать — оставлены TODO с эндпоинтами).

## Что сейчас работает

- ✅ Поиск треков и проигрывание (включая прогрессивный MP3 и HLS)
- ✅ Очередь, prev/next, шафл, повтор
- ✅ Фоновое воспроизведение с уведомлением и lock-screen
- ✅ Полноэкранный плеер с обложкой-фоном
- ✅ Визуализатор (синтезированные бары) + слот под Blender
- ✅ 5-полосный EQ с пресетами (Bass+, Vocal, Treble+, Lo-Fi)
- ✅ Mini-player над bottom nav

## Что осталось / roadmap

- ❌ Реальный FFT-стрим из just_audio (нужен сторонний пакет типа `audify` или платформенный канал)
- ❌ Лайки / плейлисты / история (нужен OAuth)
- ❌ Кеш треков на диск
- ❌ iOS-сборка (минимум: заменить `AndroidEqualizer` → `DarwinEqualizer`)
- ❌ Подмена placeholder-анимации на финальный Blender-арт
- ❌ Production-сертификат (`signingConfig` в `build.gradle.kts`)
