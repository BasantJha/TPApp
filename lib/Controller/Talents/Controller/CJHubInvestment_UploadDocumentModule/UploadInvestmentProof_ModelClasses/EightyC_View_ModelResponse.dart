
class EightyC_View_ModelResponse
{

  bool? statusCode;
  var message;
  List<Data>? data;

  EightyC_View_ModelResponse({this.statusCode, this.message, this.data});

  EightyC_View_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var investmentAmount;
  var receiptAmount;
  var receiptNumber;
  var receiptDate;
  var amountProof;
  var approvalStatus;
  var documentPath;
  var documentName;
  var originalDocumentName;

  Data(
      {this.headId,
        this.investmentId,
        this.investmentName,
        this.investmentAmount,
        this.receiptAmount,
        this.receiptNumber,
        this.receiptDate,
        this.amountProof,
        this.approvalStatus,
        this.documentPath,
        this.documentName,
        this.originalDocumentName});

  Data.fromJson(Map<String, dynamic> json) {
    headId = json['head_id'];
    investmentId = json['investment_id'];
    investmentName = json['investment_name'];
    investmentAmount = json['investment_amount'];
    receiptAmount = json['receipt_amount'];
    receiptNumber = json['receipt_number'];
    receiptDate = json['receipt_date'];
    amountProof = json['amount_proof'];
    approvalStatus = json['approval_status'];
    documentPath = json['document_path'];
    documentName = json['document_name'];
    originalDocumentName = json['original_document_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['head_id'] = this.headId;
    data['investment_id'] = this.investmentId;
    data['investment_name'] = this.investmentName;
    data['investment_amount'] = this.investmentAmount;
    data['receipt_amount'] = this.receiptAmount;
    data['receipt_number'] = this.receiptNumber;
    data['receipt_date'] = this.receiptDate;
    data['amount_proof'] = this.amountProof;
    data['approval_status'] = this.approvalStatus;
    data['document_path'] = this.documentPath;
    data['document_name'] = this.documentName;
    data['original_document_name'] = this.originalDocumentName;
    return data;
  }

}