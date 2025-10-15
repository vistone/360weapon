import 'package:test/test.dart';
import 'package:dart_project/src/models/user.dart';

void main() {
  group('User 模型测试', () {
    late User testUser;
    
    setUp(() {
      testUser = User(
        id: 'test-123',
        name: '测试用户',
        email: 'test@example.com',
        age: 25,
      );
    });
    
    test('创建用户实例', () {
      expect(testUser.id, equals('test-123'));
      expect(testUser.name, equals('测试用户'));
      expect(testUser.email, equals('test@example.com'));
      expect(testUser.age, equals(25));
      expect(testUser.createdAt, isA<DateTime>());
      expect(testUser.updatedAt, isNull);
    });
    
    test('从JSON创建用户', () {
      final json = {
        'id': 'json-123',
        'name': 'JSON用户',
        'email': 'json@example.com',
        'age': 30,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': null,
      };
      
      final user = User.fromJson(json);
      
      expect(user.id, equals('json-123'));
      expect(user.name, equals('JSON用户'));
      expect(user.email, equals('json@example.com'));
      expect(user.age, equals(30));
    });
    
    test('转换为JSON', () {
      final json = testUser.toJson();
      
      expect(json['id'], equals('test-123'));
      expect(json['name'], equals('测试用户'));
      expect(json['email'], equals('test@example.com'));
      expect(json['age'], equals(25));
      expect(json['createdAt'], isA<String>());
      expect(json['updatedAt'], isNull);
    });
    
    test('copyWith方法测试', () {
      final updatedUser = testUser.copyWith(
        name: '更新的用户',
        age: 26,
        updatedAt: DateTime.now(),
      );
      
      expect(updatedUser.id, equals(testUser.id));
      expect(updatedUser.name, equals('更新的用户'));
      expect(updatedUser.email, equals(testUser.email));
      expect(updatedUser.age, equals(26));
      expect(updatedUser.updatedAt, isNotNull);
    });
    
    test('邮箱验证测试', () {
      expect(testUser.isEmailValid, isTrue);
      
      final invalidEmailUser = User(
        id: '1',
        name: 'Test',
        email: 'invalid-email',
        age: 25,
      );
      
      expect(invalidEmailUser.isEmailValid, isFalse);
    });
    
    test('成年人检查测试', () {
      expect(testUser.isAdult, isTrue);
      
      final minorUser = User(
        id: '2',
        name: '未成年',
        email: 'minor@example.com',
        age: 16,
      );
      
      expect(minorUser.isAdult, isFalse);
    });
    
    test('相等性测试', () {
      final sameUser = User(
        id: 'test-123',
        name: '不同名字',
        email: 'different@example.com',
        age: 30,
      );
      
      final differentUser = User(
        id: 'different-id',
        name: '测试用户',
        email: 'test@example.com',
        age: 25,
      );
      
      expect(testUser == sameUser, isTrue);
      expect(testUser == differentUser, isFalse);
    });
    
    test('哈希码测试', () {
      final sameIdUser = User(
        id: 'test-123',
        name: '其他名字',
        email: 'other@example.com',
        age: 35,
      );
      
      expect(testUser.hashCode, equals(sameIdUser.hashCode));
    });
  });
}