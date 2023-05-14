import 'dart:convert';

EmployerAddEmployeeModelClass addEmployeeFromJson(String str) => EmployerAddEmployeeModelClass.fromJson(json.decode(str));

String addEmployeeToJson(EmployerAddEmployeeModelClass data) => json.encode(data.toJson());

class EmployerAddEmployeeModelClass {
  EmployerAddEmployeeModelClass({
    this.accountId,
    this.employerId,
    this.employeeName,
    this.employeeMobile,
    this.monthlySalary,
    this.doj,
    this.designation,
    this.employeeEmail,
    this.employerLeadid,
    this.createdby,
    this.createdip,
    this.salaryStructure,
  });

  String? accountId;
  String? employerId;
  String? employeeName;
  String? employeeMobile;
  String? monthlySalary;
  String? doj;
  String? designation;
  String? employeeEmail;
  String? employerLeadid;
  String? createdby;
  String? createdip;
  String? salaryStructure;

  factory EmployerAddEmployeeModelClass.fromJson(Map<String, dynamic> json) => EmployerAddEmployeeModelClass(
    accountId: json["account_id"],
    employerId: json["employer_id"],
    employeeName: json["employee_name"],
    employeeMobile: json["employee_mobile"],
    monthlySalary: json["monthly_salary"],
    doj: json["doj"],
    designation: json["designation"],
    employeeEmail: json["employee_email"],
    employerLeadid: json["employer_leadid"],
    createdby: json["createdby"],
    createdip: json["createdip"],
    salaryStructure: json["salary_structure"],
  );

  Map<String, dynamic> toJson() => {
    "account_id": accountId,
    "employer_id": employerId,
    "employee_name": employeeName,
    "employee_mobile": employeeMobile,
    "monthly_salary": monthlySalary,
    "doj": doj,
    "designation": designation,
    "employee_email": employeeEmail,
    "employer_leadid": employerLeadid,
    "createdby": createdby,
    "createdip": createdip,
    "salary_structure": salaryStructure,
  };
}
