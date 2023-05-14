

class EmployerFlexibleCalculatorModelClass {
  FlexibleTime? flexibleTime;
  FlexibleTime? fullTime;

  EmployerFlexibleCalculatorModelClass({this.flexibleTime, this.fullTime});

  EmployerFlexibleCalculatorModelClass.fromJson(Map<String, dynamic> json) {
    flexibleTime = json['flexibleTime'] != null
        ? new FlexibleTime.fromJson(json['flexibleTime'])
        : null;
    fullTime = json['fullTime'] != null
        ? new FlexibleTime.fromJson(json['fullTime'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.flexibleTime != null) {
      data['flexibleTime'] = this.flexibleTime!.toJson();
    }
    if (this.fullTime != null) {
      data['fullTime'] = this.fullTime!.toJson();
    }
    return data;
  }
}

class FlexibleTime {
  var personalinfoid;
  var salarycategoryname;
  var monthlyofferedpackage;
  var basic;
  var hra;
  var allowances;
  var gross;
  var epfEmployer;
  var epfEmployee;
  var esiEmployer;
  var esiEmployee;
  var salaryInHand;
  var ctc;
  var esiexceptionalcase;
  var employersocialsecurity;
  var employeesocialsecurity;
  var salarygenerationbase;
  var salarydays;
  var salarydaysopted;
  var minwagescategoryid;
  var minimumwagessalary;
  var uannumber;
  var calcresult;
  var suggestivesalary;
  var salmessage;
  var minwagescategoryname;
  var minwagestatename;
  var timecriteria;
  var salaryhours;
  var leavetemplateid;


  FlexibleTime(
      {this.personalinfoid,
        this.salarycategoryname,
        this.monthlyofferedpackage,
        this.basic,
        this.hra,
        this.allowances,
        this.gross,
        this.epfEmployer,
        this.epfEmployee,
        this.esiEmployer,
        this.esiEmployee,
        this.salaryInHand,
        this.ctc,
        this.esiexceptionalcase,
        this.employersocialsecurity,
        this.employeesocialsecurity,
        this.salarygenerationbase,
        this.salarydays,
        this.salarydaysopted,
        this.minwagescategoryid,
        this.minimumwagessalary,
        this.uannumber,
        this.calcresult,
        this.suggestivesalary,
        this.salmessage,
        this.minwagescategoryname,
        this.minwagestatename,
        this.timecriteria,
        this.salaryhours,
      this.leavetemplateid});

  FlexibleTime.fromJson(Map<String, dynamic> json) {
    personalinfoid = json['personalinfoid'];
    salarycategoryname = json['salarycategoryname'];
    monthlyofferedpackage = json['monthlyofferedpackage'];
    basic = json['basic'];
    hra = json['hra'];
    allowances = json['allowances'];
    gross = json['gross'];
    epfEmployer = json['epf_employer'];
    epfEmployee = json['epf_employee'];
    esiEmployer = json['esi_employer'];
    esiEmployee = json['esi_employee'];
    salaryInHand = json['salary_in_hand'];
    ctc = json['ctc'];
    esiexceptionalcase = json['esiexceptionalcase'];
    employersocialsecurity = json['employersocialsecurity'];
    employeesocialsecurity = json['employeesocialsecurity'];
    salarygenerationbase = json['salarygenerationbase'];
    salarydays = json['salarydays'];
    salarydaysopted = json['salarydaysopted'];
    minwagescategoryid = json['minwagescategoryid'];
    minimumwagessalary = json['minimumwagessalary'];
    uannumber = json['uannumber'];
    calcresult = json['calcresult'];
    suggestivesalary = json['suggestivesalary'];
    salmessage = json['salmessage'];
    minwagescategoryname = json['minwagescategoryname'];
    minwagestatename = json['minwagestatename'];
    timecriteria = json['timecriteria'];
    salaryhours = json['salaryhours'];
    leavetemplateid = json['leavetemplateid'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personalinfoid'] = this.personalinfoid;
    data['salarycategoryname'] = this.salarycategoryname;
    data['monthlyofferedpackage'] = this.monthlyofferedpackage;
    data['basic'] = this.basic;
    data['hra'] = this.hra;
    data['allowances'] = this.allowances;
    data['gross'] = this.gross;
    data['epf_employer'] = this.epfEmployer;
    data['epf_employee'] = this.epfEmployee;
    data['esi_employer'] = this.esiEmployer;
    data['esi_employee'] = this.esiEmployee;
    data['salary_in_hand'] = this.salaryInHand;
    data['ctc'] = this.ctc;
    data['esiexceptionalcase'] = this.esiexceptionalcase;
    data['employersocialsecurity'] = this.employersocialsecurity;
    data['employeesocialsecurity'] = this.employeesocialsecurity;
    data['salarygenerationbase'] = this.salarygenerationbase;
    data['salarydays'] = this.salarydays;
    data['salarydaysopted'] = this.salarydaysopted;
    data['minwagescategoryid'] = this.minwagescategoryid;
    data['minimumwagessalary'] = this.minimumwagessalary;
    data['uannumber'] = this.uannumber;
    data['calcresult'] = this.calcresult;
    data['suggestivesalary'] = this.suggestivesalary;
    data['salmessage'] = this.salmessage;
    data['minwagescategoryname'] = this.minwagescategoryname;
    data['minwagestatename'] = this.minwagestatename;
    data['timecriteria'] = this.timecriteria;
    data['salaryhours'] = this.salaryhours;
    data['leavetemplateid'] = this.leavetemplateid;

    return data;
  }
}