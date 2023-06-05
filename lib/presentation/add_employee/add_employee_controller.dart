import 'package:drift_project/data/db_helper.dart';
import 'package:drift_project/presentation/employee_list/employee_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEmployeeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController dateofBirthController = TextEditingController();
  Future<void> pickedDate({required BuildContext context}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      //String? date = DateFormat('dd/MMM/yyyy').format(picked);
      dateofBirthController.text = picked.toString();
    }
  }

  Future<void> addEmployee(
      {required EmployeeModelCompanion? employeeModelCompanion,
      required VoidCallback onInserted}) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (employeeModelCompanion == null) return;
      await Get.find<EmployeeListPageController>()
          .dbHelper
          .insertEmployee(employeeModelCompanion);
      onInserted();
    }
  }

  Future<void> updateEmployee(
      {required EmployeeModelCompanion? employeeModelCompanion,
      required VoidCallback onUpdated}) async {
    if (employeeModelCompanion == null) return;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await Get.find<EmployeeListPageController>()
          .dbHelper
          .updateEmployee(employeeModelCompanion);
      onUpdated();
    }
  }
}
