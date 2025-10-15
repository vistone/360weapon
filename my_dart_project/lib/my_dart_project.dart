// 导入所需模块
import 'models/user.dart';
import 'services/user_service.dart';

// 导出所有模块供外部使用
export 'models/user.dart';
export 'services/user_service.dart';

/// 数学计算器类 - 面向对象设计
class Calculator {
  /// 私有构造函数，实现单例模式
  Calculator._();
  
  /// 单例实例
  static final Calculator _instance = Calculator._();
  
  /// 获取单例实例
  static Calculator get instance => _instance;
  
  /// 基本计算方法
  int calculate() {
    return 6 * 7;
  }
  
  /// 加法运算
  double add(double a, double b) {
    return a + b;
  }
  
  /// 减法运算
  double subtract(double a, double b) {
    return a - b;
  }
  
  /// 乘法运算
  double multiply(double a, double b) {
    return a * b;
  }
  
  /// 除法运算
  double divide(double a, double b) {
    if (b == 0) {
      throw ArgumentError('除数不能为零');
    }
    return a / b;
  }
}

/// 应用程序主类
class MyDartApplication {
  late final Calculator _calculator;
  late final UserService _userService;
  
  /// 构造函数
  MyDartApplication() {
    _calculator = Calculator.instance;
    _userService = UserService.instance;
  }
  
  /// 运行应用程序
  Future<void> run() async {
    print('=== 欢迎使用 Dart 应用程序! ===\n');
    
    // 演示计算器功能
    await _demonstrateCalculator();
    
    // 演示用户服务功能
    await _demonstrateUserService();
  }
  
  /// 演示计算器功能
  Future<void> _demonstrateCalculator() async {
    print('📊 计算器功能演示:');
    print('基础计算: ${_calculator.calculate()}');
    print('加法示例: 10 + 5 = ${_calculator.add(10, 5)}');
    print('减法示例: 10 - 5 = ${_calculator.subtract(10, 5)}');
    print('乘法示例: 10 * 5 = ${_calculator.multiply(10, 5)}');
    print('除法示例: 10 / 5 = ${_calculator.divide(10, 5)}');
    print('');
  }
  
  /// 演示用户服务功能
  Future<void> _demonstrateUserService() async {
    print('👥 用户服务功能演示:');
    
    try {
      // 创建用户
      final user1 = await _userService.createUser('张三', 'zhangsan@example.com');
      final user2 = await _userService.createUser('李四', 'lisi@example.com');
      final user3 = await _userService.createUser('王五', 'wangwu@example.com');
      
      print('✅ 成功创建用户: $user1');
      print('✅ 成功创建用户: $user2');
      print('✅ 成功创建用户: $user3');
      
      // 获取所有用户
      final allUsers = await _userService.getAllUsers();
      print('\n📋 所有用户列表 (共${allUsers.length}个用户):');
      for (final user in allUsers) {
        print('  - $user');
      }
      
      // 根据ID获取用户
      final foundUser = await _userService.getUserById('2');
      if (foundUser != null) {
        print('\n🔍 找到用户: $foundUser');
        print('   邮箱验证: ${foundUser.isValidEmail() ? '✅ 有效' : '❌ 无效'}');
        print('   JSON格式: ${foundUser.toJson()}');
      }
      
      // 删除用户
      final deleted = await _userService.deleteUser('2');
      print('\n🗑️  删除用户结果: ${deleted ? '成功' : '失败'}');
      
      // 显示剩余用户
      final remainingUsers = await _userService.getAllUsers();
      print('剩余用户数量: ${remainingUsers.length}');
      
    } catch (e) {
      print('❌ 用户服务操作失败: $e');
    }
  }
}
