import 'package:drift_project/data/db_helper.dart';
import 'package:drift_project/presentation/employee_list/employee_list_ui_state.dart';
import 'package:get/get.dart';

class EmployeeListPageController extends GetxController {
  final DBHelper dbHelper = DBHelper();

  Rx<EmployeeListUiState> uiState = Rx(
    EmployeeListUiState(
      isLoading: false,
      employeeList: [],
    ),
  );

  Future<void> fetchEmployee() async {
    final List<EmployeeModelData> employeeMapList =
        await dbHelper.getAllEmployees();

    uiState.value =
        uiState.value.copyWith(isLoading: false, employeeList: employeeMapList);
  }

  Future<void> deleteEmployee(int id) async {
    _loading();
    await dbHelper.deleteEmployee(id);
    _loaded();
    fetchEmployee();
  }     

  @override
  void onInit() {
    super.onInit();
    fetchEmployee();
  }

  void _loading() => uiState.value = uiState.value.copyWith(isLoading: true);
  void _loaded() => uiState.value = uiState.value.copyWith(isLoading: false);
}
