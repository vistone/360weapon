/// 计算器类，提供基本的数学运算
class Calculator {
  /// 加法运算
  num add(num a, num b) {
    return a + b;
  }
  
  /// 减法运算
  num subtract(num a, num b) {
    return a - b;
  }
  
  /// 乘法运算
  num multiply(num a, num b) {
    return a * b;
  }
  
  /// 除法运算
  num divide(num a, num b) {
    if (b == 0) {
      throw ArgumentError('除数不能为零');
    }
    return a / b;
  }
  
  /// 计算幂
  num power(num base, int exponent) {
    num result = 1;
    for (int i = 0; i < exponent.abs(); i++) {
      result *= base;
    }
    return exponent < 0 ? 1 / result : result;
  }
  
  /// 计算阶乘
  int factorial(int n) {
    if (n < 0) {
      throw ArgumentError('阶乘只能计算非负整数');
    }
    if (n == 0 || n == 1) {
      return 1;
    }
    return n * factorial(n - 1);
  }
}