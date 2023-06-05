import 'package:drift_project/presentation/add_employee/add_employee_page.dart';
import 'package:drift_project/presentation/employee_list/employee_list_controller.dart';
import 'package:drift_project/presentation/employee_list/employee_list_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmployeeListPage extends StatelessWidget {
  EmployeeListPage({super.key});

  final EmployeeListPageController _employeeListPageController =
      Get.put(EmployeeListPageController());

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: _employeeListPageController,
      builder: (_) {
        final EmployeeListUiState uiState =
            _employeeListPageController.uiState.value;
        final employee = uiState.employeeList;
        return Scaffold(
          appBar: _buildAppBar(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              Get.to(() => AddEmployeePage(),
                  transition: Transition.fadeIn, duration: 700.milliseconds);
              await _employeeListPageController.fetchEmployee();
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Employee'),
          ),
          body: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: employee.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    Get.to(() => AddEmployeePage(
                          employeeModelData: employee[index],
                        ));
                  },
                  leading: Text(employee[index].id.toString()),
                  title: Text(employee[index].userName),
                  subtitle: Text(DateFormat('dd/MMM/yyyy')
                      .format(employee[index].dateOfBirth)),
                  trailing: IconButton(
                      onPressed: () {
                        print(GetPlatform.isFuchsia);
                        // _employeeListPageController
                        //     .deleteEmployee(employee[index].id);
                      },
                      icon: const Icon(Icons.delete)),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Employee List'),
    );
  }
}
