import 'package:employee_tree/model/employee.dart';
import 'package:employee_tree/repository/employee_data.dart';
import 'package:employee_tree/screens/add_new_employee.dart';
import 'package:flutter/material.dart';

final bucketGlobal = PageStorageBucket();

class Tree extends StatefulWidget {
  const Tree({Key? key}) : super(key: key);

  @override
  State<Tree> createState() => _TreeState();
}

class _TreeState extends State<Tree> {
  bool _age = false;
  bool _phoneNumber = false;

  EmployeeNotifier employeeNotifier = EmployeeNotifier();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Employee Tree',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: PopupMenuButton(
                onSelected: (String value) {
                  if (value == "age") {
                    setState(() {
                      _age = !_age;
                    });
                  }
                  if (value == "phoneNumber") {
                    setState(() {
                      _phoneNumber = !_phoneNumber;
                    });
                  }
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: "age",
                      child: _age
                          ? const Text("Delete age")
                          : const Text("Add age"),
                    ),
                    PopupMenuItem(
                      value: "phoneNumber",
                      child: _phoneNumber
                          ? const Text("Delete phone number")
                          : const Text("Add phone number"),
                    ),
                  ];
                },
              )),
        ],
      ),
      body: PageStorage(
        bucket: bucketGlobal,
        child: ReorderableListView.builder(
          onReorder: (oldIndex, newIndex){
            setState(() {
              if(newIndex > oldIndex) newIndex--;
              final element = employeeNotifier.employeeList.removeAt(oldIndex);
              employeeNotifier.employeeList.insert(newIndex, element);
            });
          },
          itemCount: employeeNotifier.employeeList.length,
          itemBuilder: (context, index){
            return Card(
              key: ValueKey(employeeNotifier.employeeList[index]),
              color: Colors.yellow[200],
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(employeeNotifier.employeeList[index].fullName),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                    "Do you wanna delete this employee?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        employeeNotifier.deleteEmployee(index);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Yes"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("No"),
                                  ),
                                ],
                              );
                            });
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    leading: const Icon(Icons.drag_handle),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(employeeNotifier.employeeList[index].jobTitle.name),
                            const SizedBox(width: 10,),
                            Text(_age ? employeeNotifier.employeeList[index].age.toString() : ""),
                          ],
                        ),
                        Text(_phoneNumber ? employeeNotifier.employeeList[index].phoneNumber : ""),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async{
          Employee value = await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const RegistrationEmployee();
          }));

          if(value != null){
            setState(() {
              employeeNotifier.employeeList.add(value);
            });
          }

        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 25,
        ),
      ),
    );
  }
}
