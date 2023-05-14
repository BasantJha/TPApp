class InvestmentDeclaration_OtherIncomeDetails_ModelResponse {
  bool? statusCode;
  var message;
  Data? data;

  InvestmentDeclaration_OtherIncomeDetails_ModelResponse({this.statusCode, this.message, this.data});

  InvestmentDeclaration_OtherIncomeDetails_ModelResponse.fromJson(Map<String, dynamic> json) {
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

class Data
{
  List<PreviousEmployerIncome>? previousEmployerIncome;
  List<PreviousEmployerOtherIncome>? previousEmployerOtherIncome;

  Data({this.previousEmployerIncome, this.previousEmployerOtherIncome});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['previous_employer_income'] != null) {
      previousEmployerIncome = <PreviousEmployerIncome>[];
      json['previous_employer_income'].forEach((v) {
        previousEmployerIncome!.add(new PreviousEmployerIncome.fromJson(v));
      });
    }
    if (json['previous_employer_other_income'] != null) {
      previousEmployerOtherIncome = <PreviousEmployerOtherIncome>[];
      json['previous_employer_other_income'].forEach((v) {
        previousEmployerOtherIncome!.add(new PreviousEmployerOtherIncome.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.previousEmployerIncome != null) {
      data['previous_employer_income'] =
          this.previousEmployerIncome!.map((v) => v.toJson()).toList();
    }
    if (this.previousEmployerOtherIncome != null) {
      data['previous_employer_other_income'] =
          this.previousEmployerOtherIncome!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PreviousEmployerIncome {
  var id;
  var empCode;
  var financialYear;
  var totalIncome;
  var tds;
  var professionalTax;
  var providentFund;
  var total;
  var createdBy;
  var createdOn;
  var createdByIp;
  var modifiedBy;
  var modifiedOn;
  var modifiedByIp;
  var active;

  PreviousEmployerIncome(
      {this.id,
        this.empCode,
        this.financialYear,
        this.totalIncome,
        this.tds,
        this.professionalTax,
        this.providentFund,
        this.total,
        this.createdBy,
        this.createdOn,
        this.createdByIp,
        this.modifiedBy,
        this.modifiedOn,
        this.modifiedByIp,
        this.active});

  PreviousEmployerIncome.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empCode = json['emp_code'];
    financialYear = json['financial_year'];
    totalIncome = json['total_income'];
    tds = json['tds'];
    professionalTax = json['professional_tax'];
    providentFund = json['provident_fund'];
    total = json['total'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    createdByIp = json['created_by_ip'];
    modifiedBy = json['modified_by'];
    modifiedOn = json['modified_on'];
    modifiedByIp = json['modified_by_ip'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emp_code'] = this.empCode;
    data['financial_year'] = this.financialYear;
    data['total_income'] = this.totalIncome;
    data['tds'] = this.tds;
    data['professional_tax'] = this.professionalTax;
    data['provident_fund'] = this.providentFund;
    data['total'] = this.total;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['created_by_ip'] = this.createdByIp;
    data['modified_by'] = this.modifiedBy;
    data['modified_on'] = this.modifiedOn;
    data['modified_by_ip'] = this.modifiedByIp;
    data['active'] = this.active;
    return data;
  }
}

class PreviousEmployerOtherIncome {
  var id;
  var empCode;
  var financialYear;
  var incomeFromOtherSources;
  var businessIncome;
  var incomeFromCapitalGains;
  var anyOtherIncome;
  var interestOnSavingBank;
  var tdsOthers;
  var total;
  var createdBy;
  var createdOn;
  var createdByIp;
  var modifiedBy;
  var modifiedOn;
  var modifiedByIp;
  var active;

  PreviousEmployerOtherIncome(
      {this.id,
        this.empCode,
        this.financialYear,
        this.incomeFromOtherSources,
        this.businessIncome,
        this.incomeFromCapitalGains,
        this.anyOtherIncome,
        this.interestOnSavingBank,
        this.tdsOthers,
        this.total,
        this.createdBy,
        this.createdOn,
        this.createdByIp,
        this.modifiedBy,
        this.modifiedOn,
        this.modifiedByIp,
        this.active});

  PreviousEmployerOtherIncome.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empCode = json['emp_code'];
    financialYear = json['financial_year'];
    incomeFromOtherSources = json['income_from_other_sources'];
    businessIncome = json['business_income'];
    incomeFromCapitalGains = json['income_from_capital_gains'];
    anyOtherIncome = json['any_other_income'];
    interestOnSavingBank = json['interest_on_saving_bank'];
    tdsOthers = json['tds_others'];
    total = json['total'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    createdByIp = json['created_by_ip'];
    modifiedBy = json['modified_by'];
    modifiedOn = json['modified_on'];
    modifiedByIp = json['modified_by_ip'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emp_code'] = this.empCode;
    data['financial_year'] = this.financialYear;
    data['income_from_other_sources'] = this.incomeFromOtherSources;
    data['business_income'] = this.businessIncome;
    data['income_from_capital_gains'] = this.incomeFromCapitalGains;
    data['any_other_income'] = this.anyOtherIncome;
    data['interest_on_saving_bank'] = this.interestOnSavingBank;
    data['tds_others'] = this.tdsOthers;
    data['total'] = this.total;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['created_by_ip'] = this.createdByIp;
    data['modified_by'] = this.modifiedBy;
    data['modified_on'] = this.modifiedOn;
    data['modified_by_ip'] = this.modifiedByIp;
    data['active'] = this.active;
    return data;
  }
}