

class ViewIdCard_ModelResponse {
  bool? statusCode;
  String? message;
  Data? data;

  ViewIdCard_ModelResponse({this.statusCode, this.message, this.data});

  ViewIdCard_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var empId;
  var companyLogo;
  var companyName;
  var companyAddress;
  var employeeName;
  var designation;
  var employeeImagePath;
  var mobile;
  var jobType;
  var careManagerName;
  var careManagerSign;
  var dateOfJoining;
  var clientName;
  var postingLocation;
  var validPeriod;
  var cjCode;



  Data(
      {this.empId,
        this.companyLogo,
        this.companyName,
        this.companyAddress,
        this.employeeName,
        this.designation,
        this.employeeImagePath,
        this.mobile,
        this.jobType,
        this.careManagerName,
        this.careManagerSign,
        this.dateOfJoining,this.clientName,this.postingLocation,this.validPeriod,this.cjCode});

  Data.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'];
    companyLogo = json['company_logo'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    employeeName = json['employee_name'];
    designation = json['designation'];
    employeeImagePath = json['employee_image_path'];
    mobile = json['mobile'];
    jobType = json['job_type'];
    careManagerName = json['care_manager_name'];
    careManagerSign = json['care_manager_sign'];
    dateOfJoining = json['date_of_joining'];
    clientName = json['client_name'];
    postingLocation = json['posting_location'];
    validPeriod = json['valid_period'];
    cjCode = json['cj_code'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.empId;
    data['company_logo'] = this.companyLogo;
    data['company_name'] = this.companyName;
    data['company_address'] = this.companyAddress;
    data['employee_name'] = this.employeeName;
    data['designation'] = this.designation;
    data['employee_image_path'] = this.employeeImagePath;
    data['mobile'] = this.mobile;
    data['job_type'] = this.jobType;
    data['care_manager_name'] = this.careManagerName;
    data['care_manager_sign'] = this.careManagerSign;
    data['date_of_joining'] = this.dateOfJoining;
    data['client_name'] = this.clientName;
    data['posting_location'] = this.postingLocation;
    data['valid_period'] = this.validPeriod;
    data['cj_code'] = this.cjCode;

    return data;
  }
}