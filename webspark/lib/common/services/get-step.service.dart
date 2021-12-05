import 'package:webspark/common/services/distance.service.dart';
import 'package:webspark/store/models/cell.model.dart';

CellModel getStep(CellModel currCells, CellModel endStep) {
  CellModel? result;
  double distance = 0;

  if (currCells.cellsNearby != null) {
    for (CellModel cell in currCells.cellsNearby!) {
      double currDistance = getDistance(cell, endStep);
      if (!cell.isBlocked && (distance == 0 || currDistance < distance)) {
        distance = currDistance;
        result = cell;
      }
    }
  }

  return result ?? endStep;
}
