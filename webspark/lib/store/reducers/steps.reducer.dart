import 'package:redux/redux.dart';
import 'package:webspark/common/helpers/app-colors.dart';
import 'package:webspark/common/services/get-cells.service.dart';
import 'package:webspark/common/services/get-step.service.dart';
import 'package:webspark/store/actions/task.actions.dart';
import 'package:webspark/store/models/cell.model.dart';
import 'package:webspark/store/models/task.model.dart';

final Reducer<List<TaskModel>?> getTasksReducers = combineReducers<
    List<TaskModel>?>(<List<TaskModel>? Function(List<TaskModel>?, dynamic)>[
  TypedReducer<List<TaskModel>?, GetTasksSuccess>(_getTasks),
]);

List<TaskModel> _getTasks(List<TaskModel>? tasks, GetTasksSuccess action) {
  List<TaskModel> newTasks = <TaskModel>[...action.tasks];
  List<CellModel> steps = <CellModel>[];
  List<CellModel> cellsList;

  for (TaskModel task in newTasks) {
    cellsList = getCells(task);
    final CellModel endStep = cellsList.firstWhere((cell) => cell.isEnd);
    CellModel currentStep = cellsList.firstWhere((cell) => cell.isStart);
    steps.add(currentStep);
    while (currentStep.x != endStep.x && currentStep.y != endStep.y) {
      if (currentStep.cellsNearby == null) {
        break;
      }
      CellModel cellInGrid = cellsList.firstWhere((gridCell) =>
          currentStep.x == gridCell.x && currentStep.y == gridCell.y);
      CellModel nextStep = getStep(cellInGrid, endStep);
      if (nextStep.x == endStep.x && nextStep.y == endStep.y) {
        currentStep = endStep;
        break;
      }
      nextStep.color = AppColors.closest;
      nextStep.isWay = true;
      steps.add(nextStep);
      currentStep = cellsList.firstWhere(
          (gridCell) => nextStep.x == gridCell.x && nextStep.y == gridCell.y);
    }
    steps.add(endStep);
    task.steps = <CellModel>[...steps];
    steps = <CellModel>[];
  }

  return action.tasks;
}
