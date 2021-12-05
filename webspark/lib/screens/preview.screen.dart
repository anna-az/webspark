// Flutter imports:
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webspark/common/services/get-cells.service.dart';

// Package imports:
import 'package:webspark/common/widgets/app-bar.widget.dart';
import 'package:webspark/store/models/cell.model.dart';
import 'package:webspark/store/store.dart';

// Project imports:

class PreviewScreen extends StatefulWidget {
  const PreviewScreen(this.id);
  final String id;
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  List<CellModel> cells = <CellModel>[];
  @override
  void initState() {
    if (store.state.tasks != null) {
      final currentTask =
          store.state.tasks!.firstWhere((task) => task.id == widget.id);
      cells = getCells(currentTask);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      title: 'Preview screen',
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.count(
            crossAxisCount: sqrt(cells.length).round(),
            children: [
              ...cells.map((CellModel cell) {
                return Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: cell.color,
                      border: Border.all(color: Colors.black, width: 2)),
                  child: Text(
                    '(${cell.x}, ${cell.y})',
                    style: TextStyle(
                        color: cell.isBlocked ? Colors.white : Colors.black),
                  ),
                );
              }).toList(),
            ],
          )),
    );
  }
}
