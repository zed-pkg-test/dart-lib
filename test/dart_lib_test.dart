import 'package:test/test.dart';
import 'package:zed_pkg_test_dart_lib/dart_lib.dart';

void main() {
  test('greet identifies the immutable Zed package namespace', () {
    expect(greet('consumer'), 'hello consumer from zed-pkg-test/dart-lib');
  });

  test('language tag matches what zed records in paths.json', () {
    expect(language, 'dart');
  });
}
