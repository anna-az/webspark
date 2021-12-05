import 'package:flutter/material.dart';

class PushAction {
  PushAction(this.destination);
  final Widget destination;
}

class PushReplacementAction {
  PushReplacementAction(this.destination);
  final Widget destination;
}

class PopAction {
  PopAction({this.params});
  dynamic params;
}
