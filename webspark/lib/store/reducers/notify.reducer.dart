import 'package:redux/redux.dart';
import 'package:webspark/common/models/notify.model.dart';
import 'package:webspark/store/actions/notify.action.dart';

final Reducer<NotifyModel?> notifyReducers = combineReducers<
    NotifyModel?>(<NotifyModel? Function(NotifyModel?, dynamic)>[
  TypedReducer<NotifyModel?, Notify>(_notify),
  TypedReducer<NotifyModel?, NotifyHandled>(_notified),
]);
NotifyModel _notify(NotifyModel? notify, Notify action) {
  return action.notify;
}

NotifyModel? _notified(NotifyModel? notify, NotifyHandled action) {
  return null;
}
