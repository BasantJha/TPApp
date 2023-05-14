class Prime_contracts_Model {
  String? title;
  String? validFrom;
  String? validTo;
  EmployeeList? employeeList;
  AttendaceReport? attendaceReport;
  SalaryDue? salaryDue;

  Prime_contracts_Model(
      {this.title,
      this.validFrom,
      this.validTo,
      this.employeeList,
      this.attendaceReport,
      this.salaryDue});

  Prime_contracts_Model.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
    employeeList = json['employee_list'] != null
        ? new EmployeeList.fromJson(json['employee_list'])
        : null;
    attendaceReport = json['attendace_report'] != null
        ? new AttendaceReport.fromJson(json['attendace_report'])
        : null;
    salaryDue = json['Salary_Due'] != null
        ? new SalaryDue.fromJson(json['Salary_Due'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['valid_from'] = this.validFrom;
    data['valid_to'] = this.validTo;
    if (this.employeeList != null) {
      data['employee_list'] = this.employeeList!.toJson();
    }
    if (this.attendaceReport != null) {
      data['attendace_report'] = this.attendaceReport!.toJson();
    }
    if (this.salaryDue != null) {
      data['Salary_Due'] = this.salaryDue!.toJson();
    }
    return data;
  }
}

class EmployeeList {
  String? active;
  String? inactive;
  String? total;

  EmployeeList({this.active, this.inactive, this.total});

  EmployeeList.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    inactive = json['inactive'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['inactive'] = this.inactive;
    data['total'] = this.total;
    return data;
  }
}

class AttendaceReport {
  String? date;
  String? present;
  String? absent;
  String? total;

  AttendaceReport({this.date, this.present, this.absent, this.total});

  AttendaceReport.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    present = json['present'];
    absent = json['absent'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['present'] = this.present;
    data['absent'] = this.absent;
    data['total'] = this.total;
    return data;
  }
}

class SalaryDue {
  String? month;
  String? employees;
  String? amount;

  SalaryDue({this.month, this.employees, this.amount});

  SalaryDue.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    employees = json['employees'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['employees'] = this.employees;
    data['amount'] = this.amount;
    return data;
  }
}
