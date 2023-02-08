import 'package:employee_tree/model/employee.dart';
import 'package:flutter/cupertino.dart';

class EmployeeNotifier extends ChangeNotifier{
  List<Employee> employeeList = [
    Employee(fullName: "Ayana Omarova", jobTitle: JobTitle.programmer, age: 23, gender: Gender.female, phoneNumber: "12345678"),
    Employee(fullName: "Elina Smit", jobTitle: JobTitle.projectManager, age: 25, gender: Gender.female, phoneNumber: "231576351"),
    Employee(fullName: "John Smith", jobTitle: JobTitle.accountant, age: 28, gender: Gender.male, phoneNumber: "13490241424"),
    Employee(fullName: "Daniel Welington", jobTitle: JobTitle.programmer, age: 18, gender: Gender.male, phoneNumber: "35231324231"),
  ];

  void addEmployee(Employee employee){
    employeeList.add(employee);
    notifyListeners();
  }

  void deleteEmployee(int index){
    employeeList.removeAt(index);
    notifyListeners();
  }
}
