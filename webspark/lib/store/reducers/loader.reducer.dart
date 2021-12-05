import 'package:redux/redux.dart';
import 'package:webspark/store/actions/error.actions.dart';
import 'package:webspark/store/actions/steps.actions.dart';

final Reducer<bool> isLoadingReducers =
    combineReducers<bool>(<bool Function(bool, dynamic)>[
  TypedReducer<bool, SendStepsPending>(_setTrue),
  // TypedReducer<bool, SendStepsError>(_setFalse),
  TypedReducer<bool, SendStepsSuccess>(_setFalse),
  TypedReducer<bool, SetError>(_setFalse),
]);

bool _setTrue(bool isLoading, SendStepsPending action) {
  return true;
}

bool _setFalse(bool isLoading, dynamic action) {
  return false;
}
