class Investment_Declaration_CarDetails_ModelResponse {
  bool? statusCode;
  var message;
  List<Data>? data;

  Investment_Declaration_CarDetails_ModelResponse({this.statusCode, this.message, this.data});

  Investment_Declaration_CarDetails_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var declarationYear;
  var declarationMonth;
  var carDetail;
  var above1point6Cc;
  var driver;
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
        this.declarationYear,
        this.declarationMonth,
        this.carDetail,
        this.above1point6Cc,
        this.driver,
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
    declarationYear = json['declaration_year'];
    declarationMonth = json['declaration_month'];
    carDetail = json['car_detail'];
    above1point6Cc = json['above_1point6_cc'];
    driver = json['driver'];
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
    data['declaration_year'] = this.declarationYear;
    data['declaration_month'] = this.declarationMonth;
    data['car_detail'] = this.carDetail;
    data['above_1point6_cc'] = this.above1point6Cc;
    data['driver'] = this.driver;
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