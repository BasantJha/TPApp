class TankhaPayGetPendingTrailModelClass {
  bool? statusCode;
  String? message;
  Data? data;

  TankhaPayGetPendingTrailModelClass({this.statusCode, this.message, this.data});

  TankhaPayGetPendingTrailModelClass.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<QueriesTrail>? queriesTrail;

  Data({this.queriesTrail});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['queries_trail'] != null) {
      queriesTrail = <QueriesTrail>[];
      json['queries_trail'].forEach((v) {
        queriesTrail!.add(new QueriesTrail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.queriesTrail != null) {
      data['queries_trail'] =
          this.queriesTrail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QueriesTrail {
  int? queryMasterId;
  int? queryTrailId;
  int? userid;
  String? queryComment;
  String? status;
  String? usertype;
  int? empCode;
  String? documentName;
  String? documentPath;
  String? documentType;

  QueriesTrail(
      {this.queryMasterId,
        this.queryTrailId,
        this.userid,
        this.queryComment,
        this.status,
        this.usertype,
        this.empCode,
        this.documentName,
        this.documentPath,
        this.documentType});

  QueriesTrail.fromJson(Map<String, dynamic> json) {
    queryMasterId = json['query_master_id'];
    queryTrailId = json['query_trail_id'];
    userid = json['userid'];
    queryComment = json['query_comment'];
    status = json['status'];
    usertype = json['usertype'];
    empCode = json['emp_code'];
    documentName = json['document_name'];
    documentPath = json['document_path'];
    documentType = json['document_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['query_master_id'] = this.queryMasterId;
    data['query_trail_id'] = this.queryTrailId;
    data['userid'] = this.userid;
    data['query_comment'] = this.queryComment;
    data['status'] = this.status;
    data['usertype'] = this.usertype;
    data['emp_code'] = this.empCode;
    data['document_name'] = this.documentName;
    data['document_path'] = this.documentPath;
    data['document_type'] = this.documentType;
    return data;
  }
}