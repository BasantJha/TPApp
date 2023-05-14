
class TankhaPayGetTodayAttendance {
  String? code;
  bool? statusCode;
  String? thereWasAnErrorInMarkingAttendancePleaseTryAgain;
  String? commonData;
  String? message;


  TankhaPayGetTodayAttendance(
      {this.code,
        this.statusCode,
        this.thereWasAnErrorInMarkingAttendancePleaseTryAgain,
        this.commonData,
        this.message});

  TankhaPayGetTodayAttendance.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    statusCode = json['statusCode'];
    thereWasAnErrorInMarkingAttendancePleaseTryAgain =
    json['There was an error in marking attendance, please try again.'];
    commonData = json['commonData'];
    message = json['message'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['statusCode'] = this.statusCode;
    data['There was an error in marking attendance, please try again.'] =
        this.thereWasAnErrorInMarkingAttendancePleaseTryAgain;
    data['commonData'] = this.commonData;
    data['message'] = this.message;

    return data;
  }
}

