# Dart 项目

这是一个标准的 Dart 项目，包含了完整的项目结构和示例代码。

## 项目结构

```
dart_project/
├── bin/                  # 可执行文件目录
│   └── main.dart        # 主程序入口
├── lib/                 # 库文件目录
│   ├── dart_project.dart    # 主库文件
│   └── src/            # 源代码目录
│       ├── application.dart      # 应用主类
│       ├── calculator.dart       # 计算器类
│       ├── models/               # 数据模型
│       │   └── user.dart        # 用户模型
│       └── services/            # 服务层
│           └── data_service.dart # 数据服务
├── test/               # 测试文件目录
│   ├── calculator_test.dart     # 计算器测试
│   ├── user_test.dart           # 用户模型测试
│   └── data_service_test.dart  # 数据服务测试
├── doc/                # 文档目录
├── pubspec.yaml       # 项目配置文件
└── README.md          # 项目说明
```

## 快速开始

### 安装 Dart SDK

1. 访问 [Dart 官网](https://dart.dev/get-dart) 下载并安装 Dart SDK
2. 验证安装：
   ```bash
   dart --version
   ```

### 安装依赖

在项目根目录运行：
```bash
dart pub get
```

### 运行项目

运行主程序：
```bash
dart run bin/main.dart
```

带参数运行：
```bash
dart run bin/main.dart arg1 arg2
```

### 运行测试

运行所有测试：
```bash
dart test
```

运行特定测试文件：
```bash
dart test test/calculator_test.dart
```

查看测试覆盖率：
```bash
dart test --coverage coverage
dart pub global activate coverage
format_coverage --lcov --in=coverage --out=coverage/lcov.info --packages=.packages --report-on=lib
```

## 主要功能

### Application 类
- 应用程序的主入口类
- 集成了所有功能模块
- 使用依赖注入模式

### Calculator 类
提供基础数学运算功能：
- 四则运算（加、减、乘、除）
- 幂运算
- 阶乘计算

### User 模型
用户数据模型，包含：
- 基本属性（id、姓名、邮箱、年龄）
- JSON 序列化/反序列化
- 数据验证（邮箱验证、成年检查）
- 不可变对象模式（copyWith）

### DataService 服务
数据管理服务，提供：
- 用户的 CRUD 操作
- 条件查询功能
- 统计信息生成
- 通用数据存储

## 开发指南

### 代码风格

本项目遵循 Dart 官方代码风格指南：
- 使用 `lints` 包进行代码检查
- 运行 `dart analyze` 检查代码问题
- 运行 `dart format .` 格式化代码

### 添加新功能

1. 在 `lib/src/` 下创建新的功能模块
2. 在 `lib/dart_project.dart` 中导出公共 API
3. 编写对应的单元测试
4. 更新文档

### 测试规范

- 每个类都应有对应的测试文件
- 测试覆盖率应保持在 80% 以上
- 使用 `group` 组织相关测试
- 使用 `setUp` 和 `tearDown` 管理测试状态

## 依赖包

### 生产依赖
- `http`: HTTP 客户端库
- `path`: 路径处理工具

### 开发依赖
- `test`: 单元测试框架
- `lints`: 代码质量检查
- `build_runner`: 代码生成工具

## 许可证

MIT License

## 联系方式

如有问题，请提交 Issue 或 Pull Request。