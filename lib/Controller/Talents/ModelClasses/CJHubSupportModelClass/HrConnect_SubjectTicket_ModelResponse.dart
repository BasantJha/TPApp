class HrConnect_SubjectTicket_ModelResponse
{
  bool? statusCode;
  String? message;
  Data? data;

  HrConnect_SubjectTicket_ModelResponse({this.statusCode, this.message, this.data});

  static List<Tickets> loadDefaultData =[
    Tickets(
      ticketId: "1",
      ticketName: "Appointment Letter",
    )];

  HrConnect_SubjectTicket_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  List<Tickets>? tickets;

  Data({this.tickets});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add(new Tickets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tickets != null) {
      data['tickets'] = this.tickets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tickets {
  var ticketId;
  var ticketName;

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