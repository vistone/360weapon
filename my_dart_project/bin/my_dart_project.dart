import 'package:my_dart_project/my_dart_project.dart';

/// 应用程序入口点
Future<void> main(List<String> arguments) async {
  try {
    // 创建应用程序实例并运行
    final app = MyDartApplication();
    await app.run();
    
    // 处理命令行参数
    if (arguments.isNotEmpty) {
      print('\n📝 收到的命令行参数:');
      for (int i = 0; i < arguments.length; i++) {
        print('   参数 ${i + 1}: ${arguments[i]}');
      }
    } else {
      print('\n💡 提示: 您可以通过命令行传递参数来测试参数处理功能');
      print('   例如: dart run arg1 arg2 arg3');
    }
    
    print('\n🎉 应用程序运行完成!');
  } catch (e) {
    print('❌ 应用程序运行时发生错误: $e');
  }
}
