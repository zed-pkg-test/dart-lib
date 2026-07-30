/// The one thing this zed-sourced package exports.
library;

/// Names the immutable Zed package namespace, so a consumer's assertion proves
/// *which* package resolved rather than merely that something importable did.
String greet(String who) => 'hello $who from zed-pkg-test/dart-lib';

/// The language tag a consumer can cross-check against `.zed/paths.json`.
const String language = 'dart';
