import 'package:bin2dec/converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('given a binary number, should return a decimal', () {
    final converter = Converter();

    test('Given 1111 should return 15', () {
      const binary = '1111';
      converter.convert(binary);
      expect(converter.value, 15);
    });

    test('Given 0000 should return 0', () {
      const binary = '0000';
      converter.convert(binary);
      expect(converter.value, 0);
    });
  });
}
