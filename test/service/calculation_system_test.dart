import 'package:bom_app/service/calculation_system.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final mock = CalculationSystem();
  test('正常 perMoney', () {
    final result = mock.perMoney(index: 0, par: 1, price: 1000);
    expect(result, isNotNull);
    expect(result.days, 1000.0);
    expect(result.weeklys, 7000.0);
    expect(result.years, 365000.0);
  });
  test('正常 perMoney', () {
    final result = mock.perMoney(index: 0, par: 1, price: 1000);
    expect(result, isNotNull);
    expect(result.days, 1000.0);
    expect(result.weeklys, 7000.0);
    expect(result.years, 365000.0);
  });

  test('正常 getContract', () {
    final date = DateTime.now();
    final result = mock.getContract(startTime: DateTime.now());
    final diff = date.hour;
    expect(result, isNotNull);
    print(diff);
  });
  test('正常 getContractDay', () {
    final difTime = DateTime(1992, 11, 13);
    final result = mock.getContractDay(
      startTime: difTime,
    );

    final date = DateTime.now();
    final now = DateTime(date.year, date.month, date.day);
    final difference = now.difference(difTime).inDays;
    expect(result, isNotNull);
    print(result);
    expect(result, difference);
  });
}
