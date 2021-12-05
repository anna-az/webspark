import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:webspark/common/helpers/app-colors.dart';
import 'package:webspark/common/services/get-cells-nearby.service.dart';
import 'package:webspark/store/actions/task.actions.dart';
import 'package:webspark/store/models/cell.model.dart';

final Reducer<List<CellModel>?> getCellsReducers = combineReducers<
    List<CellModel>?>(<List<CellModel>? Function(List<CellModel>?, dynamic)>[
  TypedReducer<List<CellModel>?, GetTasksSuccess>(_getCells),
]);

List<CellModel> _getCells(List<CellModel>? tasks, GetTasksSuccess action) {
  List<CellModel> cellsList = <CellModel>[];

  int gridHeight = action.tasks.first.field.length;
  int gridWigth = action.tasks.first.field.first.length;

  for (int i = 0; i < gridHeight; i++) {
    for (int j = 0; j < gridWigth; j++) {
      bool isStart =
          action.tasks.first.start.x == i && action.tasks.first.start.y == j;
      bool isEnd =
          action.tasks.first.end.x == i && action.tasks.first.end.y == j;
      bool isBlocked = action.tasks.first.field[i][j] == 'X';
      Color color = AppColors.empty;
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
