# Example App for Shader Compilation Jank

`main.dart` is a minimal repro of shader compilation jank, taken from https://github.com/flutter/flutter/issues/76180.

## With manual interaction

The regular way of collecting SkSL is:

```sh
flutter run --profile --cache-sksl --purge-persistent-cache
```

Then tap the floating action button, followed by the CLOSE text.

Press `M` to write the SkSL to the host.


## To verify that it works

```sh
flutter run --profile --bundle-sksl-path=flutter_01.sksl.json
```

(Use the correct path to the cached shaders)

There will be a message like:

```
The Flutter DevTools debugger and profiler on phone is available at: http://127.0.0.1:61994?uri=http://127.0.0.1:61989/6efuMbZMneE=/
```

Open the link, then do the interaction again. The frames shown in the timeline should not indicate any shader compilation jank.

## With `package:integration_test`

With https://github.com/flutter/flutter/pull/85118, we can use `package:integration_test` to do so:

```sh
flutter test --write-sksl-on-exit=integration-test-sksl.json integration_test

flutter run --profile --bundle-sksl-path=integration-test-sksl.json
```

Do the same as above to open DevTools and check for shader compilation jank.
