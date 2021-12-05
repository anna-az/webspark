// Flutter imports:
import 'package:flutter/material.dart';
import 'package:webspark/store/actions/rout.actions.dart';
import 'package:webspark/store/store.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget(
      {required this.title,
      required this.child,
      this.isBackButton = true,
      this.onTap});

  final String title;
  final Widget child;
  final bool isBackButton;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isBackButton
            ? InkWell(
                onTap: () {
                  if (onTap != null) {
                    onTap!();
                    return;
                  }
                  store.dispatch(PopAction());
                },
                child: Container(
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                ),
              )
            : null,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            title,
            textAlign: TextAlign.start,
          ),
        ),
      ),
      body: child,
    );
  }
}
