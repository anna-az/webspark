import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webspark/common/services/task.service.dart';
import 'package:webspark/store/actions/error.actions.dart';
import 'package:webspark/store/actions/task.actions.dart';
import 'package:webspark/store/models/task.model.dart';
import 'package:webspark/store/store.dart' as s;

Stream<void> getTasksEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) => action is GetTasksPending).switchMap(
      (dynamic action) => Stream<List<TaskModel>>.fromFuture(getTasks())
              .expand<dynamic>((List<TaskModel> tasks) {
            return <dynamic>[
              GetTasksSuccess(tasks),
            ];
          }).handleError((dynamic e) {
            s.store.dispatch(SetError(e));
          }));
}
