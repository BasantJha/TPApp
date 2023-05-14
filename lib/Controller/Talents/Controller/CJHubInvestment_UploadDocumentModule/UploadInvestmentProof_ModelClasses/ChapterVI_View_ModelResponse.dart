class ChapterVI_View_ModelResponse
{
  bool? statusCode;
  var message;
  List<Data>? data;

  ChapterVI_View_ModelResponse({this.statusCode, this.message, this.data});

  ChapterVI_View_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var headId;
  var investmentId;
  var investmentName;
  var approvalStatus;
  var originalDocumentName;
  var documentName;
  var documentPath;
  var receiptAmount;
  var receiptNumber;
  var receiptDate;
  var parentSeniorCitizen;
  var disabilityMoreThan80;
  var employeeWithSevereDisability;

  Data(
      {this.headId,
        this.investmentId,
        this.investmentName,
        this.approvalStatus,
        this.originalDocumentName,
        this.documentName,
        this.documentPath,
        this.receiptAmount,
        this.receiptNumber,
        this.receiptDate,
        this.parentSeniorCitizen,
        this.disabilityMoreThan80,
        this.employeeWithSevereDisability});

  Data.fromJson(Map<String, dynamic> json) {
    headId = json['head_id'];
    investmentId = json['investment_id'];
    investmentName = json['investment_name'];
    approvalStatus = json['approval_status'];
    originalDocumentName = json['original_document_name'];
    documentName = json['document_name'];
    documentPath = json['document_path'];
    receiptAmount = json['receipt_amount'];
    receiptNumber = json['receipt_number'];
    receiptDate = json['receipt_date'];
    parentSeniorCitizen = json['parent_senior_citizen'];
    disabilityMoreThan80 = json['disability_more_than_80'];
    employeeWithSevereDisability = json['employee_with_severe_disability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['head_id'] = this.headId;
    data['investment_id'] = this.investmentId;
    data['investment_name'] = this.investmentName;
    data['approval_status'] = this.approvalStatus;
    data['original_document_name'] = this.originalDocumentName;
    data['document_name'] = this.documentName;
    data['document_path'] = this.documentPath;
    data['receipt_amount'] = this.receiptAmount;
    data['receipt_number'] = this.receiptNumber;
    data['receipt_date'] = this.receiptDate;
    data['parent_senior_citizen'] = this.parentSeniorCitizen;
    data['disability_more_than_80'] = this.disabilityMoreThan80;
    data['employee_with_severe_disability'] = this.employeeWithSevereDisability;
    return data;
  }
}



