import 'models/user.dart';
import 'services/data_service.dart';
import 'calculator.dart';

/// 应用程序主类
class Application {
  final DataService _dataService;
  final Calculator _calculator;
  
  /// 构造函数，使用依赖注入
  Application({
    DataService? dataService,
    Calculator? calculator,
  })  : _dataService = dataService ?? DataService(),
        _calculator = calculator ?? Calculator();
  
  /// 运行应用程序
  void run() {
    print('应用程序启动...');
    
    // 创建用户实例
    final user = User(
      id: '1',
      name: '张三',
      email: 'zhangsan@example.com',
      age: 25,
    );
    
    print('用户信息: ${user.toString()}');
    
    // 使用计算器
    final sum = _calculator.add(10, 20);
    final product = _calculator.multiply(5, 6);
    
    print('计算结果:');
    print('10 + 20 = $sum');
    print('5 × 6 = $product');
    
    // 使用数据服务
    _dataService.saveUser(user);
    final loadedUser = _dataService.getUser('1');
    
    if (loadedUser != null) {
      print('成功加载用户: ${loadedUser.name}');
    }
    
    print('应用程序运行完成！');
  }
}