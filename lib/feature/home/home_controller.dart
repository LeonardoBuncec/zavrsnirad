import '../../models/table_model.dart';
import '../../core/constants/app_constants.dart';

class HomeController {
  final List<TableModel> tables = List.generate(
    AppConstants.tableCount,
    (index) => TableModel(counter: 10),
  );
}
