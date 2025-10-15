import 'package:my_dart_app/my_dart_app.dart';
import 'package:test/test.dart';

void main() {
  group('Calculator 类测试', () {
    test('默认乘数应该是6', () {
      final calculator = Calculator();
      expect(calculator.multiplier, 6);
    });

    test('计算方法应该返回正确结果', () {
      final calculator = Calculator(multiplier: 6);
      expect(calculator.calculate(7), 42);
    });

    test('自定义乘数应该正常工作', () {
      final calculator = Calculator(multiplier: 5);
      expect(calculator.calculate(10), 50);
    });
  });

  group('MyDartApp 类测试', () {
    test('应该创建带有计算器的应用实例', () {
      final app = MyDartApp();
      expect(app.calculator, isNotNull);
      expect(app.calculator.multiplier, 6);
    });
  });
}
