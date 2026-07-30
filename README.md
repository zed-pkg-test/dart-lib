# dart-lib (zed-pkg-test/dart-lib)

A trivial Dart package published to the zed registry. Consumers source it **via
zed** while pub keeps owning the rest of `pubspec.yaml`. See `.zpkg.toml`.

Dart is the interesting adapter: pub has **no environment-variable path
override**, so unlike Go (`GOWORK`) and Python (`PYTHONPATH`), `zed install`
cannot wire this up by itself. It writes `.zed/pub-deps.yaml` and the entries
have to be merged under `dependencies:` in `pubspec.yaml` by hand.

## Known issue with the generated fragment

Verified end to end against `zed 0.1.0` and `Dart 3.12.2`: the generated
`.zed/pub-deps.yaml` is **not usable as emitted**.

```yaml
# .zed/pub-deps.yaml, as generated
dart-lib:
  path: .vendor/.zed/zed-pkg-test/dart-lib
```

The key is taken from the install directory's basename, but pub requires it to
be the package's own `name:` — here `zed_pkg_test_dart_lib`. Pasting it in fails
outright, because `dart-lib` is not even a legal Dart package identifier:

```console
$ dart pub get
Error on line 8, column 3 of pubspec.yaml: Not a valid package name.
  ╷
8 │   dart-lib:
  │   ^^^^^^^^
  ╵
```

Substituting the real pub name resolves cleanly:

```console
$ dart pub get
+ zed_pkg_test_dart_lib 1.0.0 from path .vendor/.zed/zed-pkg-test/dart-lib
```

This affects every package whose zed name is kebab-case — which is the
convention across this whole org, since pub names must be
`lowercase_with_underscores`. The fix is for the Dart adapter to read `name:`
from the installed package's `pubspec.yaml` rather than using the directory
basename. [`dart-app`](https://github.com/zed-pkg-test/dart-app) carries the
corrected entry so the consumer side actually runs.

## License

MIT
