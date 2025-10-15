import 'package:my_dart_app/advanced_example.dart';

/// 高级面向对象示例程序入口
void main() {
  print('🎨 Dart 面向对象编程高级示例\n');
  
  // 创建形状管理器
  final manager = ShapeManager();
  
  // 使用工厂模式创建形状
  print('📐 创建形状...\n');
  final circle = ShapeFactory.createCircle(5.0);
  final rectangle = ShapeFactory.createRectangle(4.0, 6.0);
  final square = ShapeFactory.createSquare(5.0);
  
  // 添加形状到管理器
  manager.addShape(circle);
  manager.addShape(rectangle);
  manager.addShape(square);
  
  // 显示所有形状信息（多态性）
  manager.displayAllShapes();
  
  // 显示总面积
  print('\n📊 统计信息:');
  print('形状总数: ${manager.shapeCount}');
  print('总面积: ${manager.getTotalArea().toStringAsFixed(2)}');
  
  // 演示Mixin功能
  print('\n🖌️  绘制演示:');
  circle.draw();
  rectangle.draw();
  circle.erase();
  
  // 展示特定类的额外功能
  print('\n✨ 特殊功能:');
  print('矩形是正方形吗? ${rectangle.isSquare ? "是" : "否"}');
  print('正方形是正方形吗? ${square.isSquare ? "是" : "否"}');
}
