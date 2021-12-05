import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:webspark/store/epics/check-url.epic.dart';
import 'package:webspark/store/epics/error.epic.dart';
import 'package:webspark/store/epics/rout.epics.dart';
import 'package:webspark/store/epics/steps.epic.dart';
import 'package:webspark/store/epics/task.epic.dart';
import 'package:webspark/store/models/cell.model.dart';
import 'package:webspark/store/models/task.model.dart';
import 'package:webspark/store/reducers/reducer.dart';

AppState initialState = AppState(
  cells: <CellModel>[],
  tasks: <TaskModel>[],
  isLoading: false,
  notify: null,
);
final Store<AppState> store = Store<AppState>(appStateReducer,
    initialState: initialState,
    middleware: <
        dynamic Function(Store<AppState>, dynamic, dynamic Function(dynamic))>[
      LoggingMiddleware<dynamic>.printer(),
      EpicMiddleware<dynamic>(errorEpic),
      EpicMiddleware<dynamic>(routeEpic),
      EpicMiddleware<dynamic>(routePopEpic),
      EpicMiddleware<dynamic>(routePushReplacmentEpic),
      EpicMiddleware<dynamic>(getTasksEpic),
      EpicMiddleware<dynamic>(sendStepsEpic),
      EpicMiddleware<dynamic>(checkUrlEpic),
      EpicMiddleware<dynamic>(checkErrorEpic),
    ]);
