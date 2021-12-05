// Flutter imports:
import 'package:flutter/material.dart';
import 'package:webspark/common/models/notify.model.dart';

// Package imports:
import 'package:webspark/common/widgets/app-bar.widget.dart';
import 'package:webspark/common/widgets/bottom-button.widget.dart';
import 'package:webspark/store/actions/check-url.actions.dart';
import 'package:webspark/store/actions/notify.action.dart';
import 'package:webspark/store/store.dart';

// Project imports:

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _urlController =
        TextEditingController(text: '');

    return AppBarWidget(
      title: 'Home screen',
      isBackButton: false,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Set valid API base URL in order to continue'),
            const SizedBox(height: 30),
            Row(
              children: [
                Icon(Icons.compare_arrows),
                const SizedBox(width: 20),
                Expanded(
                    child: TextFormField(
                  controller: _urlController,
                )),
              ],
            ),
            const Spacer(),
            BottomButton('Start counting process', onPressed: () {
              if (_urlController.text.isEmpty) {
                store.dispatch(
                    Notify(NotifyModel('API base URL must not be empty')));
                return;
              }
              store.dispatch(SendUrlPending(_urlController.text));
            })
          ],
        ),
      ),
    );
  }
}
