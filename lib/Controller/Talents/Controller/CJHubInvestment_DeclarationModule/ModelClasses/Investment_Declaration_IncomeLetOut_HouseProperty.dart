class Investment_Declaration_IncomeLetOut_HouseProperty {
  bool? statusCode;
  var message;
  List<Data>? data;

  Investment_Declaration_IncomeLetOut_HouseProperty({this.statusCode, this.message, this.data});

  Investment_Declaration_IncomeLetOut_HouseProperty.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  var id;
  var empCode;
  var financialYear;
  var isHavingLoan;
  var grossAnnualRentalIncome;
  var municipalTaxes;
  var netAnnualValue;
  var standardDeduction;
  var interestOnBorrowedCapital;
  var netIncomeFromHouse;
  var createdBy;
  var createdOn;
  var createdByIp;
  var modifiedBy;
  var modifiedOn;
  var modifiedByIp;
  var active;

  Data(
      {this.id,
        this.empCode,
        this.financialYear,
        this.isHavingLoan,
        this.grossAnnualRentalIncome,
        this.municipalTaxes,
        this.netAnnualValue,
        this.standardDeduction,
        this.interestOnBorrowedCapital,
        this.netIncomeFromHouse,
        this.createdBy,
        this.createdOn,
        this.createdByIp,
        this.modifiedBy,
        this.modifiedOn,
        this.modifiedByIp,
        this.active});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empCode = json['emp_code'];
    financialYear = json['financial_year'];
    isHavingLoan = json['is_having_loan'];
    grossAnnualRentalIncome = json['gross_annual_rental_income'];
    municipalTaxes = json['municipal_taxes'];
    netAnnualValue = json['net_annual_value'];
    standardDeduction = json['standard_deduction'];
    interestOnBorrowedCapital = json['interest_on_borrowed_capital'];
    netIncomeFromHouse = json['net_income_from_house'];
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
    data['is_having_loan'] = this.isHavingLoan;
    data['gross_annual_rental_income'] = this.grossAnnualRentalIncome;
    data['municipal_taxes'] = this.municipalTaxes;
    data['net_annual_value'] = this.netAnnualValue;
    data['standard_deduction'] = this.standardDeduction;
    data['interest_on_borrowed_capital'] = this.interestOnBorrowedCapital;
    data['net_income_from_house'] = this.netIncomeFromHouse;
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