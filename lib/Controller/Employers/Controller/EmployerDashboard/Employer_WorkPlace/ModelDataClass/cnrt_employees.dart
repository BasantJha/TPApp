import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_WorkPlace/ModelDataClass/Emp_Attendence.dart';

class contract_Employees {
  String? image;
  String? name;
  String? designation;
  String? phone;
  String? email;
  String? deputedDate;
  List<Emp_Attendence>? attendemce;

  contract_Employees(
      {this.image,
      this.name,
      this.designation,
      this.phone,
      this.email,
      this.deputedDate,
      this.attendemce});
}
