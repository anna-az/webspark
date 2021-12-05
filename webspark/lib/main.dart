import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:webspark/common/widgets/notify.widget.dart';
import 'package:webspark/screens/home.screen.dart';
import 'package:webspark/store/reducers/reducer.dart';
import 'package:webspark/store/store.dart';

void main() {
  runApp(MyApp(store: store));
}

class MyApp extends StatefulWidget {
  const MyApp({required this.store});
  final Store<AppState> store;
  @override
  _MyAppState createState() => _MyAppState();
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
    return StoreProvider<AppState>(
      store: widget.store,
      child: Notifier(
        child: MaterialApp(
          builder: BotToastInit(),
          navigatorObservers: <NavigatorObserver>[
            BotToastNavigatorObserver(),
          ],
          title: 'WWBSPARK',
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
