


class Employer_NewWorkPlaceAttendanceCalendar_Get_MonthlyAttendance_ModelClass {
  bool? statusCode;
  String? message;
  List<Data>? data;

  Employer_NewWorkPlaceAttendanceCalendar_Get_MonthlyAttendance_ModelClass({this.statusCode, this.message, this.data});

  Employer_NewWorkPlaceAttendanceCalendar_Get_MonthlyAttendance_ModelClass.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? empCode;
  int? attday;
  int? attmonth;
  int? attyear;
  String? approvalStatus;
  String? markedByUsertype;
  String? attendanceType;
  String? dateofrelieveing;
  String? dateofjoining;
  String? payoutday;
  String? lockstatus;
  String? lockmessage;

  Data(
      {this.empCode,
        this.attday,
        this.attmonth,
        this.attyear,
        this.approvalStatus,
        this.markedByUsertype,
        this.attendanceType,
        this.payoutday,
        this.dateofjoining,
        this.dateofrelieveing,this.lockstatus, this.lockmessage
      });

  Data.fromJson(Map<String, dynamic> json) {
    empCode = json['emp_code'];
    attday = json['attday'];
    attmonth = json['attmonth'];
    attyear = json['attyear'];
    approvalStatus = json['approval_status'];
    markedByUsertype = json['marked_by_usertype'];
    attendanceType = json['attendance_type'];
    payoutday = json['payoutday'];
    dateofjoining = json['dateofjoining'];
    lockstatus = json['lockstatus'];
    lockmessage = json['lockmessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_code'] = this.empCode;
    data['attday'] = this.attday;
    data['attmonth'] = this.attmonth;
    data['attyear'] = this.attyear;
    data['approval_status'] = this.approvalStatus;
    data['marked_by_usertype'] = this.markedByUsertype;
    data['attendance_type'] = this.attendanceType;
    data['payoutday'] = this.payoutday;
    data['dateofjoining']  = this.dateofjoining;
    data['lockstatus'] = this.lockstatus;
    data['lockmessage'] = this.lockmessage;
    return data;
  }
}