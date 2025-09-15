import 'package:flutter_test/flutter_test.dart';
import 'package:ui_mate/ui_mate.dart';
import 'package:ui_mate/utils/utils.dart';

void main() {
  test('Currency format should return correct value', () {
    final result = pCurrencyFormat(1000, symbol: '\$');
    expect(result, contains('\$'));
  });

  test('BoxDecoration should return a valid object', () {
    final decoration = pBoxDecoration(color: Clr.colorPrimary);
    expect(decoration.color, Clr.colorPrimary);
  });
}
