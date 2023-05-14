class Investment_Declaration_HomeLoanDetails_ModelResponse {
  bool? statusCode;
  var message;
  List<Data>? data;

  Investment_Declaration_HomeLoanDetails_ModelResponse({this.statusCode, this.message, this.data});

  Investment_Declaration_HomeLoanDetails_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var lenderPanNumber1;
  var lenderPanNumber2;
  var lenderPanNumber3;
  var lenderPanNumber4;
  var loanSanctionDate;
  var loanAmount;
  var propertyValue;
  var lenderName;
  var isFirstTimeBuyer;
  var principalOnBorrowedCapital;
  var interestOnBorrowedCapital;
  var createdBy;
  var createdOn;
  var createdByIp;
  var modifiedBy;
  var modifiedOn;
  var modifiedByIp;
  var active;
  var isBefore01Apr1999;

  Data(
      {this.id,
        this.empCode,
        this.financialYear,
        this.lenderPanNumber1,
        this.lenderPanNumber2,
        this.lenderPanNumber3,
        this.lenderPanNumber4,
        this.loanSanctionDate,
        this.loanAmount,
        this.propertyValue,
        this.lenderName,
        this.isFirstTimeBuyer,
        this.principalOnBorrowedCapital,
        this.interestOnBorrowedCapital,
        this.createdBy,
        this.createdOn,
        this.createdByIp,
        this.modifiedBy,
        this.modifiedOn,
        this.modifiedByIp,
        this.active,
        this.isBefore01Apr1999});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empCode = json['emp_code'];
    financialYear = json['financial_year'];
    lenderPanNumber1 = json['lender_pan_number_1'];
    lenderPanNumber2 = json['lender_pan_number_2'];
    lenderPanNumber3 = json['lender_pan_number_3'];
    lenderPanNumber4 = json['lender_pan_number_4'];
    loanSanctionDate = json['loan_sanction_date'];
    loanAmount = json['loan_amount'];
    propertyValue = json['property_value'];
    lenderName = json['lender_name'];
    isFirstTimeBuyer = json['is_first_time_buyer'];
    principalOnBorrowedCapital = json['principal_on_borrowed_capital'];
    interestOnBorrowedCapital = json['interest_on_borrowed_capital'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    createdByIp = json['created_by_ip'];
    modifiedBy = json['modified_by'];
    modifiedOn = json['modified_on'];
    modifiedByIp = json['modified_by_ip'];
    active = json['active'];
    isBefore01Apr1999 = json['is_before_01_apr_1999'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emp_code'] = this.empCode;
    data['financial_year'] = this.financialYear;
    data['lender_pan_number_1'] = this.lenderPanNumber1;
    data['lender_pan_number_2'] = this.lenderPanNumber2;
    data['lender_pan_number_3'] = this.lenderPanNumber3;
    data['lender_pan_number_4'] = this.lenderPanNumber4;
    data['loan_sanction_date'] = this.loanSanctionDate;
    data['loan_amount'] = this.loanAmount;
    data['property_value'] = this.propertyValue;
    data['lender_name'] = this.lenderName;
    data['is_first_time_buyer'] = this.isFirstTimeBuyer;
    data['principal_on_borrowed_capital'] = this.principalOnBorrowedCapital;
    data['interest_on_borrowed_capital'] = this.interestOnBorrowedCapital;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['created_by_ip'] = this.createdByIp;
    data['modified_by'] = this.modifiedBy;
    data['modified_on'] = this.modifiedOn;
    data['modified_by_ip'] = this.modifiedByIp;
    data['active'] = this.active;
    data['is_before_01_apr_1999'] = this.isBefore01Apr1999;
    return data;
  }
}