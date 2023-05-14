class Employer_New_WorkPlaceAttendanceDetailsModelClass {
  List<Details>? details;

  Employer_New_WorkPlaceAttendanceDetailsModelClass({this.details});

  Employer_New_WorkPlaceAttendanceDetailsModelClass.fromJson(
      Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  var id;
  var attmon;
  var attyear;
  var attmonthname;
  var monthdays;
  var totalpresent;
  var totalholiday;
  var totalweekoff;
  var totalhalfday;
  var leavetaken;
  var totalpaiddays;
  var totalabsent;


  Details(
      {this.id,
        this.attmon,
        this.attyear,
        this.attmonthname,
        this.monthdays,
        this.totalpresent,
        this.totalholiday,
        this.totalweekoff,
        this.totalhalfday,
        this.leavetaken,
        this.totalpaiddays,
        this.totalabsent});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attmon = json['attmon'];
    attyear = json['attyear'];
    attmonthname = json['attmonthname'];
    monthdays = json['monthdays'];
    totalpresent = json['totalpresent'];
    totalholiday = json['totalholiday'];
    totalweekoff = json['totalweekoff'];
    totalhalfday = json['totalhalfday'];
    leavetaken = json['leavetaken'];
    totalpaiddays = json['totalpaiddays'];
    totalabsent = json['totalabsent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attmon'] = this.attmon;
    data['attyear'] = this.attyear;
    data['attmonthname'] = this.attmonthname;
    data['monthdays'] = this.monthdays;
    data['totalpresent'] = this.totalpresent;
    data['totalholiday'] = this.totalholiday;
    data['totalweekoff'] = this.totalweekoff;
    data['totalhalfday'] = this.totalhalfday;
    data['leavetaken'] = this.leavetaken;
    data['totalpaiddays'] = this.totalpaiddays;
    data['totalabsent'] = this.totalabsent;
    return data;
  }
}