import 'package:webspark/store/models/cell.model.dart';

List<CellModel> getCellsNearby(
    CellModel currentCell, List<CellModel> allCells) {
  List<CellModel> result = <CellModel>[];

  for (final CellModel cell in allCells) {
    if (cell.x != currentCell.x || cell.y != currentCell.y) {
      bool isNear = (cell.x - currentCell.x).abs() < 2 &&
          (cell.y - currentCell.y).abs() < 2;
      if (isNear) {
        result.add(CellModel(
            x: cell.x,
            y: cell.y,
            isStart: cell.isStart,
            isEnd: cell.isEnd,
            isBlocked: cell.isBlocked));
      }
    }
  }
  return result;
}
