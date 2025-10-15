/// Dart项目的主库文件
library dart_project;

// 导出所有公共API
export 'src/application.dart';
export 'src/calculator.dart';
export 'src/models/user.dart';
export 'src/services/data_service.dart';

/// 计算示例函数
int calculate() {
  return 6 * 7;
}