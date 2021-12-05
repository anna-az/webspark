import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BottomButton extends StatelessWidget {
  const BottomButton(this.title, {this.onPressed, this.isLoading = false});

  final String title;
  final void Function()? onPressed;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (isLoading || onPressed == null) {
            return;
          }
          onPressed!();
        },
        child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.lightBlue,
                border: Border.all(width: 1, color: Colors.indigo),
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: isLoading
                ? Container(
                    height: 40,
                    width: 40,
                    child: SpinKitRing(color: Colors.white))
                : Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )));
  }
}
