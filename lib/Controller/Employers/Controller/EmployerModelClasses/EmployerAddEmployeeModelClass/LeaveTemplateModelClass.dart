
class LeaveTemplateModelClass {
  bool? statusCode;
  String? message;
  List<Data>? data;

  LeaveTemplateModelClass({this.statusCode, this.message, this.data});

  LeaveTemplateModelClass.fromJson(Map<String, dynamic> json) {
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
  int? templateid;
  String? templatedesc;
  LeaveDetails? leaveDetails;
  bool? defaultTemplate;

  Data(
      {this.templateid,
        this.templatedesc,
        this.leaveDetails,
        this.defaultTemplate});

  Data.fromJson(Map<String, dynamic> json) {
    templateid = json['templateid'];
    templatedesc = json['templatedesc'];
    leaveDetails = json['leave_details'] != null
        ? new LeaveDetails.fromJson(json['leave_details'])
        : null;
    defaultTemplate = json['default_template'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['templateid'] = this.templateid;
    data['templatedesc'] = this.templatedesc;
    if (this.leaveDetails != null) {
      data['leave_details'] = this.leaveDetails!.toJson();
    }
    data['default_template'] = this.defaultTemplate;
    return data;
  }
}

class LeaveDetails {
  List<LeaveType>? leaveType;
  String? leavesCalender;
  String? weeklyOffDays;
  String? weeklyOffDaysName;
  String? absentIsEqualToLossOfPay;
  String? attendanceApprovalRequiredForPayout;

  LeaveDetails(
      {this.leaveType,
        this.leavesCalender,
        this.weeklyOffDays,
        this.weeklyOffDaysName,
        this.absentIsEqualToLossOfPay,
        this.attendanceApprovalRequiredForPayout});

  LeaveDetails.fromJson(Map<String, dynamic> json) {
    if (json['leave_type'] != null) {
      leaveType = <LeaveType>[];
      json['leave_type'].forEach((v) {
        leaveType!.add(new LeaveType.fromJson(v));
      });
    }
    leavesCalender = json['leaves_calender'];
    weeklyOffDays = json['weekly_off_days'];
    weeklyOffDaysName = json['weekly_off_days_name'];
    absentIsEqualToLossOfPay = json['absent_is_equal_to_loss_of_pay'];
    attendanceApprovalRequiredForPayout =
    json['attendance_approval_required_for_payout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaveType != null) {
      data['leave_type'] = this.leaveType!.map((v) => v.toJson()).toList();
    }
    data['leaves_calender'] = this.leavesCalender;
    data['weekly_off_days'] = this.weeklyOffDays;
    data['weekly_off_days_name'] = this.weeklyOffDaysName;
    data['absent_is_equal_to_loss_of_pay'] = this.absentIsEqualToLossOfPay;
    data['attendance_approval_required_for_payout'] =
        this.attendanceApprovalRequiredForPayout;
    return data;
  }
}

class LeaveType {
  String? days;
  String? typecode;
  String? isCarryForward;

  LeaveType({this.days, this.typecode, this.isCarryForward});

  LeaveType.fromJson(Map<String, dynamic> json) {
    days = json['days'];
    typecode = json['typecode'];
    isCarryForward = json['is_carry_forward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['days'] = this.days;
    data['typecode'] = this.typecode;
    data['is_carry_forward'] = this.isCarryForward;
    return data;
  }
}