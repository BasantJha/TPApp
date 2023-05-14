class TankhaPaySupportSubjectList {
  bool? statusCode;
  String? message;
  List<Tickets>? tickets;

  TankhaPaySupportSubjectList({this.statusCode, this.message, this.tickets});

  TankhaPaySupportSubjectList.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add(new Tickets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.tickets != null) {
      data['tickets'] = this.tickets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tickets {
  String? ticketId;
  String? ticketName;

  Tickets({this.ticketId, this.ticketName});

  Tickets.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    ticketName = json['ticket_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['ticket_name'] = this.ticketName;
    return data;
  }
}