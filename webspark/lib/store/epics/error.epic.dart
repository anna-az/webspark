import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webspark/common/models/notify.model.dart';
import 'package:webspark/store/actions/error.actions.dart';
import 'package:webspark/store/actions/notify.action.dart';

Stream<dynamic> errorEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.whereType<SetError>().switchMap<dynamic>((SetError action) =>
      Stream<dynamic>.value(action.error).map<dynamic>((dynamic error) {
        inspect(error);
        String? errorText =
            error is DioError && error.response?.data is Map<String, dynamic>
                ? error.response?.data['message'] as String
                : null;
        if (error is String) {
          errorText = error;
        }
        if (error is PlatformException) {
          errorText = error.message;
        }
        print(error);
        print(errorText);

        return Notify(
            NotifyModel(errorText ?? 'Something went wrong. Try again'));
      }));
}
