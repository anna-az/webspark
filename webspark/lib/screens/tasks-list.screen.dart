// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Package imports:
import 'package:webspark/common/widgets/app-bar.widget.dart';
import 'package:webspark/screens/home.screen.dart';
import 'package:webspark/screens/preview.screen.dart';
import 'package:webspark/store/actions/rout.actions.dart';
import 'package:webspark/store/models/cell.model.dart';
import 'package:webspark/store/models/task.model.dart';
import 'package:webspark/store/reducers/reducer.dart';
import 'package:webspark/store/store.dart';

class TasksListScreen extends StatefulWidget {
  @override
  _TasksListScreenState createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<TaskModel>>(
        converter: (Store<AppState> store) =>
            store.state.tasks ?? <TaskModel>[],
        builder: (BuildContext context, List<TaskModel> tasks) {
          return AppBarWidget(
            title: 'Result list screen',
            onTap: () => store.dispatch(PushReplacementAction(HomeScreen())),
            child: ListView(
              children: [
                ...tasks
                    .map((TaskModel result) => InkWell(
                          onTap: () => store
                              .dispatch(PushAction(PreviewScreen(result.id))),
                          child: Container(
                            height: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 1))),
                            child: Text(_generateText(result.steps)),
                          ),
                        ))
                    .toList(),
              ],
            ),
          );
        });
  }

  String _generateText(List<CellModel>? cells) {
    String result = '';
    if (cells != null && cells.isNotEmpty)
      for (CellModel cell in cells) {
        result = result + '(${cell.x},${cell.y})';
        if (cells.indexOf(cell) != cells.length - 1) {
          result = result + '->';
        }
      }

    return result;
  }
}
