
enum Gender{
  male,
  female
}

enum JobTitle{
  hrManager,
  accountant,
  programmer,
  projectManager,
  designer,
  ceo
}

class Employee{
  final String fullName;
  int age;
  final Gender gender;
  String phoneNumber;
  final JobTitle jobTitle;

  Employee({
    required this.fullName,
    required this.jobTitle,
    required this.age,
    required this.gender,
    required this.phoneNumber,
});
}