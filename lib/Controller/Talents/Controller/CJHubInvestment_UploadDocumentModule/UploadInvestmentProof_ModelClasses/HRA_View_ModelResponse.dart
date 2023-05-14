
class HRA_View_ModelResponse {
  bool? statusCode;
  var message;
  List<Data>? data;

  HRA_View_ModelResponse({this.statusCode, this.message, this.data});

  HRA_View_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var headId;
  var fromDate;
  var toDate;
  var receiptNo;
  var receiptDate;
  var rentAmount;
  var landlordName;
  var landlordAddress;
  var landlordCity;
  var landlordState;
  var landlordStateName;
  var landlordPan;
  var documentName;
  var originalDocumentName;
  var documentPath;
  var approvalStatus;
  var monthlyTenure;
  var monthlyTenureName;

  Data(
      {this.empCode,
        this.headId,
        this.fromDate,
        this.toDate,
        this.receiptNo,
        this.receiptDate,
        this.rentAmount,
        this.landlordName,
        this.landlordAddress,
        this.landlordCity,
        this.landlordState,
        this.landlordStateName,
        this.landlordPan,
        this.documentName,
        this.originalDocumentName,
        this.documentPath,
        this.approvalStatus,
        this.monthlyTenure,
        this.monthlyTenureName});

  Data.fromJson(Map<String, dynamic> json) {
    empCode = json['emp_code'];
    headId = json['head_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    receiptNo = json['receipt_no'];
    receiptDate = json['receipt_date'];
    rentAmount = json['rent_amount'];
    landlordName = json['landlord_name'];
    landlordAddress = json['landlord_address'];
    landlordCity = json['landlord_city'];
    landlordState = json['landlord_state'];
    landlordStateName = json['landlord_state_name'];
    landlordPan = json['landlord_pan'];
    documentName = json['document_name'];
    originalDocumentName = json['original_document_name'];
    documentPath = json['document_path'];
    approvalStatus = json['approval_status'];
    monthlyTenure = json['monthly_tenure'];
    monthlyTenureName = json['monthly_tenure_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_code'] = this.empCode;
    data['head_id'] = this.headId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['receipt_no'] = this.receiptNo;
    data['receipt_date'] = this.receiptDate;
    data['rent_amount'] = this.rentAmount;
    data['landlord_name'] = this.landlordName;
    data['landlord_address'] = this.landlordAddress;
    data['landlord_city'] = this.landlordCity;
    data['landlord_state'] = this.landlordState;
    data['landlord_state_name'] = this.landlordStateName;
    data['landlord_pan'] = this.landlordPan;
    data['document_name'] = this.documentName;
    data['original_document_name'] = this.originalDocumentName;
    data['document_path'] = this.documentPath;
    data['approval_status'] = this.approvalStatus;
    data['monthly_tenure'] = this.monthlyTenure;
    data['monthly_tenure_name'] = this.monthlyTenureName;
    return data;
  }
}