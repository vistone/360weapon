/// 用户模型类
class User {
  final String _id;
  final String _name;
  final String _email;
  DateTime _createdAt;
  
  /// 构造函数
  User({
    required String id,
    required String name,
    required String email,
    DateTime? createdAt,
  }) : _id = id,
        _name = name,
        _email = email,
        _createdAt = createdAt ?? DateTime.now();
  
  /// 获取用户ID
  String get id => _id;
  
  /// 获取用户名
  String get name => _name;
  
  /// 获取邮箱
  String get email => _email;
  
  /// 获取创建时间
  DateTime get createdAt => _createdAt;
  
  /// 验证邮箱格式
  bool isValidEmail() {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(_email);
  }
  
  /// 转换为JSON格式
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'email': _email,
      'createdAt': _createdAt.toIso8601String(),
    };
  }
  
  /// 从JSON创建用户实例
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
  
  /// 重写toString方法
  @override
  String toString() {
    return 'User(id: $_id, name: $_name, email: $_email)';
  }
  
  /// 重写相等性比较
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other._id == _id;
  }
  
  /// 重写hashCode
  @override
  int get hashCode => _id.hashCode;
}