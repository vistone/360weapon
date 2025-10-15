import 'package:test/test.dart';
import 'package:dart_project/src/services/data_service.dart';
import 'package:dart_project/src/models/user.dart';

void main() {
  group('DataService 测试', () {
    late DataService dataService;
    late User testUser;
    
    setUp(() {
      dataService = DataService();
      testUser = User(
        id: '1',
        name: '张三',
        email: 'zhangsan@example.com',
        age: 25,
      );
    });
    
    tearDown(() {
      dataService.clearAll();
    });
    
    test('保存和获取用户', () {
      dataService.saveUser(testUser);
      final retrievedUser = dataService.getUser('1');
      
      expect(retrievedUser, isNotNull);
      expect(retrievedUser?.id, equals('1'));
      expect(retrievedUser?.name, equals('张三'));
    });
    
    test('获取不存在的用户应返回null', () {
      final user = dataService.getUser('non-existent');
      expect(user, isNull);
    });
    
    test('获取所有用户', () {
      final user1 = User(
        id: '1',
        name: '用户1',
        email: 'user1@example.com',
        age: 20,
      );
      final user2 = User(
        id: '2',
        name: '用户2',
        email: 'user2@example.com',
        age: 30,
      );
      
      dataService.saveUser(user1);
      dataService.saveUser(user2);
      
      final allUsers = dataService.getAllUsers();
      
      expect(allUsers.length, equals(2));
      expect(allUsers.any((u) => u.id == '1'), isTrue);
      expect(allUsers.any((u) => u.id == '2'), isTrue);
    });
    
    test('更新用户', () {
      dataService.saveUser(testUser);
      
      final updatedUser = testUser.copyWith(
        name: '李四',
        age: 26,
      );
      
      final result = dataService.updateUser('1', updatedUser);
      
      expect(result, isTrue);
      
      final retrievedUser = dataService.getUser('1');
      expect(retrievedUser?.name, equals('李四'));
      expect(retrievedUser?.age, equals(26));
      expect(retrievedUser?.updatedAt, isNotNull);
    });
    
    test('更新不存在的用户应返回false', () {
      final result = dataService.updateUser('non-existent', testUser);
      expect(result, isFalse);
    });
    
    test('删除用户', () {
      dataService.saveUser(testUser);
      
      final result = dataService.deleteUser('1');
      expect(result, isTrue);
      
      final user = dataService.getUser('1');
      expect(user, isNull);
    });
    
    test('删除不存在的用户应返回false', () {
      final result = dataService.deleteUser('non-existent');
      expect(result, isFalse);
    });
    
    test('按条件查询用户', () {
      dataService.saveUser(User(
        id: '1',
        name: '张三',
        email: 'zhang@example.com',
        age: 25,
      ));
      dataService.saveUser(User(
        id: '2',
        name: '李四',
        email: 'li@example.com',
        age: 30,
      ));
      dataService.saveUser(User(
        id: '3',
        name: '张五',
        email: 'zhang5@example.com',
        age: 35,
      ));
      
      // 按名字查询
      final zhangUsers = dataService.queryUsers(name: '张');
      expect(zhangUsers.length, equals(2));
      
      // 按年龄范围查询
      final ageRangeUsers = dataService.queryUsers(minAge: 26, maxAge: 35);
      expect(ageRangeUsers.length, equals(2));
      
      // 组合查询
      final combinedUsers = dataService.queryUsers(
        name: '张',
        minAge: 30,
      );
      expect(combinedUsers.length, equals(1));
      expect(combinedUsers.first.name, equals('张五'));
    });
    
    test('保存和获取通用数据', () {
      final data = {
        'key1': 'value1',
        'key2': 123,
        'key3': true,
      };
      
      dataService.saveData('config', data);
      final retrievedData = dataService.getData('config');
      
      expect(retrievedData, isNotNull);
      expect(retrievedData?['key1'], equals('value1'));
      expect(retrievedData?['key2'], equals(123));
      expect(retrievedData?['key3'], equals(true));
    });
    
    test('清空所有数据', () {
      dataService.saveUser(testUser);
      dataService.saveData('test', {'data': 'value'});
      
      dataService.clearAll();
      
      expect(dataService.getAllUsers(), isEmpty);
      expect(dataService.getData('test'), isNull);
    });
    
    test('获取统计信息', () {
      dataService.saveUser(User(
        id: '1',
        name: '成年人1',
        email: 'adult1@example.com',
        age: 25,
      ));
      dataService.saveUser(User(
        id: '2',
        name: '成年人2',
        email: 'adult2@example.com',
        age: 30,
      ));
      dataService.saveUser(User(
        id: '3',
        name: '未成年人',
        email: 'minor@example.com',
        age: 16,
      ));
      
      final stats = dataService.getStatistics();
      
      expect(stats['totalUsers'], equals(3));
      expect(stats['averageAge'], closeTo(23.67, 0.01));
      expect(stats['adultsCount'], equals(2));
      expect(stats['minorsCount'], equals(1));
    });
    
    test('空数据库的统计信息', () {
      final stats = dataService.getStatistics();
      
      expect(stats['totalUsers'], equals(0));
      expect(stats['averageAge'], equals(0));
      expect(stats['adultsCount'], equals(0));
      expect(stats['minorsCount'], equals(0));
    });
  });
}