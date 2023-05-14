class EmployerNewWorkPlaceAttendanceModelClass {
  bool? statusCode;
  String? message;
  Data? data;

  EmployerNewWorkPlaceAttendanceModelClass(
      {this.statusCode, this.message, this.data});

  EmployerNewWorkPlaceAttendanceModelClass.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Attendancesummary? attendancesummary;
  List<Attendancedetail>? attendancedetail;

  Data({this.attendancesummary, this.attendancedetail});

  Data.fromJson(Map<String, dynamic> json) {
    attendancesummary = json['attendancesummary'] != null
        ? new Attendancesummary.fromJson(json['attendancesummary'])
        : null;
    if (json['attendancedetail'] != null) {
      attendancedetail = <Attendancedetail>[];
      json['attendancedetail'].forEach((v) {
        attendancedetail!.add(new Attendancedetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attendancesummary != null) {
      data['attendancesummary'] = this.attendancesummary!.toJson();
    }
    if (this.attendancedetail != null) {
      data['attendancedetail'] =
          this.attendancedetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendancesummary {
  int? totalAtt;
  int? presentAtt;
  int? absentAtt;
  int? leaveAtt;
  var payoutSettings;

  Attendancesummary(
      {this.totalAtt, this.presentAtt, this.absentAtt, this.leaveAtt,this.payoutSettings});

  Attendancesummary.fromJson(Map<String, dynamic> json) {
    totalAtt = json['total_att'];
    presentAtt = json['present_att'];
    absentAtt = json['absent_att'];
    leaveAtt = json['leave_att'];
    payoutSettings = json['payout_settings'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_att'] = this.totalAtt;
    data['present_att'] = this.presentAtt;
    data['absent_att'] = this.absentAtt;
    data['leave_att'] = this.leaveAtt;
    data['payout_settings'] = this.payoutSettings;

    return data;
  }
}


class Attendancedetail {
  int? empCode;
  String? empName;
  String? approvalStatus;
  String? markedByUsertype;
  String? attendanceType;
  String? photopath;
  String? mobile;
  String? dateofbirth;
  String? empDesignation;
  String? dateofjoining;
  String? marked_attendance;
  String? approved_attendance;
  String? today_status;
  String? dateofrelieveing;



  Attendancedetail(
      {this.empCode,
        this.empName,
        this.approvalStatus,
        this.markedByUsertype,
        this.attendanceType,
        this.photopath,
        this.mobile,
        this.dateofbirth,
        this.empDesignation,
        this.dateofjoining,
        this.marked_attendance,
        this.approved_attendance,
        this.today_status,this.dateofrelieveing

      });

  Attendancedetail.fromJson(Map<String, dynamic> json) {
    empCode = json['emp_code'];
    empName = json['emp_name'];
    approvalStatus = json['approval_status'];
    markedByUsertype = json['marked_by_usertype'];
    attendanceType = json['attendance_type'];
    photopath = json['photopath'];
    mobile = json['mobile'];
    dateofbirth = json['dateofbirth'];
    empDesignation = json['emp_designation'];
    dateofjoining = json['dateofjoining'];
    marked_attendance = json['marked_attendance'];
    approved_attendance = json['approved_attendance'];
    today_status = json['today_status'];
    dateofrelieveing = json['dateofrelieveing'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_code'] = this.empCode;
    data['emp_name'] = this.empName;
    data['approval_status'] = this.approvalStatus;
    data['marked_by_usertype'] = this.markedByUsertype;
    data['attendance_type'] = this.attendanceType;
    data['photopath'] = this.photopath;
    data['mobile'] = this.mobile;
    data['dateofbirth'] = this.dateofbirth;
    data['emp_designation'] = this.empDesignation;
    data['dateofjoining'] = this.dateofjoining;
    data['marked_attendance'] = this.marked_attendance;
    data['approved_attendance'] = this.approved_attendance;
    data['today_status'] = this.today_status;
    data['dateofrelieveing'] = this.dateofrelieveing;


    return data;
  }
}