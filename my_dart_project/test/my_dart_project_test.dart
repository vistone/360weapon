import 'package:my_dart_project/my_dart_project.dart';
import 'package:test/test.dart';

void main() {
  group('Calculator 测试', () {
    late Calculator calculator;
    
    setUp(() {
      calculator = Calculator.instance;
    });
    
    test('基础计算测试', () {
      expect(calculator.calculate(), 42);
    });
    
    test('加法测试', () {
      expect(calculator.add(10, 5), 15);
      expect(calculator.add(-5, 3), -2);
      expect(calculator.add(0, 0), 0);
    });
    
    test('减法测试', () {
      expect(calculator.subtract(10, 5), 5);
      expect(calculator.subtract(5, 10), -5);
      expect(calculator.subtract(0, 0), 0);
    });
    
    test('乘法测试', () {
      expect(calculator.multiply(10, 5), 50);
      expect(calculator.multiply(-2, 3), -6);
      expect(calculator.multiply(0, 100), 0);
    });
    
    test('除法测试', () {
      expect(calculator.divide(10, 5), 2);
      expect(calculator.divide(15, 3), 5);
      expect(calculator.divide(7, 2), 3.5);
    });
    
    test('除零异常测试', () {
      expect(() => calculator.divide(10, 0), throwsArgumentError);
    });
    
    test('单例模式测试', () {
      final calculator1 = Calculator.instance;
      final calculator2 = Calculator.instance;
      expect(identical(calculator1, calculator2), true);
    });
  });
  
  group('User 模型测试', () {
    test('用户创建测试', () {
      final user = User(
        id: '1',
        name: '测试用户',
        email: 'test@example.com',
      );
      
      expect(user.id, '1');
      expect(user.name, '测试用户');
      expect(user.email, 'test@example.com');
      expect(user.createdAt, isA<DateTime>());
    });
    
    test('邮箱验证测试', () {
      final validUser = User(id: '1', name: '用户1', email: 'valid@example.com');
      final invalidUser = User(id: '2', name: '用户2', email: 'invalid-email');
      
      expect(validUser.isValidEmail(), true);
      expect(invalidUser.isValidEmail(), false);
    });
    
    test('JSON序列化测试', () {
      final user = User(id: '1', name: '测试', email: 'test@example.com');
      final json = user.toJson();
      
      expect(json['id'], '1');
      expect(json['name'], '测试');
      expect(json['email'], 'test@example.com');
      expect(json['createdAt'], isA<String>());
      
      final userFromJson = User.fromJson(json);
      expect(userFromJson.id, user.id);
      expect(userFromJson.name, user.name);
      expect(userFromJson.email, user.email);
    });
    
    test('用户相等性测试', () {
      final user1 = User(id: '1', name: '用户1', email: 'user1@example.com');
      final user2 = User(id: '1', name: '用户2', email: 'user2@example.com');
      final user3 = User(id: '2', name: '用户1', email: 'user1@example.com');
      
      expect(user1 == user2, true); // 相同ID
      expect(user1 == user3, false); // 不同ID
      expect(user1.hashCode, user2.hashCode); // 相同ID的hashCode应该相同
    });
  });
  
  group('UserService 测试', () {
    late UserService userService;
    
    setUp(() {
      userService = UserService.instance;
      userService.clearAllUsers(); // 清空用户列表
    });
    
    test('创建用户测试', () async {
      final user = await userService.createUser('测试用户', 'test@example.com');
      
      expect(user.name, '测试用户');
      expect(user.email, 'test@example.com');
      expect(user.id, isNotEmpty);
    });
    
    test('创建用户验证测试', () async {
      // 测试空用户名
      expect(
        () => userService.createUser('', 'test@example.com'),
        throwsArgumentError,
      );
      
      // 测试空邮箱
      expect(
        () => userService.createUser('测试', ''),
        throwsArgumentError,
      );
      
      // 测试无效邮箱
      expect(
        () => userService.createUser('测试', 'invalid-email'),
        throwsArgumentError,
      );
      
      // 测试重复邮箱
      await userService.createUser('用户1', 'test@example.com');
      expect(
        () => userService.createUser('用户2', 'test@example.com'),
        throwsArgumentError,
      );
    });
    
    test('获取用户测试', () async {
      final user = await userService.createUser('测试用户', 'test@example.com');
      
      final foundUser = await userService.getUserById(user.id);
      expect(foundUser, isNotNull);
      expect(foundUser!.id, user.id);
      
      final notFoundUser = await userService.getUserById('999');
      expect(notFoundUser, isNull);
    });
    
    test('获取所有用户测试', () async {
      expect(await userService.getAllUsers(), isEmpty);
      
      await userService.createUser('用户1', 'user1@example.com');
      await userService.createUser('用户2', 'user2@example.com');
      
      final users = await userService.getAllUsers();
      expect(users.length, 2);
    });
    
    test('删除用户测试', () async {
      final user = await userService.createUser('测试用户', 'test@example.com');
      
      final deleted = await userService.deleteUser(user.id);
      expect(deleted, true);
      
      final foundUser = await userService.getUserById(user.id);
      expect(foundUser, isNull);
      
      final notDeleted = await userService.deleteUser('999');
      expect(notDeleted, false);
    });
    
    test('单例模式测试', () {
      final service1 = UserService.instance;
      final service2 = UserService.instance;
      expect(identical(service1, service2), true);
    });
  });
}
