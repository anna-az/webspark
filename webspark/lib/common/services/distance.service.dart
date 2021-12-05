import 'dart:math';

import 'package:webspark/store/models/cell.model.dart';

double getDistance(CellModel coord1, CellModel coord2) {
  double result =
      sqrt(pow(coord1.x - coord2.x, 2) + pow(coord1.y - coord2.y, 2));

  return result;
}
