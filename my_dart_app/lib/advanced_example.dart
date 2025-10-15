/// 高级面向对象编程示例
/// 
/// 此文件展示了Dart中的高级OOP特性：
/// - 抽象类
/// - 接口
/// - 继承
/// - 多态
/// - Mixin
library;

/// 抽象基类 - 定义形状的通用接口
abstract class Shape {
  /// 获取形状名称
  String get name;
  
  /// 计算面积（抽象方法）
  double calculateArea();
  
  /// 计算周长（抽象方法）
  double calculatePerimeter();
  
  /// 显示形状信息
  void displayInfo() {
    print('形状: $name');
    print('面积: ${calculateArea().toStringAsFixed(2)}');
    print('周长: ${calculatePerimeter().toStringAsFixed(2)}');
  }
}

/// Mixin - 可绘制特性
mixin Drawable {
  /// 绘制形状
  void draw() {
    print('正在绘制...');
  }
  
  /// 擦除形状
  void erase() {
    print('正在擦除...');
  }
}

/// 圆形类 - 继承自Shape并混入Drawable
class Circle extends Shape with Drawable {
  final double _radius;
  
  /// 构造函数
  Circle(this._radius) {
    if (_radius <= 0) {
      throw ArgumentError('半径必须大于0');
    }
  }
  
  @override
  String get name => '圆形';
  
  /// 获取半径
  double get radius => _radius;
  
  @override
  double calculateArea() {
    return 3.14159 * _radius * _radius;
  }
  
  @override
  double calculatePerimeter() {
    return 2 * 3.14159 * _radius;
  }
}

/// 矩形类 - 继承自Shape并混入Drawable
class Rectangle extends Shape with Drawable {
  final double _width;
  final double _height;
  
  /// 构造函数
  Rectangle(this._width, this._height) {
    if (_width <= 0 || _height <= 0) {
      throw ArgumentError('宽度和高度必须大于0');
    }
  }
  
  @override
  String get name => '矩形';
  
  /// 获取宽度
  double get width => _width;
  
  /// 获取高度
  double get height => _height;
  
  @override
  double calculateArea() {
    return _width * _height;
  }
  
  @override
  double calculatePerimeter() {
    return 2 * (_width + _height);
  }
  
  /// 判断是否为正方形
  bool get isSquare => _width == _height;
}

/// 图形管理器类 - 展示多态性
class ShapeManager {
  final List<Shape> _shapes = [];
  
  /// 添加形状
  void addShape(Shape shape) {
    _shapes.add(shape);
    print('已添加 ${shape.name}');
  }
  
  /// 显示所有形状信息
  void displayAllShapes() {
    if (_shapes.isEmpty) {
      print('没有形状');
      return;
    }
    
    print('\n=== 所有形状信息 ===');
    for (var i = 0; i < _shapes.length; i++) {
      print('\n形状 ${i + 1}:');
      _shapes[i].displayInfo();
    }
  }
  
  /// 计算总面积
  double getTotalArea() {
    return _shapes.fold(0.0, (sum, shape) => sum + shape.calculateArea());
  }
  
  /// 获取形状数量
  int get shapeCount => _shapes.length;
}

/// 工厂类 - 创建形状
class ShapeFactory {
  /// 创建圆形
  static Circle createCircle(double radius) {
    return Circle(radius);
  }
  
  /// 创建矩形
  static Rectangle createRectangle(double width, double height) {
    return Rectangle(width, height);
  }
  
  /// 创建正方形
  static Rectangle createSquare(double side) {
    return Rectangle(side, side);
  }
}
