import 'package:test/test.dart';
import 'package:dart_project/src/calculator.dart';

void main() {
  late Calculator calculator;
  
  setUp(() {
    calculator = Calculator();
  });
  
  group('Calculator 基础运算测试', () {
    test('加法测试', () {
      expect(calculator.add(2, 3), equals(5));
      expect(calculator.add(-1, 1), equals(0));
      expect(calculator.add(0.5, 0.5), equals(1.0));
    });
    
    test('减法测试', () {
      expect(calculator.subtract(5, 3), equals(2));
      expect(calculator.subtract(0, 5), equals(-5));
      expect(calculator.subtract(10.5, 0.5), equals(10.0));
    });
    
    test('乘法测试', () {
      expect(calculator.multiply(3, 4), equals(12));
      expect(calculator.multiply(-2, 3), equals(-6));
      expect(calculator.multiply(0, 100), equals(0));
    });
    
    test('除法测试', () {
      expect(calculator.divide(10, 2), equals(5));
      expect(calculator.divide(7, 2), equals(3.5));
      expect(calculator.divide(-10, 2), equals(-5));
    });
    
    test('除以零应该抛出异常', () {
      expect(() => calculator.divide(10, 0), throwsArgumentError);
    });
  });
  
  group('Calculator 高级运算测试', () {
    test('幂运算测试', () {
      expect(calculator.power(2, 3), equals(8));
      expect(calculator.power(5, 0), equals(1));
      expect(calculator.power(10, 2), equals(100));
    });
    
    test('负指数幂运算测试', () {
      expect(calculator.power(2, -2), equals(0.25));
      expect(calculator.power(10, -1), equals(0.1));
    });
    
    test('阶乘测试', () {
      expect(calculator.factorial(0), equals(1));
      expect(calculator.factorial(1), equals(1));
      expect(calculator.factorial(5), equals(120));
      expect(calculator.factorial(6), equals(720));
    });
    
    test('负数阶乘应该抛出异常', () {
      expect(() => calculator.factorial(-1), throwsArgumentError);
    });
  });
}