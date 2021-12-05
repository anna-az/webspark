import 'package:flutter/material.dart';
import 'package:webspark/common/helpers/app-colors.dart';

class CellModel {
  CellModel(
      {required this.x,
      required this.y,
      this.isStart = false,
      this.isEnd = false,
      this.isBlocked = false,
      this.isWay = false,
      this.color = AppColors.empty,
      this.cellsNearby});
  int x;
  int y;
  bool isStart;
  bool isEnd;
  bool isBlocked;
  bool isWay;
  Color color;
  List<CellModel>? cellsNearby;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'x': x,
        'y': y,
      };
}
