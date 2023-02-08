import 'package:employee_tree/repository/employee_data.dart';
import 'package:employee_tree/screens/tree.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => EmployeeNotifier(),
      child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Employee Tree',
      debugShowCheckedModeBanner: false,
      home: Tree(),
    );
  }
}
