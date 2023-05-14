
class Employer_HomeNotificationModelClass {
  bool? statusCode;
  String? message;
  Data? data;

  Employer_HomeNotificationModelClass({this.statusCode, this.message, this.data});

  Employer_HomeNotificationModelClass.fromJson(Map<String, dynamic> json) {
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

  List<Notifications>? notifications;
  List<Recentactivities>? recentactivities;

  Data({this.notifications, this.recentactivities});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
    if (json['recentactivities'] != null) {
      recentactivities = <Recentactivities>[];
      json['recentactivities'].forEach((v) {
        recentactivities!.add(new Recentactivities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    if (this.recentactivities != null) {
      data['recentactivities'] =
          this.recentactivities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  var id;
  var msg;
  var actionitem;
  var notificationdate;

  Notifications({this.id, this.msg, this.actionitem, this.notificationdate});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    msg = json['msg'];
    actionitem = json['actionitem'];
    notificationdate = json['notificationdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['msg'] = this.msg;
    data['actionitem'] = this.actionitem;
    data['notificationdate'] = this.notificationdate;
    return data;
  }
}

class Recentactivities {
  var id;
  var msg;
  var notificationdate;
  var cnt;


  Recentactivities({this.id, this.msg, this.notificationdate,this.cnt});

  Recentactivities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    msg = json['msg'];
    notificationdate = json['notificationdate'];
    cnt = json['cnt'];
    cnt = json['cnt'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['msg'] = this.msg;
    data['notificationdate'] = this.notificationdate;
    data['cnt'] = this.cnt;

    return data;
  }
}
