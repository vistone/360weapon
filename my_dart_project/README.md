# My Dart Project

一个基于面向对象编程模式的 Dart 示例项目，展示了现代 Dart 开发的最佳实践。

## 🚀 功能特性

### 📊 计算器模块
- 单例模式实现的计算器类
- 支持基本数学运算（加、减、乘、除）
- 完整的异常处理

### 👥 用户管理模块
- 用户模型类，包含验证和序列化功能
- 用户服务类，实现CRUD操作
- 邮箱格式验证
- JSON序列化/反序列化

### 🧪 测试覆盖
- 17个单元测试，覆盖所有核心功能
- 测试驱动开发(TDD)实践
- 异常处理测试

## 📁 项目结构

```
my_dart_project/
├── bin/
│   └── my_dart_project.dart     # 应用程序入口点
├── lib/
│   ├── my_dart_project.dart     # 主库文件
│   ├── models/
│   │   └── user.dart           # 用户模型
│   └── services/
│       └── user_service.dart   # 用户服务
├── test/
│   └── my_dart_project_test.dart # 单元测试
├── pubspec.yaml                 # 项目配置
└── README.md                   # 项目说明
```

## 🛠️ 安装和运行

### 前置要求
- Dart SDK 3.9.4 或更高版本

### 安装依赖
```bash
dart pub get
```

### 运行应用程序
```bash
# 基本运行
dart run

# 或者使用完整路径
dart run bin/my_dart_project.dart

# 带命令行参数运行
dart run bin/my_dart_project.dart 参数1 参数2 参数3
```

### 运行测试
```bash
dart test
```

## 💡 设计模式

### 单例模式
- `Calculator` 类使用单例模式确保全局唯一实例
- `UserService` 类同样实现单例模式

### 工厂模式
- `User.fromJson()` 工厂构造函数用于从JSON创建用户实例

### 接口分离
- `IUserService` 接口定义用户服务的契约
- `UserService` 类实现具体功能

## 🎯 面向对象特性

### 封装
- 私有成员使用下划线前缀
- 通过getter方法提供受控访问

### 继承和多态
- 抽象接口 `IUserService`
- 具体实现 `UserService`

### 数据验证
- 邮箱格式验证
- 输入参数验证
- 异常处理

## 📊 测试结果

所有 17 个测试用例均通过：
- ✅ Calculator 测试 (7个测试)
- ✅ User 模型测试 (4个测试) 
- ✅ UserService 测试 (6个测试)

## 🔧 开发规范

项目严格遵循以下规范：
- Dart 官方编码规范
- 面向对象编程原则
- 单一职责原则
- 依赖倒置原则
- 接口隔离原则

## 📝 许可证

本项目仅用于学习和演示目的。
