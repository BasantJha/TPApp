class TankhaPayNotificationModelClass {
  List<Notifications>? notifications;

  TankhaPayNotificationModelClass({this.notifications});

  TankhaPayNotificationModelClass.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String? id;
  String? msg;
  String? actionitem;
  String? notificationdate;

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