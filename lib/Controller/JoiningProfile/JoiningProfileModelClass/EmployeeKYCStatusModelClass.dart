
class EmployeeKYCStatusModelClass {
  bool? statusCode;
  String? message;
  Data? data;

  EmployeeKYCStatusModelClass({this.statusCode, this.message, this.data});

  EmployeeKYCStatusModelClass.fromJson(Map<String, dynamic> json) {
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
  int? empId;
  var empName;
  var postOffered;
  var dateofjoining;
  var email;
  var mobile;
  var joiningstatus;
  int? jsId;
  var gender;
  var empCode;
  var bankaccountno;
  var ifsccode;
  var pfnumber;
  var uannumber;
  var esinumber;
  var jobid;
  int? contractid;
  var trackingid;
  var tpcode;
  var crmOrderId;
  var basic;
  var hra;
  var allowances;
  var gross;
  var salaryinhand;
  var ctc;
  var aadharverficationStatus;
  var accountVerificationStatus;
  var panVerificationStatus;
  var benifitmsg;
  var pancard;
  var fathername;
  var residentialAddress;
  var empDob;
  var pin;
  var pinstatus;
  var recordsource;
  var photopath;
  var permanentAddress;
  var accountname;
  var clientgst;
  var accountContactName;
  int? customeraccountid;
  String? ecstatus;
  var dispensarydetails;
  var profileMinwagestate;
  var pfopted;//use for the uan number status


  Data(
      {this.empId,
        this.empName,
        this.postOffered,
        this.dateofjoining,
        this.email,
        this.mobile,
        this.joiningstatus,
        this.jsId,
        this.gender,
        this.empCode,
        this.bankaccountno,
        this.ifsccode,
        this.pfnumber,
        this.uannumber,
        this.esinumber,
        this.jobid,
        this.contractid,
        this.trackingid,
        this.tpcode,
        this.crmOrderId,
        this.basic,
        this.hra,
        this.allowances,
        this.gross,
        this.salaryinhand,
        this.ctc,
        this.aadharverficationStatus,
        this.accountVerificationStatus,
        this.panVerificationStatus,
        this.benifitmsg,
        this.pancard,
        this.fathername,
        this.residentialAddress,
        this.empDob,
        this.pin,
        this.pinstatus,
        this.recordsource,
        this.photopath,
        this.permanentAddress,
        this.accountname,
        this.clientgst,
        this.accountContactName,this.customeraccountid, this.ecstatus,
        this.dispensarydetails,
        this.profileMinwagestate,
        this.pfopted});

  Data.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'];
    empName = json['emp_name'];
    postOffered = json['post_offered'];
    dateofjoining = json['dateofjoining'];
    email = json['email'];
    mobile = json['mobile'];
    joiningstatus = json['joiningstatus'];
    jsId = json['js_id'];
    gender = json['gender'];
    empCode = json['emp_code'];
    bankaccountno = json['bankaccountno'];
    ifsccode = json['ifsccode'];
    pfnumber = json['pfnumber'];
    uannumber = json['uannumber'];
    esinumber = json['esinumber'];
    jobid = json['jobid'];
    contractid = json['contractid'];
    trackingid = json['trackingid'];
    tpcode = json['tpcode'];
    crmOrderId = json['crm_order_id'];
    basic = json['basic'];
    hra = json['hra'];
    allowances = json['allowances'];
    gross = json['gross'];
    salaryinhand = json['salaryinhand'];
    ctc = json['ctc'];
    aadharverficationStatus = json['aadharverfication_status'];
    accountVerificationStatus = json['account_verification_status'];
    panVerificationStatus = json['pan_verification_status'];
    benifitmsg = json['benifitmsg'];
    pancard = json['pancard'];
    fathername = json['fathername'];
    residentialAddress = json['residential_address'];
    empDob = json['emp_dob'];
    pin = json['pin'];
    pinstatus = json['pinstatus'];
    recordsource = json['recordsource'];
    photopath = json['photopath'];
    permanentAddress = json['permanent_address'];
    accountname = json['accountname'];
    clientgst = json['clientgst'];
    accountContactName = json['account_contact_name'];
    customeraccountid = json['customeraccountid'];
    ecstatus = json['ecstatus'];
    dispensarydetails = json['dispensarydetails'];
    profileMinwagestate = json['profile_minwagestate'];
    pfopted = json['pfopted'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.empId;
    data['emp_name'] = this.empName;
    data['post_offered'] = this.postOffered;
    data['dateofjoining'] = this.dateofjoining;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['joiningstatus'] = this.joiningstatus;
    data['js_id'] = this.jsId;
    data['gender'] = this.gender;
    data['emp_code'] = this.empCode;
    data['bankaccountno'] = this.bankaccountno;
    data['ifsccode'] = this.ifsccode;
    data['pfnumber'] = this.pfnumber;
    data['uannumber'] = this.uannumber;
    data['esinumber'] = this.esinumber;
    data['jobid'] = this.jobid;
    data['contractid'] = this.contractid;
    data['trackingid'] = this.trackingid;
    data['tpcode'] = this.tpcode;
    data['crm_order_id'] = this.crmOrderId;
    data['basic'] = this.basic;
    data['hra'] = this.hra;
    data['allowances'] = this.allowances;
    data['gross'] = this.gross;
    data['salaryinhand'] = this.salaryinhand;
    data['ctc'] = this.ctc;
    data['aadharverfication_status'] = this.aadharverficationStatus;
    data['account_verification_status'] = this.accountVerificationStatus;
    data['pan_verification_status'] = this.panVerificationStatus;
    data['benifitmsg'] = this.benifitmsg;
    data['pancard'] = this.pancard;
    data['fathername'] = this.fathername;
    data['residential_address'] = this.residentialAddress;
    data['emp_dob'] = this.empDob;
    data['pin'] = this.pin;
    data['pinstatus'] = this.pinstatus;
    data['recordsource'] = this.recordsource;
    data['photopath'] = this.photopath;
    data['permanent_address'] = this.permanentAddress;
    data['accountname'] = this.accountname;
    data['clientgst'] = this.clientgst;
    data['account_contact_name'] = this.accountContactName;
    data['customeraccountid'] = this.customeraccountid;
    data['ecstatus'] = this.ecstatus;
    data['dispensarydetails'] = this.dispensarydetails;
    data['profile_minwagestate'] = this.profileMinwagestate;
    data['pfopted'] = this.pfopted;

    return data;
  }
}