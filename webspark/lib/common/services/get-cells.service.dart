import 'package:flutter/material.dart';
import 'package:webspark/common/helpers/app-colors.dart';
import 'package:webspark/common/services/get-cells-nearby.service.dart';
import 'package:webspark/store/models/cell.model.dart';
import 'package:webspark/store/models/task.model.dart';

List<CellModel> getCells(TaskModel task) {
  List<CellModel> cellsList = <CellModel>[];

  int gridHeight = task.field.length;
  int gridWigth = task.field.first.length;

  for (int i = 0; i < gridHeight; i++) {
    for (int j = 0; j < gridWigth; j++) {
      bool isStart = task.start.x == i && task.start.y == j;
      bool isEnd = task.end.x == i && task.end.y == j;
      bool isBlocked = task.field[i][j] == 'X';

      Color color = AppColors.empty;
      if (task.steps != null && task.steps!.isNotEmpty) {
        for (CellModel step in task.steps!) {
          if (step.x == i && step.y == j) {
            color = AppColors.closest;
          }
        }
      }

      if (isStart) {
        color = AppColors.start;
      } else if (isEnd) {
        color = AppColors.end;
      } else if (isBlocked) {
        color = AppColors.blocked;
      }

      cellsList.add(CellModel(
        x: i,
        y: j,
        isStart: isStart,
        isEnd: isEnd,
        isBlocked: isBlocked,
        color: color,
      ));
    }
  }
  for (CellModel currCell in cellsList) {
    currCell.cellsNearby = getCellsNearby(currCell, cellsList);
  }

  return cellsList;
}
