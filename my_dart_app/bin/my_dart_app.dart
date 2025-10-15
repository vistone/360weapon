import 'package:my_dart_app/my_dart_app.dart';

/// 应用程序入口点
void main(List<String> arguments) {
  // 创建应用程序实例
  final app = MyDartApp();
  
  // 运行应用程序
  print('欢迎使用 Dart 应用程序！');
  app.run();
  
  // 显示参数信息
  if (arguments.isNotEmpty) {
    print('命令行参数: ${arguments.join(", ")}');
  }
}
