# Regenerating the screenshots and demo GIF

The PNGs in `screenshots/` are captured by running the app in the iOS Simulator via an
`integration_test` driver. The demo GIF is assembled from those PNGs.

## 1. Boot a simulator

```sh
xcrun simctl boot "iPhone 17 Pro"
```

## 2. Capture the screenshots

```sh
flutter pub get
flutter drive \
  --driver test_driver/integration_test.dart \
  --target integration_test/screenshot_test.dart \
  -d "iPhone 17 Pro"
```

- `test_driver/integration_test.dart` uses `integrationDriver(onScreenshot:)` to write each
  PNG into `screenshots/`.
- `integration_test/screenshot_test.dart` drives the app across the key screens. It calls
  `binding.convertFlutterSurfaceToImage()` + `binding.takeScreenshot('NN-name')`, using fixed
  `pump(Duration)` (not `pumpAndSettle`) so gradient screens settle before capture.
- The first test walks the live app (onboarding -> tabs); the second pumps the pushed detail
  screens directly.

## 3. Rebuild the demo GIF

The GIF is a slideshow of the captured PNGs (the integration-test binding renders blank to the
live display, so a screen recording of the drive run is not usable). Assemble with ffmpeg:

```sh
# build a concat list of the screenshots, ~1.15s each
for s in 01-tour-code-entry 02-welcome-group 03-home 04-itinerary 05-day-detail \
         06-activity-detail 07-hotels-transfers 08-map-directions 09-updates \
         10-updates-empty 11-profile; do
  printf "file '%s/screenshots/%s.png'\nduration 1.15\n" "$(pwd)" "$s"
done > /tmp/slideshow.txt
printf "file '%s/screenshots/11-profile.png'\n" "$(pwd)" >> /tmp/slideshow.txt

ffmpeg -y -f concat -safe 0 -i /tmp/slideshow.txt \
  -vf "scale=320:-1:flags=lanczos,fps=15,palettegen=stats_mode=diff" /tmp/pal.png
ffmpeg -y -f concat -safe 0 -i /tmp/slideshow.txt -i /tmp/pal.png \
  -lavfi "scale=320:-1:flags=lanczos,fps=15[x];[x][1:v]paletteuse=dither=bayer" \
  screenshots/demo.gif
```

There is also `integration_test/demo_flow_test.dart`, a real-time walkthrough kept for driving
the app manually during development.
