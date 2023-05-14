

class ProfileDocumentType_ModelResponse {
  bool? statusCode;
  String? message;
  List<Data>? data;


  static List<Data> loadDefaultData =[
    Data(
      documentId: "1",
      documentDescription: "Select Document",
    )];

  ProfileDocumentType_ModelResponse({this.statusCode, this.message, this.data});

  ProfileDocumentType_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var documentId;
  var sectionId;
  var sectionSetId;
  var documentPath;
  var validTo;
  var validFrom;
  var documentDescription;
  var recordSource;
  var acceptStatus;
  var remarks;

  Data(
      {this.documentId,
        this.sectionId,
        this.sectionSetId,
        this.documentPath,
        this.validTo,
        this.validFrom,
        this.documentDescription,
        this.recordSource,
        this.acceptStatus,
        this.remarks});

  Data.fromJson(Map<String, dynamic> json) {
    documentId = json['document_id'];
    sectionId = json['section_id'];
    sectionSetId = json['section_set_id'];
    documentPath = json['document_path'];
    validTo = json['valid_to'];
    validFrom = json['valid_from'];
    documentDescription = json['document_description'];
    recordSource = json['record_source'];
    acceptStatus = json['accept_status'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_id'] = this.documentId;
    data['section_id'] = this.sectionId;
    data['section_set_id'] = this.sectionSetId;
    data['document_path'] = this.documentPath;
    data['valid_to'] = this.validTo;
    data['valid_from'] = this.validFrom;
    data['document_description'] = this.documentDescription;
    data['record_source'] = this.recordSource;
    data['accept_status'] = this.acceptStatus;
    data['remarks'] = this.remarks;
    return data;
  }
}