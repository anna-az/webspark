import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:webspark/common/models/notify.model.dart';
import 'package:webspark/store/actions/notify.action.dart';
import 'package:webspark/store/reducers/reducer.dart';

class _ViewModel {
  _ViewModel({
    this.markAsHandled,
    this.notify,
  });
  final Function? markAsHandled;
  final NotifyModel? notify;
}

class Notifier extends StatelessWidget {
  const Notifier({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel(
          notify: store.state.notify,
          markAsHandled: () => store.dispatch(NotifyHandled())),
      builder: (BuildContext context, _ViewModel state) => child,
      onWillChange: (_ViewModel? state, _ViewModel a) {
        if (a.notify != null) {
          a.markAsHandled!();
          BotToast.showAttachedWidget(
              attachedBuilder: (_) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey,
                        border: Border.all(width: 1, color: Colors.red)),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                          color: Colors.red,
                          child: Icon(
                            Icons.warning,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(child: Text(a.notify!.notificationMessage))
                      ],
                    ),
                  ),
              enableSafeArea: false,
              duration: const Duration(seconds: 3),
              target: const Offset(100, 170));
        }
      },
      distinct: true,
    );
  }
}
