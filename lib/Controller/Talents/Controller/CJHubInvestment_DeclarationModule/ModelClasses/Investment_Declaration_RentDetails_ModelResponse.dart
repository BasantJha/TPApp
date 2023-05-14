
class Investment_Declaration_RentDetails_ModelResponse
{
  bool? statusCode;
  var message;
  List<Data>? data;

  Investment_Declaration_RentDetails_ModelResponse({this.statusCode, this.message, this.data});

  Investment_Declaration_RentDetails_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var empCode;
  var financialYear;
  var rentYear;
  var rentMonth;
  var isMetro;
  var rentPaid;
  var noOfChildUnderCea;
  var noOfChildUnderCha;
  var landlordName;
  var landlordPancard;
  var address;

  Data(
      {this.empCode,
        this.financialYear,
        this.rentYear,
        this.rentMonth,
        this.isMetro,
        this.rentPaid,
        this.noOfChildUnderCea,
        this.noOfChildUnderCha,
        this.landlordName,
        this.landlordPancard,
        this.address});

  Data.fromJson(Map<String, dynamic> json) {
    empCode = json['emp_code'];
    financialYear = json['financial_year'];
    rentYear = json['rent_year'];
    rentMonth = json['rent_month'];
    isMetro = json['is_metro'];
    rentPaid = json['rent_paid'];
    noOfChildUnderCea = json['no_of_child_under_cea'];
    noOfChildUnderCha = json['no_of_child_under_cha'];
    landlordName = json['landlord_name'];
    landlordPancard = json['landlord_pancard'];
    address = json['address'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_code'] = this.empCode;
    data['financial_year'] = this.financialYear;
    data['rent_year'] = this.rentYear;
    data['rent_month'] = this.rentMonth;
    data['is_metro'] = this.isMetro;
    data['rent_paid'] = this.rentPaid;
    data['no_of_child_under_cea'] = this.noOfChildUnderCea;
    data['no_of_child_under_cha'] = this.noOfChildUnderCha;
    data['landlord_name'] = this.landlordName;
    data['landlord_pancard'] = this.landlordPancard;
    data['address'] = this.address;
    return data;
  }
}