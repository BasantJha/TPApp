class EmployerpayOutSettingModelClass
{
  List<LeaveDetails>? leaveDetails;

  EmployerpayOutSettingModelClass({this.leaveDetails});

  EmployerpayOutSettingModelClass.fromJson(Map<String, dynamic> json) {
    if (json['leaveDetails'] != null) {
      leaveDetails = <LeaveDetails>[];
      json['leaveDetails'].forEach((v) {
        leaveDetails!.add(new LeaveDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaveDetails != null) {
      data['leaveDetails'] = this.leaveDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveDetails {
  String? leaveid;

  LeaveDetails({this.leaveid});

  LeaveDetails.fromJson(Map<String, dynamic> json) {
    leaveid = json['leaveid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leaveid'] = this.leaveid;
    return data;
  }
}