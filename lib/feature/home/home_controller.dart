import '../../models/table_model.dart';
import '../../core/constants/app_constants.dart';


class HomeController {
  final List<TableModel> tables =
      List.generate(AppConstants.tableCount, (i) => TableModel(id: i));

  void decrementCounter(int index) {
    final table = tables[index];

    table.counter =
        table.counter == 0 ? 10 : table.counter - 1;
  }
}