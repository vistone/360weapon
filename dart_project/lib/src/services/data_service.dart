import '../models/user.dart';

/// 数据服务类，负责数据的存储和检索
class DataService {
  // 使用Map模拟内存数据库
  final Map<String, User> _userDatabase = {};
  final Map<String, Map<String, dynamic>> _generalDatabase = {};
  
  /// 保存用户
  void saveUser(User user) {
    _userDatabase[user.id] = user;
    print('用户 ${user.name} 已保存');
  }
  
  /// 获取用户
  User? getUser(String id) {
    return _userDatabase[id];
  }
  
  /// 获取所有用户
  List<User> getAllUsers() {
    return _userDatabase.values.toList();
  }
  
  /// 更新用户
  bool updateUser(String id, User updatedUser) {
    if (_userDatabase.containsKey(id)) {
      _userDatabase[id] = updatedUser.copyWith(
        updatedAt: DateTime.now(),
      );
      return true;
    }
    return false;
  }
  
  /// 删除用户
  bool deleteUser(String id) {
    return _userDatabase.remove(id) != null;
  }
  
  /// 根据条件查询用户
  List<User> queryUsers({
    String? name,
    int? minAge,
    int? maxAge,
  }) {
    return _userDatabase.values.where((user) {
      if (name != null && !user.name.contains(name)) {
        return false;
      }
      if (minAge != null && user.age < minAge) {
        return false;
      }
      if (maxAge != null && user.age > maxAge) {
        return false;
      }
      return true;
    }).toList();
  }
  
  /// 保存通用数据
  void saveData(String key, Map<String, dynamic> data) {
    _generalDatabase[key] = data;
  }
  
  /// 获取通用数据
  Map<String, dynamic>? getData(String key) {
    return _generalDatabase[key];
  }
  
  /// 清空所有数据
  void clearAll() {
    _userDatabase.clear();
    _generalDatabase.clear();
  }
  
  /// 获取统计信息
  Map<String, dynamic> getStatistics() {
    final users = _userDatabase.values.toList();
    
    if (users.isEmpty) {
      return {
        'totalUsers': 0,
        'averageAge': 0,
        'adultsCount': 0,
        'minorsCount': 0,
      };
    }
    
    final totalAge = users.fold<int>(0, (sum, user) => sum + user.age);
    final adultsCount = users.where((user) => user.isAdult).length;
    
    return {
      'totalUsers': users.length,
      'averageAge': totalAge / users.length,
      'adultsCount': adultsCount,
      'minorsCount': users.length - adultsCount,
    };
  }
}