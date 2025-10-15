# Dart 项目 - My Dart App

这是一个使用面向对象编程模式构建的 Dart 控制台应用程序示例。

## 项目结构

```
my_dart_app/
├── bin/              # 应用程序入口点
│   └── my_dart_app.dart
├── lib/              # 核心业务逻辑（面向对象设计）
│   └── my_dart_app.dart
├── test/             # 单元测试
│   └── my_dart_app_test.dart
├── pubspec.yaml      # 项目依赖配置
└── README.md         # 项目说明文档
```

## 功能特点

- ✅ 完全采用面向对象设计模式
- ✅ 包含完整的单元测试
- ✅ 遵循 Dart 最佳实践
- ✅ 使用类封装和模块化设计

## 环境要求

- Dart SDK: ^3.9.4

## 快速开始

### 运行应用程序

```bash
export PATH="/usr/lib/dart/bin:$PATH"
dart run
```

### 运行测试

```bash
dart test
```

### 分析代码

```bash
dart analyze
```

## 核心类说明

### Calculator 类
计算器类，负责数学计算逻辑。

- **构造函数**: `Calculator({int multiplier = 6})`
- **方法**: `calculate(int value)` - 执行乘法运算
- **属性**: `multiplier` - 获取乘数值

### MyDartApp 类
应用程序主类，负责协调应用程序的运行。

- **构造函数**: `MyDartApp()`
- **方法**: `run()` - 运行应用程序
- **属性**: `calculator` - 获取计算器实例

## 开发指南

本项目严格遵循面向对象编程原则：

1. **封装**: 使用私有字段和公共getter方法
2. **单一职责**: 每个类只负责一个特定功能
3. **可测试性**: 所有类都支持单元测试
4. **文档化**: 使用Dart文档注释说明类和方法

## 许可证

本项目仅供学习和参考使用。
