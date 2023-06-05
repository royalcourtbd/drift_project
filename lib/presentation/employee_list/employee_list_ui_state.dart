// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:drift_project/data/db_helper.dart';

class EmployeeListUiState {
  final bool isLoading;
  final List<EmployeeModelData> employeeList;
  EmployeeListUiState({
    required this.isLoading,
    required this.employeeList,
  });

  EmployeeListUiState copyWith({
    bool? isLoading,
    List<EmployeeModelData>? employeeList,
  }) {
    return EmployeeListUiState(
      isLoading: isLoading ?? this.isLoading,
      employeeList: employeeList ?? this.employeeList,
    );
  }
}
