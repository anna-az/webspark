// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:redux/redux.dart';

// Package imports:
import 'package:webspark/common/widgets/app-bar.widget.dart';
import 'package:webspark/common/widgets/bottom-button.widget.dart';
import 'package:webspark/store/actions/steps.actions.dart';
import 'package:webspark/store/actions/task.actions.dart';
import 'package:webspark/store/models/task.model.dart';
import 'package:webspark/store/reducers/reducer.dart';
import 'package:webspark/store/store.dart';

class _ViewModel {
  _ViewModel({
    this.tasks,
    this.isLoading = false,
  });
  List<TaskModel>? tasks;
  bool isLoading;
}

class ProcessScreen extends StatefulWidget {
  @override
  _ProcessScreenState createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  int percent = 0;
  bool isDone = false;

  @override
  void initState() {
    store.dispatch(GetTasksPending());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
            tasks: store.state.tasks, isLoading: store.state.isLoading),
        builder: (BuildContext context, _ViewModel state) => AppBarWidget(
            title: 'Process screen',
            isBackButton: false,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Spacer(),
                  Text(
                      isDone
                          ? 'All calculations has been finished, you can send your results to server'
                          : 'Please wait...',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  TweenAnimationBuilder(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(seconds: 3),
                    onEnd: () {
                      setState(() {
                        isDone = true;
                      });
                    },
                    builder: (context, value, _) {
                      percent = ((value as double) * 100).toInt();
                      return CircularPercentIndicator(
                        radius: 130.0,
                        lineWidth: 5.0,
                        header: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            '${(value * 100).toInt()}%',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        percent: value,
                        progressColor: Colors.blue,
                      );
                    },
                  ),
                  const Spacer(),
                  isDone
                      ? BottomButton(
                          'Send results to server',
                          isLoading: state.isLoading,
                          onPressed: () => store.dispatch(SendStepsPending(
                              state.tasks ?? <TaskModel>[], 'sdsfdsvsd')),
                        )
                      : SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                        )
                ],
              ),
            )));
  }
}
