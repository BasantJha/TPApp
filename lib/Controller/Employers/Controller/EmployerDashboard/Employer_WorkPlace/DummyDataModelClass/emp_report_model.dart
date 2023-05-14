class EMP_REPORT {
  String? empName;
  String? location;
  String? dtTime;
  String? status;

  EMP_REPORT({this.empName, this.location, this.dtTime, this.status});

  EMP_REPORT.fromJson(Map<String, dynamic> json) {
    empName = json['emp_name'];
    location = json['location'];
    dtTime = json['dt_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_name'] = this.empName;
    data['location'] = this.location;
    data['dt_time'] = this.dtTime;
    data['status'] = this.status;
    return data;
  }
}
