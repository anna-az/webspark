import 'package:flutter/material.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:webspark/main.dart';
import 'package:webspark/store/actions/rout.actions.dart';

Stream<void> routeEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) {
    return action is PushAction;
  }).map((dynamic action) {
    navigatorKey.currentState!.push<dynamic>(MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => action.destination as Widget));
  });
}

Stream<void> routePopEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) {
    return action is PopAction;
  }).map((dynamic action) {
    if (action.params != null) {
      navigatorKey.currentState!.pop<dynamic>(action.params);
    } else {
      navigatorKey.currentState!.pop<dynamic>();
    }
  });
}

Stream<void> routePushReplacmentEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) {
    return action is PushReplacementAction;
  }).map((dynamic action) {
    navigatorKey.currentState!
        .popUntil((Route<dynamic> route) => route.isFirst);
    navigatorKey.currentState!.pushReplacement<dynamic, dynamic>(
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => action.destination as Widget));
  });
}
