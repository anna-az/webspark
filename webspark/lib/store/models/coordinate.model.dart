class CoordinateModel {
  CoordinateModel({
    required this.x,
    required this.y,
  });
  int x;
  int y;

  static CoordinateModel fromJson(Map<String, dynamic> json) {
    return CoordinateModel(
      x: json['x'] as int,
      y: json['y'] as int,
    );
  }
}
