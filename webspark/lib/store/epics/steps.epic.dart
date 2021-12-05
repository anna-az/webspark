import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webspark/common/services/send-steps.service.dart';
import 'package:webspark/screens/tasks-list.screen.dart';
import 'package:webspark/store/actions/error.actions.dart';
import 'package:webspark/store/actions/rout.actions.dart';
import 'package:webspark/store/actions/steps.actions.dart';
import 'package:webspark/store/models/task.model.dart';
import 'package:webspark/store/store.dart' as s;

Stream<void> sendStepsEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions
      .where((dynamic action) => action is SendStepsPending)
      .switchMap((dynamic action) => Stream<String>.fromFuture(
                  sendSteps(action.tasks as List<TaskModel>, action.path))
              .expand<dynamic>((String message) {
            return <dynamic>[
              SendStepsSuccess(),
              PushAction(TasksListScreen()),
            ];
          }).handleError((dynamic e) {
            s.store.dispatch(SetError(e));
          }));
}
