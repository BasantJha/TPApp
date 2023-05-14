
class HrConnect_PendingQuery_ModelResponse
{
  bool? statusCode;
  String? message;
  Data? data;

  HrConnect_PendingQuery_ModelResponse
      ({this.statusCode, this.message, this.data});

  HrConnect_PendingQuery_ModelResponse.fromJson
      (Map<String, dynamic> json) {
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

class Data
{
  List<Queries>? queries;
  Data({this.queries});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['queries'] != null) {
      queries = <Queries>[];
      json['queries'].forEach((v) {
        queries!.add(new Queries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.queries != null) {
      data['queries'] = this.queries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Queries {
  int? queryMasterId;
  int? queryTrailId;
  int? userid;
  int? userrole;
  var subject;
  var queryComment;
  Null status;
  Null jsonDocuments;
  var ip;
  var createdon;
  Null usertype;
  int? createdby;
  Null querySource;
  int? contractId;
  Null queryOrigin;
  Null contractName;
  int? createdbyrole;
  Null quseryfetchtype;
  int? queryuserid;
  var modifiedon;
  int? modifiedby;
  var closedon;
  int? closedby;
  Null closedbyuser;
  Null employeename;
  Null customeraccountname;
  int? chatcount;
  Null concerneddepartment;
  Null timeElapsed;
  var subjectDesc;
  int? subjectId;
  int? empCode;

  Queries(
      { this.queryMasterId,
        this.queryTrailId,
        this.userid,
        this.userrole,
        this.subject,
        this.queryComment,
        this.status,
        this.jsonDocuments,
        this.ip,
        this.createdon,
        this.usertype,
        this.createdby,
        this.querySource,
        this.contractId,
        this.queryOrigin,
        this.contractName,
        this.createdbyrole,
        this.quseryfetchtype,
        this.queryuserid,
        this.modifiedon,
        this.modifiedby,
        this.closedon,
        this.closedby,
        this.closedbyuser,
        this.employeename,
        this.customeraccountname,
        this.chatcount,
        this.concerneddepartment,
        this.timeElapsed,
        this.subjectDesc,
        this.subjectId,
        this.empCode});

  Queries.fromJson(Map<String, dynamic> json) {
    queryMasterId = json['query_master_id'];
    queryTrailId = json['query_trail_id'];
    userid = json['userid'];
    userrole = json['userrole'];
    subject = json['subject'];
    queryComment = json['query_comment'];
    status = json['status'];
    jsonDocuments = json['json_documents'];
    ip = json['ip'];
    createdon = json['createdon'];
    usertype = json['usertype'];
    createdby = json['createdby'];
    querySource = json['query_source'];
    contractId = json['contract_id'];
    queryOrigin = json['query_origin'];
    contractName = json['contractName'];
    createdbyrole = json['createdbyrole'];
    quseryfetchtype = json['quseryfetchtype'];
    queryuserid = json['queryuserid'];
    modifiedon = json['modifiedon'];
    modifiedby = json['modifiedby'];
    closedon = json['closedon'];
    closedby = json['closedby'];
    closedbyuser = json['closedbyuser'];
    employeename = json['employeename'];
    customeraccountname = json['customeraccountname'];
    chatcount = json['chatcount'];
    concerneddepartment = json['concerneddepartment'];
    timeElapsed = json['time_elapsed'];
    subjectDesc = json['subject_desc'];
    subjectId = json['subject_id'];
    empCode = json['emp_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['query_master_id'] = this.queryMasterId;
    data['query_trail_id'] = this.queryTrailId;
    data['userid'] = this.userid;
    data['userrole'] = this.userrole;
    data['subject'] = this.subject;
    data['query_comment'] = this.queryComment;
    data['status'] = this.status;
    data['json_documents'] = this.jsonDocuments;
    data['ip'] = this.ip;
    data['createdon'] = this.createdon;
    data['usertype'] = this.usertype;
    data['createdby'] = this.createdby;
    data['query_source'] = this.querySource;
    data['contract_id'] = this.contractId;
    data['query_origin'] = this.queryOrigin;
    data['contractName'] = this.contractName;
    data['createdbyrole'] = this.createdbyrole;
    data['quseryfetchtype'] = this.quseryfetchtype;
    data['queryuserid'] = this.queryuserid;
    data['modifiedon'] = this.modifiedon;
    data['modifiedby'] = this.modifiedby;
    data['closedon'] = this.closedon;
    data['closedby'] = this.closedby;
    data['closedbyuser'] = this.closedbyuser;
    data['employeename'] = this.employeename;
    data['customeraccountname'] = this.customeraccountname;
    data['chatcount'] = this.chatcount;
    data['concerneddepartment'] = this.concerneddepartment;
    data['time_elapsed'] = this.timeElapsed;
    data['subject_desc'] = this.subjectDesc;
    data['subject_id'] = this.subjectId;
    data['emp_code'] = this.empCode;
    return data;
  }
}