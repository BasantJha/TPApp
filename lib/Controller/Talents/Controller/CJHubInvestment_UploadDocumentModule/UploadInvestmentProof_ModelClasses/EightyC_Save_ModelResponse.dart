class EightyC_Save_ModelResponse {
  bool? statusCode;
  var message;
  List<Data>? data;

  EightyC_Save_ModelResponse({this.statusCode, this.message, this.data});

  EightyC_Save_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var investmentAmount;
  var amountProof;
  var approvalStatus;
  var documentPath;
  var documentName;
  var originalDocumentName;

  Data(
      {this.investmentAmount,
        this.amountProof,
        this.approvalStatus,
        this.documentPath,
        this.documentName,
        this.originalDocumentName});

  Data.fromJson(Map<String, dynamic> json) {
    investmentAmount = json['investment_amount'];
    amountProof = json['amount_proof'];
    approvalStatus = json['approval_status'];
    documentPath = json['document_path'];
    documentName = json['document_name'];
    originalDocumentName = json['original_document_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['investment_amount'] = this.investmentAmount;
    data['amount_proof'] = this.amountProof;
    data['approval_status'] = this.approvalStatus;
    data['document_path'] = this.documentPath;
    data['document_name'] = this.documentName;
    data['original_document_name'] = this.originalDocumentName;
    return data;
  }
}