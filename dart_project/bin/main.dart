import 'package:dart_project/dart_project.dart' as dart_project;

/// 主程序入口点
void main(List<String> arguments) {
  print('Hello world: ${dart_project.calculate()}!');
  
  // 处理命令行参数
  if (arguments.isNotEmpty) {
    print('您提供的参数: ${arguments.join(', ')}');
  }
  
  // 创建应用实例并运行
  final app = dart_project.Application();
  app.run();
}