
class MonthlyCtcCalculatorModelClass {
  var monthlyofferedpackage;
  var basic;
  var hra;
  var allowances;
  var gross;
  var epfEmployer;
  var epfEmployee;
  var esiEmployer;
  var esiEmployee;
  var employergratuity;
  var ctc;
  var salaryInHand;
  var employersocialsecurity;
  var employeesocialsecurity;
  var salarygenerationbase;
  var uannumber;

  MonthlyCtcCalculatorModelClass(
      {this.monthlyofferedpackage,
        this.basic,
        this.hra,
        this.allowances,
        this.gross,
        this.epfEmployer,
        this.epfEmployee,
        this.esiEmployer,
        this.esiEmployee,
        this.employergratuity,
        this.ctc,
        this.salaryInHand,
        this.employersocialsecurity,
        this.employeesocialsecurity,
        this.salarygenerationbase,
        this.uannumber});

  MonthlyCtcCalculatorModelClass.fromJson(Map<String, dynamic> json) {
    monthlyofferedpackage = json['monthlyofferedpackage'];
    basic = json['basic'];
    hra = json['hra'];
    allowances = json['allowances'];
    gross = json['gross'];
    epfEmployer = json['epf_employer'];
    epfEmployee = json['epf_employee'];
    esiEmployer = json['esi_employer'];
    esiEmployee = json['esi_employee'];
    employergratuity = json['employergratuity'];
    ctc = json['ctc'];
    salaryInHand = json['salary_in_hand'];
    employersocialsecurity = json['employersocialsecurity'];
    employeesocialsecurity = json['employeesocialsecurity'];
    salarygenerationbase = json['salarygenerationbase'];
    uannumber = json['uannumber'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monthlyofferedpackage'] = this.monthlyofferedpackage;
    data['basic'] = this.basic;
    data['hra'] = this.hra;
    data['allowances'] = this.allowances;
    data['gross'] = this.gross;
    data['epf_employer'] = this.epfEmployer;
    data['epf_employee'] = this.epfEmployee;
    data['esi_employer'] = this.esiEmployer;
    data['esi_employee'] = this.esiEmployee;
    data['employergratuity'] = this.employergratuity;
    data['ctc'] = this.ctc;
    data['salary_in_hand'] = this.salaryInHand;
    data['employersocialsecurity'] = this.employersocialsecurity;
    data['employeesocialsecurity'] = this.employeesocialsecurity;
    data['salarygenerationbase'] = this.salarygenerationbase;
    data['uannumber'] = this.uannumber;

    return data;
  }
}

class InHandSalaryCalculatorModelClass {
  var monthlyofferedpackage;
  var basic;
  var hra;
  var allowances;
  var gross;
  var epfEmployer;
  var epfEmployee;
  var esiEmployer;
  var esiEmployee;
  var employergratuity;
  var salaryInHand;
  var ctc;
  var employersocialsecurity;
  var employeesocialsecurity;
  var salarygenerationbase;

  var personalinfoid;
  var salarycategoryname;
  var esiexceptionalcase;
  var salarydays;
  var pSalarydaysopted;
  var minwagescategoryid;
  var minimumwagessalary;
  var uannumber;
  var calcresult;
  var suggestivesalary;
  var salmessage;
  var minwagescategoryname;
  var minwagestatename;

  InHandSalaryCalculatorModelClass(
      {this.monthlyofferedpackage,
        this.basic,
        this.hra,
        this.allowances,
        this.gross,
        this.epfEmployer,
        this.epfEmployee,
        this.esiEmployer,
        this.esiEmployee,
        this.employergratuity,
        this.salaryInHand,
        this.ctc,
        this.employersocialsecurity,
        this.employeesocialsecurity,
        this.salarygenerationbase,
        this.personalinfoid,
        this.salarycategoryname,
        this.esiexceptionalcase,
        this.salarydays,
        this.pSalarydaysopted,
        this.minwagescategoryid,
        this.minimumwagessalary,
        this.uannumber,
        this.calcresult,
        this.suggestivesalary,
        this.salmessage,
        this.minwagescategoryname, this.minwagestatename});

  InHandSalaryCalculatorModelClass.fromJson(Map<String, dynamic> json) {
    monthlyofferedpackage = json['monthlyofferedpackage'];
    basic = json['basic'];
    hra = json['hra'];
    allowances = json['allowances'];
    gross = json['gross'];
    epfEmployer = json['epf_employer'];
    epfEmployee = json['epf_employee'];
    esiEmployer = json['esi_employer'];
    esiEmployee = json['esi_employee'];
    employergratuity = json['employergratuity'];
    salaryInHand = json['salary_in_hand'];
    ctc = json['ctc'];
    employersocialsecurity = json['employersocialsecurity'];
    employeesocialsecurity = json['employeesocialsecurity'];
    salarygenerationbase = json['salarygenerationbase'];
    personalinfoid = json['personalinfoid'];
    salarycategoryname = json['salarycategoryname'];
    esiexceptionalcase = json['esiexceptionalcase'];
    salarydays = json['salarydays'];
    pSalarydaysopted = json['p_salarydaysopted'];
    minwagescategoryid = json['minwagescategoryid'];
    minimumwagessalary = json['minimumwagessalary'];
    uannumber = json['uannumber'];
    calcresult = json['calcresult'];
    suggestivesalary = json['suggestivesalary'];
    salmessage = json['salmessage'];
    minwagescategoryname = json['minwagescategoryname'];
    minwagestatename = json['minwagestatename'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monthlyofferedpackage'] = this.monthlyofferedpackage;
    data['basic'] = this.basic;
    data['hra'] = this.hra;
    data['allowances'] = this.allowances;
    data['gross'] = this.gross;
    data['epf_employer'] = this.epfEmployer;
    data['epf_employee'] = this.epfEmployee;
    data['esi_employer'] = this.esiEmployer;
    data['esi_employee'] = this.esiEmployee;
    data['employergratuity'] = this.employergratuity;
    data['salary_in_hand'] = this.salaryInHand;
    data['ctc'] = this.ctc;
    data['employersocialsecurity'] = this.employersocialsecurity;
    data['employeesocialsecurity'] = this.employeesocialsecurity;
    data['salarygenerationbase'] = this.salarygenerationbase;
    data['personalinfoid'] = this.personalinfoid;
    data['salarycategoryname'] = this.salarycategoryname;
    data['esiexceptionalcase'] = this.esiexceptionalcase;
    data['salarydays'] = this.salarydays;
    data['p_salarydaysopted'] = this.pSalarydaysopted;
    data['minwagescategoryid'] = this.minwagescategoryid;
    data['minimumwagessalary'] = this.minimumwagessalary;
    data['uannumber'] = this.uannumber;
    data['calcresult'] = this.calcresult;
    data['suggestivesalary'] = this.suggestivesalary;
    data['salmessage'] = this.salmessage;
    data['minwagescategoryname'] = this.minwagescategoryname;
    data['minwagestatename'] = this.minwagestatename;

    return data;
  }
}
