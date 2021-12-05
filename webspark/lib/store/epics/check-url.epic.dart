import 'package:dio/dio.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webspark/common/models/notify.model.dart';
import 'package:webspark/common/services/check-url.service.dart';
import 'package:webspark/screens/process.screen.dart';
import 'package:webspark/store/actions/check-url.actions.dart';
import 'package:webspark/store/actions/notify.action.dart';
import 'package:webspark/store/actions/rout.actions.dart';
import 'package:webspark/store/store.dart' as s;

Stream<void> checkUrlEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) => action is SendUrlPending).switchMap(
      (dynamic action) =>
          Stream<String>.fromFuture(checkUrl(action.url as String))
              .expand<dynamic>((String message) {
            return <dynamic>[
              SendUrlSuccess(),
              PushAction(ProcessScreen()),
            ];
          }).handleError((dynamic e) {
            s.store.dispatch(SendUrlError(e));
          }));
}

Stream<void> checkErrorEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) => action is SendUrlError).switchMap(
      (dynamic action) =>
          Stream<dynamic>.value(action.error).map<dynamic>((dynamic error) {
            if (error is DioError && error.response?.data != null) {
              s.store.dispatch(PushAction(ProcessScreen()));
            }

            return Notify(NotifyModel('Not valid API base URL'));
          }));
}
