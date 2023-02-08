import 'package:employee_tree/model/employee.dart';
import 'package:employee_tree/repository/employee_data.dart';
import 'package:flutter/material.dart';

class RegistrationEmployee extends StatefulWidget {
  const RegistrationEmployee({Key? key}) : super(key: key);

  @override
  State<RegistrationEmployee> createState() => _RegistrationEmployeeState();
}

class _RegistrationEmployeeState extends State<RegistrationEmployee> {

  EmployeeNotifier employeeNotifier = EmployeeNotifier();

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _country = TextEditingController();

  JobTitle jobTitle = JobTitle.projectManager;
  Gender gender = Gender.male;

  String? selectedValue = "ceo";
  String? selectedGender = "male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              TextField(
                controller: _fullName,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.blue),
                    hintText: "Enter full name"
                ),
              ),
              TextField(
                controller: _age,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.blue),
                    hintText: "Enter age"
                ),
              ),
              TextField(
                controller: _country,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.blue),
                    hintText: "Enter country"
                ),
              ),
              TextField(
                controller: _phoneNumber,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.blue),
                    hintText: "Enter phone number"
                ),
              ),
              SizedBox(
                width: 200,
                child: DropdownButton(
                    value: selectedGender,
                    items: Gender.values.map((value){
                      return DropdownMenuItem(
                        value: value.name,
                        child: Text(value.name),
                      );
                    }).toList(),
                    onChanged: (newValue){
                      setState(() {
                        selectedGender = newValue;
                        if(newValue != null){
                          gender = Gender.values.firstWhere((element) => element.toString() == "Gender.$newValue");
                        }
                      });
                                        }
                ),
              ),
              SizedBox(
                width: 200,
                child: DropdownButton(
                  value: selectedValue,
                    items: JobTitle.values.map((value){
                      return DropdownMenuItem(
                          value: value.name,
                          child: Text(value.name),
                      );
                    }).toList(),
                    onChanged: (newValue){
                      setState(() {
                        selectedValue = newValue;
                        if(newValue != null){
                          jobTitle = JobTitle.values.firstWhere((element) => element.toString() == "JobTitle.$newValue");
                        }
                      });
                                        }
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: (){
                        if(_fullName.text.isNotEmpty &&
                            _age.text.isNotEmpty &&
                            _country.text.isNotEmpty &&
                            _phoneNumber.text.isNotEmpty &&
                            gender.name.isNotEmpty &&
                            jobTitle.name.isNotEmpty){

                          Employee newEmployee = Employee(fullName: _fullName.text,
                              jobTitle: jobTitle,
                              age: int.parse(_age.text.trim()),
                              gender: gender,
                              phoneNumber: _phoneNumber.text);

                          Navigator.pop(context, newEmployee);
                        }
                      },
                      child: const Text("Save")
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
