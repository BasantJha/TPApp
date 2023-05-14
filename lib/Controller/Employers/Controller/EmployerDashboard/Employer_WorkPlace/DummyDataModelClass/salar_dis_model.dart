class Salary_Dis_Data {
  String? month;
  String? billingPeriod;
  String? resAmt;
  String? status;
  String? noOfResources;
  String? salaryDisbursedAmt;
  List<EmployeeList>? employeeList;

  Salary_Dis_Data(
      {this.month,
      this.billingPeriod,
      this.resAmt,
      this.status,
      this.noOfResources,
      this.salaryDisbursedAmt,
      this.employeeList});

  Salary_Dis_Data.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    billingPeriod = json['billing_period'];
    resAmt = json['res_amt'];
    status = json['status'];
    noOfResources = json['no_of_resources'];
    salaryDisbursedAmt = json['salary_disbursed_amt'];
    if (json['employee_list'] != null) {
      employeeList = <EmployeeList>[];
      json['employee_list'].forEach((v) {
        employeeList!.add(new EmployeeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['billing_period'] = this.billingPeriod;
    data['res_amt'] = this.resAmt;
    data['status'] = this.status;
    data['no_of_resources'] = this.noOfResources;
    data['salary_disbursed_amt'] = this.salaryDisbursedAmt;
    if (this.employeeList != null) {
      data['employee_list'] =
          this.employeeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeList {
  String? name;
  String? workingDays;
  String? salary;
  String? status;

  EmployeeList({this.name, this.workingDays, this.salary, this.status});

  EmployeeList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    workingDays = json['working_days'];
    salary = json['salary'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['working_days'] = this.workingDays;
    data['salary'] = this.salary;
    data['status'] = this.status;
    return data;
  }
}
