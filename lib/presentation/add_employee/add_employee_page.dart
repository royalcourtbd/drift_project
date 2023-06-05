import 'package:drift_project/data/db_helper.dart';
import 'package:drift_project/presentation/add_employee/add_employee_controller.dart';
import 'package:drift_project/presentation/add_employee/widgets/employee_form.dart';
import 'package:drift_project/presentation/employee_list/employee_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:get/get.dart';

class AddEmployeePage extends StatelessWidget {
  AddEmployeePage({Key? key, this.employeeModelData}) : super(key: key);

  final EmployeeModelData? employeeModelData;

  final AddEmployeeController _addEmployeeController =
      Get.put(AddEmployeeController());

  late final TextEditingController _userNameController =
      TextEditingController(text: employeeModelData?.userName ?? '');
  late final TextEditingController _firstNameController =
      TextEditingController(text: employeeModelData?.firstName ?? '');
  late final TextEditingController _lastNameController =
      TextEditingController(text: employeeModelData?.lastName ?? '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _addEmployeeController.formKey,
                child: Column(
                  children: [
                    //  EmployeeForm(nameController: _nameController),
                    EmployeeForm(
                      controller: _userNameController,
                      labelText: 'User Name',
                    ),
                    const SizedBox(height: 10),
                    EmployeeForm(
                      controller: _firstNameController,
                      labelText: 'First Name',
                    ),
                    const SizedBox(height: 10),
                    EmployeeForm(
                      controller: _lastNameController,
                      labelText: 'Last Name',
                    ),
                    const SizedBox(height: 10),
                    EmployeeForm(
                      controller: _addEmployeeController.dateofBirthController,
                      labelText: 'Date of Birth',
                      onTap: () =>
                          _addEmployeeController.pickedDate(context: context),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Add Employee'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            employeeModelData?.id != null
                ? _addEmployeeController.updateEmployee(
                    employeeModelCompanion: EmployeeModelCompanion(
                      id: drift.Value(employeeModelData!.id),
                      userName: drift.Value(_userNameController.text),
                      firstName: drift.Value(_firstNameController.text),
                      lastName: drift.Value(_lastNameController.text),
                      dateOfBirth: drift.Value(DateTime.parse(
                          _addEmployeeController.dateofBirthController.text)),
                    ),
                    onUpdated: () async {
                      await Get.find<EmployeeListPageController>()
                          .fetchEmployee();
                      Get.back();
                      _userNameController.clear();
                      _firstNameController.clear();
                      _lastNameController.clear();
                      _addEmployeeController.dateofBirthController.clear();
                    })
                : _addEmployeeController.addEmployee(
                    employeeModelCompanion: EmployeeModelCompanion(
                      userName: drift.Value(_userNameController.text),
                      firstName: drift.Value(_firstNameController.text),
                      lastName: drift.Value(_lastNameController.text),
                      dateOfBirth: drift.Value(DateTime.parse(
                          _addEmployeeController.dateofBirthController.text)),
                    ),
                    onInserted: () async {
                      await Get.find<EmployeeListPageController>()
                          .fetchEmployee();
                      Get.back();
                      _userNameController.clear();
                      _firstNameController.clear();
                      _lastNameController.clear();
                      _addEmployeeController.dateofBirthController.clear();
                    },
                  );
          },
          icon: const Icon(Icons.save),
        ),
      ],
    );
  }
}
