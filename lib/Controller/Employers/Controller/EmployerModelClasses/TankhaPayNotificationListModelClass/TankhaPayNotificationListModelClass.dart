class TankhaPayNotificationListModelClass {
  List<TankhaPayNotificationList>? tankhaPayNotificationList;

  TankhaPayNotificationListModelClass({this.tankhaPayNotificationList});

  TankhaPayNotificationListModelClass.fromJson(Map<String, dynamic> json) {
    if (json['tankhaPayNotificationList'] != null) {
      tankhaPayNotificationList = <TankhaPayNotificationList>[];
      json['tankhaPayNotificationList'].forEach((v) {
        tankhaPayNotificationList!
            .add(new TankhaPayNotificationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tankhaPayNotificationList != null) {
      data['tankhaPayNotificationList'] =
          this.tankhaPayNotificationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TankhaPayNotificationList {
  String? id;
  String? jsId;
  String? customeraccountid;
  String? alertusertype;
  String? alerttypeid;
  String? alertmessage;
  String? alertdate;
  String? alertexpirydate;
  String? isviewed;

  TankhaPayNotificationList(
      {this.id,
        this.jsId,
        this.customeraccountid,
        this.alertusertype,
        this.alerttypeid,
        this.alertmessage,
        this.alertdate,
        this.alertexpirydate,
        this.isviewed});

  TankhaPayNotificationList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jsId = json['js_id'];
    customeraccountid = json['customeraccountid'];
    alertusertype = json['alertusertype'];
    alerttypeid = json['alerttypeid'];
    alertmessage = json['alertmessage'];
    alertdate = json['alertdate'];
    alertexpirydate = json['alertexpirydate'];
    isviewed = json['isviewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['js_id'] = this.jsId;
    data['customeraccountid'] = this.customeraccountid;
    data['alertusertype'] = this.alertusertype;
    data['alerttypeid'] = this.alerttypeid;
    data['alertmessage'] = this.alertmessage;
    data['alertdate'] = this.alertdate;
    data['alertexpirydate'] = this.alertexpirydate;
    data['isviewed'] = this.isviewed;
    return data;
  }
}