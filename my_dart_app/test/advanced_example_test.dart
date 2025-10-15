import 'package:my_dart_app/advanced_example.dart';
import 'package:test/test.dart';

void main() {
  group('Circle 类测试', () {
    test('应该正确计算圆形面积', () {
      final circle = Circle(5.0);
      expect(circle.calculateArea(), closeTo(78.54, 0.01));
    });

    test('应该正确计算圆形周长', () {
      final circle = Circle(5.0);
      expect(circle.calculatePerimeter(), closeTo(31.42, 0.01));
    });

    test('半径应该是只读属性', () {
      final circle = Circle(5.0);
      expect(circle.radius, 5.0);
    });

    test('负半径应该抛出异常', () {
      expect(() => Circle(-5.0), throwsArgumentError);
    });

    test('零半径应该抛出异常', () {
      expect(() => Circle(0), throwsArgumentError);
    });
  });

  group('Rectangle 类测试', () {
    test('应该正确计算矩形面积', () {
      final rectangle = Rectangle(4.0, 6.0);
      expect(rectangle.calculateArea(), 24.0);
    });

    test('应该正确计算矩形周长', () {
      final rectangle = Rectangle(4.0, 6.0);
      expect(rectangle.calculatePerimeter(), 20.0);
    });

    test('应该正确识别正方形', () {
      final square = Rectangle(5.0, 5.0);
      expect(square.isSquare, true);
    });

    test('应该正确识别非正方形', () {
      final rectangle = Rectangle(4.0, 6.0);
      expect(rectangle.isSquare, false);
    });

    test('负宽度应该抛出异常', () {
      expect(() => Rectangle(-4.0, 6.0), throwsArgumentError);
    });

    test('负高度应该抛出异常', () {
      expect(() => Rectangle(4.0, -6.0), throwsArgumentError);
    });
  });

  group('ShapeManager 类测试', () {
    late ShapeManager manager;

    setUp(() {
      manager = ShapeManager();
    });

    test('初始状态应该没有形状', () {
      expect(manager.shapeCount, 0);
    });

    test('应该能添加形状', () {
      final circle = Circle(5.0);
      manager.addShape(circle);
      expect(manager.shapeCount, 1);
    });

    test('应该能添加多个形状', () {
      manager.addShape(Circle(5.0));
      manager.addShape(Rectangle(4.0, 6.0));
      expect(manager.shapeCount, 2);
    });

    test('应该正确计算总面积', () {
      manager.addShape(Rectangle(4.0, 6.0)); // 面积 24
      manager.addShape(Rectangle(5.0, 5.0)); // 面积 25
      expect(manager.getTotalArea(), 49.0);
    });

    test('空管理器总面积应该为0', () {
      expect(manager.getTotalArea(), 0.0);
    });
  });

  group('ShapeFactory 类测试', () {
    test('应该能创建圆形', () {
      final circle = ShapeFactory.createCircle(5.0);
      expect(circle, isA<Circle>());
      expect(circle.radius, 5.0);
    });

    test('应该能创建矩形', () {
      final rectangle = ShapeFactory.createRectangle(4.0, 6.0);
      expect(rectangle, isA<Rectangle>());
      expect(rectangle.width, 4.0);
      expect(rectangle.height, 6.0);
    });

    test('应该能创建正方形', () {
      final square = ShapeFactory.createSquare(5.0);
      expect(square, isA<Rectangle>());
      expect(square.isSquare, true);
      expect(square.width, 5.0);
      expect(square.height, 5.0);
    });
  });

  group('Drawable Mixin 测试', () {
    test('圆形应该具有绘制功能', () {
      final circle = Circle(5.0);
      expect(() => circle.draw(), prints(contains('正在绘制')));
    });

    test('矩形应该具有绘制功能', () {
      final rectangle = Rectangle(4.0, 6.0);
      expect(() => rectangle.draw(), prints(contains('正在绘制')));
    });

    test('圆形应该具有擦除功能', () {
      final circle = Circle(5.0);
      expect(() => circle.erase(), prints(contains('正在擦除')));
    });
  });

  group('多态性测试', () {
    test('应该能将不同形状作为Shape类型处理', () {
      final List<Shape> shapes = [
        Circle(5.0),
        Rectangle(4.0, 6.0),
      ];
      
      expect(shapes.length, 2);
      expect(shapes[0], isA<Shape>());
      expect(shapes[1], isA<Shape>());
    });

    test('应该能调用Shape接口的方法', () {
      final Shape shape1 = Circle(5.0);
      final Shape shape2 = Rectangle(4.0, 6.0);
      
      expect(shape1.calculateArea(), isPositive);
      expect(shape2.calculateArea(), isPositive);
    });
  });
}
