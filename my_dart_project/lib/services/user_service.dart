import '../models/user.dart';

/// 用户服务接口
abstract class IUserService {
  Future<User?> getUserById(String id);
  Future<List<User>> getAllUsers();
  Future<User> createUser(String name, String email);
  Future<bool> deleteUser(String id);
}

/// 用户服务实现类
class UserService implements IUserService {
  final List<User> _users = [];
  static int _nextId = 1;
  
  /// 私有构造函数
  UserService._();
  
  /// 单例实例
  static final UserService _instance = UserService._();
  
  /// 获取单例实例
  static UserService get instance => _instance;
  
  @override
  Future<User?> getUserById(String id) async {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<List<User>> getAllUsers() async {
    return List.unmodifiable(_users);
  }
  
  @override
  Future<User> createUser(String name, String email) async {
    if (name.isEmpty) {
      throw ArgumentError('用户名不能为空');
    }
    
    if (email.isEmpty) {
      throw ArgumentError('邮箱不能为空');
    }
    
    // 检查邮箱是否已存在
    final existingUser = _users.where((user) => user.email == email);
    if (existingUser.isNotEmpty) {
      throw ArgumentError('邮箱已存在');
    }
    
    final user = User(
      id: _nextId.toString(),
      name: name,
      email: email,
    );
    
    if (!user.isValidEmail()) {
      throw ArgumentError('邮箱格式不正确');
    }
    
    _users.add(user);
    _nextId++;
    
    return user;
  }
  
  @override
  Future<bool> deleteUser(String id) async {
    final userIndex = _users.indexWhere((user) => user.id == id);
    if (userIndex != -1) {
      _users.removeAt(userIndex);
      return true;
    }
    return false;
  }
  
  /// 获取用户数量
  int get userCount => _users.length;
  
  /// 清空所有用户
  void clearAllUsers() {
    _users.clear();
    _nextId = 1;
  }
}