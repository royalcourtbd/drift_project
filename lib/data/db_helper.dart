import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_project/data/employee_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
part 'db_helper.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'employee.sqlite3'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [EmployeeModel, ])
class DBHelper extends _$DBHelper {
  DBHelper() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> insertEmployee(EmployeeModelCompanion companion) async {
    return await into(employeeModel).insert(companion);
  }

//Get the list of  Employee
  Future<List<EmployeeModelData>> getAllEmployees() async {
    return await select(employeeModel).get();
  }

  Future<EmployeeModelData> getEmployeeById(int id) async {
    return await (select(employeeModel)..where((t) => t.id.equals(id)))
        .getSingle();
  }

  Future<bool> updateEmployee(EmployeeModelCompanion companion) async {
    return await update(employeeModel).replace(companion);
  }

  Future<int> deleteEmployee(int id) async {
    return await (delete(employeeModel)..where((t) => t.id.equals(id))).go();
  }
}
