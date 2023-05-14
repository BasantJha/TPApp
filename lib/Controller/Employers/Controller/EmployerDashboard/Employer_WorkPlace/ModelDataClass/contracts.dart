import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_WorkPlace/ModelDataClass/cnrt_employees.dart';

class Contracts {
  String? leadImg;
  String? title;
  String? name;
  String? validFrom;
  String? validTo;
  List<contract_Employees>? CNT_EMP;

  Contracts(
      {this.leadImg,
      this.title,
      this.name,
      this.validFrom,
      this.validTo,
      this.CNT_EMP});
}
