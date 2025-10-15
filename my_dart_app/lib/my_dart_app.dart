/// 计算器类 - 面向对象设计示例
class Calculator {
  final int _multiplier;

  /// 构造函数
  Calculator({int multiplier = 6}) : _multiplier = multiplier;

  /// 计算方法
  int calculate(int value) {
    return _multiplier * value;
  }

  /// 获取乘数
  int get multiplier => _multiplier;
}

/// 应用程序主类
class MyDartApp {
  final Calculator _calculator;

  /// 构造函数
  MyDartApp() : _calculator = Calculator(multiplier: 6);

  /// 运行应用程序
  void run() {
    final result = _calculator.calculate(7);
    print('计算结果: $result');
  }

  /// 获取计算器实例
  Calculator get calculator => _calculator;
}
