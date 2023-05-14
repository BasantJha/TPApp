class EmployerLatestTransaction {
  String? title;
  String? status;
  String? date;
  String? time;
  String? amount;

  EmployerLatestTransaction({this.title, this.status, this.date, this.time, this.amount});

  EmployerLatestTransaction.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    status = json['status'];
    date = json['date'];
    time = json['time'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['status'] = this.status;
    data['date'] = this.date;
    data['time'] = this.time;
    data['amount'] = this.amount;
    return data;
  }
}
