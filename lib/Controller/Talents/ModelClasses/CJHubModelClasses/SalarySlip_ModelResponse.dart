class SalarySlip_ModelResponse {
  bool? statusCode;
  String? message;
  Data? data;

  SalarySlip_ModelResponse({this.statusCode, this.message, this.data});

  SalarySlip_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  List<SalaryComponents>? salaryComponents;
  List<DeductionComponent>? deductionComponent;
  List<VariableComponent>? variableComponent;

  Data(
      {this.salaryComponents, this.deductionComponent, this.variableComponent});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['salary_components'] != null) {
      salaryComponents = <SalaryComponents>[];
      json['salary_components'].forEach((v) {
        salaryComponents!.add(new SalaryComponents.fromJson(v));
      });
    }
    if (json['deduction_component'] != null) {
      deductionComponent = <DeductionComponent>[];
      json['deduction_component'].forEach((v) {
        deductionComponent!.add(new DeductionComponent.fromJson(v));
      });
    }
    if (json['variable_component'] != null) {
      variableComponent = <VariableComponent>[];
      json['variable_component'].forEach((v) {
        variableComponent!.add(new VariableComponent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.salaryComponents != null) {
      data['salary_components'] =
          this.salaryComponents!.map((v) => v.toJson()).toList();
    }
    if (this.deductionComponent != null) {
      data['deduction_component'] =
          this.deductionComponent!.map((v) => v.toJson()).toList();
    }
    if (this.variableComponent != null) {
      data['variable_component'] =
          this.variableComponent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class SalaryComponents
{
  var empCode;
  var empName;
  var postOffered;
  var doj;
  var esinumber;
  var pfnumber;
  var uannumber;
  var lopdays;
  var bankaccount;
  var empcode;
  var bankaccountno;
  var basic;
  var hra;
  var allowance;
  var fixedallowancestotal;
  var pf;
  var employeeesirate;
  var nps;
  var insurance;
  var other;
  var grossdeduction;
  var grossearning;
  var netpay;
  var govtBonusAmt;
  var paidDays;
  var lopdays1;
  var taxes;
  var totalarear;
  var monthdays;
  var ratebasic;
  var ratehra;
  var ratespecialallowance;
  var rategross;
  var arearbasic;
  var arearhra;
  var arearallowance;
  var areargross;
  var cjcode;
  var jobtype;
  var dateofbirth;
  var pancardnumber;


  SalaryComponents(
      {this.empCode,
        this.empName,
        this.postOffered,
        this.doj,
        this.esinumber,
        this.pfnumber,
        this.uannumber,
        this.lopdays,
        this.bankaccount,
        this.empcode,
        this.bankaccountno,
        this.basic,
        this.hra,
        this.allowance,
        this.fixedallowancestotal,
        this.pf,
        this.employeeesirate,
        this.nps,
        this.insurance,
        this.other,
        this.grossdeduction,
        this.grossearning,
        this.netpay,
        this.govtBonusAmt,
        this.paidDays,
        this.lopdays1,
        this.taxes,
        this.totalarear,
        this.monthdays,
        this.ratebasic,
        this.ratehra,
        this.ratespecialallowance,
        this.rategross,
        this.arearbasic,
        this.arearhra,
        this.arearallowance,
        this.areargross,
        this.cjcode,
        this.jobtype,
      this.dateofbirth,this.pancardnumber});

  SalaryComponents.fromJson(Map<String, dynamic> json) {
    empCode = json['emp_code'];
    empName = json['emp_name'];
    postOffered = json['post_offered'];
    doj = json['doj'];
    esinumber = json['esinumber'];
    pfnumber = json['pfnumber'];
    uannumber = json['uannumber'];
    lopdays = json['lopdays'];
    bankaccount = json['bankaccount'];
    empcode = json['empcode'];
    bankaccountno = json['bankaccountno'];
    basic = json['basic'];
    hra = json['hra'];
    allowance = json['allowance'];
    fixedallowancestotal = json['fixedallowancestotal'];
    pf = json['pf'];
    employeeesirate = json['employeeesirate'];
    nps = json['nps'];
    insurance = json['insurance'];
    other = json['other'];
    grossdeduction = json['grossdeduction'];
    grossearning = json['grossearning'];
    netpay = json['netpay'];
    govtBonusAmt = json['govt_bonus_amt'];
    paidDays = json['paid_days'];
    lopdays1 = json['lopdays1'];
    taxes = json['taxes'];
    totalarear = json['totalarear'];
    monthdays = json['monthdays'];
    ratebasic = json['ratebasic'];
    ratehra = json['ratehra'];
    ratespecialallowance = json['ratespecialallowance'];
    rategross = json['rategross'];
    arearbasic = json['arearbasic'];
    arearhra = json['arearhra'];
    arearallowance = json['arearallowance'];
    areargross = json['areargross'];
    cjcode = json['cjcode'];
    jobtype = json['jobtype'];
    dateofbirth = json['dateofbirth'];
    pancardnumber = json['pancardnumber'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_code'] = this.empCode;
    data['emp_name'] = this.empName;
    data['post_offered'] = this.postOffered;
    data['doj'] = this.doj;
    data['esinumber'] = this.esinumber;
    data['pfnumber'] = this.pfnumber;
    data['uannumber'] = this.uannumber;
    data['lopdays'] = this.lopdays;
    data['bankaccount'] = this.bankaccount;
    data['empcode'] = this.empcode;
    data['bankaccountno'] = this.bankaccountno;
    data['basic'] = this.basic;
    data['hra'] = this.hra;
    data['allowance'] = this.allowance;
    data['fixedallowancestotal'] = this.fixedallowancestotal;
    data['pf'] = this.pf;
    data['employeeesirate'] = this.employeeesirate;
    data['nps'] = this.nps;
    data['insurance'] = this.insurance;
    data['other'] = this.other;
    data['grossdeduction'] = this.grossdeduction;
    data['grossearning'] = this.grossearning;
    data['netpay'] = this.netpay;
    data['govt_bonus_amt'] = this.govtBonusAmt;
    data['paid_days'] = this.paidDays;
    data['lopdays1'] = this.lopdays1;
    data['taxes'] = this.taxes;
    data['totalarear'] = this.totalarear;
    data['monthdays'] = this.monthdays;
    data['ratebasic'] = this.ratebasic;
    data['ratehra'] = this.ratehra;
    data['ratespecialallowance'] = this.ratespecialallowance;
    data['rategross'] = this.rategross;
    data['arearbasic'] = this.arearbasic;
    data['arearhra'] = this.arearhra;
    data['arearallowance'] = this.arearallowance;
    data['areargross'] = this.areargross;
    data['cjcode'] = this.cjcode;
    data['jobtype'] = this.jobtype;
    data['dateofbirth'] = this.dateofbirth;
    data['pancardnumber'] = this.pancardnumber;

    return data;
  }
}

class DeductionComponent {
  var deductionName;
  var amt;

  DeductionComponent({this.deductionName, this.amt});

  DeductionComponent.fromJson(Map<String, dynamic> json) {
    deductionName = json['deduction_name'];
    amt = json['amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deduction_name'] = this.deductionName;
    data['amt'] = this.amt;
    return data;
  }
}

class VariableComponent {
  var variableName;
  var amt;

  VariableComponent({this.variableName, this.amt});

  VariableComponent.fromJson(Map<String, dynamic> json) {
    variableName = json['variable_name'];
    amt = json['amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variable_name'] = this.variableName;
    data['amt'] = this.amt;
    return data;
  }
}