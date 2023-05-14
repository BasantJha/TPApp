class KYC_details_ModelResponse {
  bool? statusCode;
  String? message;
  List<Data>? data;

  KYC_details_ModelResponse({this.statusCode, this.message, this.data});

  KYC_details_ModelResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(new Data.fromJson(v));
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
  var empName;
  var dateOfJoining;
  var bankAccountNo;
  var ifscCode;
  var bankName;
  var bankBranch;
  var pfNumber;
  var uanNumber;
  var esiNumber;
  var aadharCard;
  var panCard;
  var esvStatus;

  Data(
      {this.empName,
        this.dateOfJoining,
        this.bankAccountNo,
        this.ifscCode,
        this.bankName,
        this.bankBranch,
        this.pfNumber,
        this.uanNumber,
        this.esiNumber,
        this.aadharCard,
        this.panCard,
        this.esvStatus});

  Data.fromJson(Map<String, dynamic> json) {
    empName = json['emp_name'];
    dateOfJoining = json['date_of_joining'];
    bankAccountNo = json['bank_account_no'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    bankBranch = json['bank_branch'];
    pfNumber = json['pf_number'];
    uanNumber = json['uan_number'];
    esiNumber = json['esi_number'];
    aadharCard = json['aadhar_card'];
    panCard = json['pan_card'];
    esvStatus = json['esv_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_name'] = this.empName;
    data['date_of_joining'] = this.dateOfJoining;
    data['bank_account_no'] = this.bankAccountNo;
    data['ifsc_code'] = this.ifscCode;
    data['bank_name'] = this.bankName;
    data['bank_branch'] = this.bankBranch;
    data['pf_number'] = this.pfNumber;
    data['uan_number'] = this.uanNumber;
    data['esi_number'] = this.esiNumber;
    data['aadhar_card'] = this.aadharCard;
    data['pan_card'] = this.panCard;
    data['esv_status'] = this.esvStatus;
    return data;
  }
}