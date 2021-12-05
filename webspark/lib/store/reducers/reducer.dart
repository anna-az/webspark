import 'package:webspark/common/models/notify.model.dart';
import 'package:webspark/store/models/cell.model.dart';
import 'package:webspark/store/models/task.model.dart';
import 'package:webspark/store/reducers/cells.reducer.dart';
import 'package:webspark/store/reducers/loader.reducer.dart';
import 'package:webspark/store/reducers/notify.reducer.dart';
import 'package:webspark/store/reducers/steps.reducer.dart';

class AppState {
  AppState({
    this.cells,
    this.tasks,
    this.isLoading = false,
    this.notify,
  });
  List<CellModel>? cells;
  List<TaskModel>? tasks;
  bool isLoading;
  NotifyModel? notify;
}

AppState appStateReducer(AppState state, dynamic action) {
  return AppState(
    cells: getCellsReducers(state.cells, action),
    tasks: getTasksReducers(state.tasks, action),
    isLoading: isLoadingReducers(state.isLoading, action),
    notify: notifyReducers(state.notify, action),
  );
}
