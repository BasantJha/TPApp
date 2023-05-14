class GetProfileDetailsJS_ModelResponse
{
  bool? statusCode;
  String? message;
  List<Data>? data;

  GetProfileDetailsJS_ModelResponse({this.statusCode, this.message, this.data});

  GetProfileDetailsJS_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var empSalutations;
  var empName;
  var empEmail;
  var empMobile;
  var empDob;
  var empFatherName;
  var empGender;
  var empResidentialAddress;
  var empMaritalStatus;
  var empAddress;
  var empEmergencyContact;
  var empEmeConBloodRelName;
  var espivStatus;

  Data(
      {this.empSalutations,
        this.empName,
        this.empEmail,
        this.empMobile,
        this.empDob,
        this.empFatherName,
        this.empGender,
        this.empResidentialAddress,
        this.empMaritalStatus,
        this.empAddress,
        this.empEmergencyContact,
        this.empEmeConBloodRelName,
        this.espivStatus});

  Data.fromJson(Map<String, dynamic> json) {
    empSalutations = json['emp_salutations'];
    empName = json['emp_name'];
    empEmail = json['emp_email'];
    empMobile = json['emp_mobile'];
    empDob = json['emp_dob'];
    empFatherName = json['emp_father_name'];
    empGender = json['emp_gender'];
    empResidentialAddress = json['emp_residential_address'];
    empMaritalStatus = json['emp_marital_status'];
    empAddress = json['emp_address'];
    empEmergencyContact = json['emp_emergency_contact'];
    empEmeConBloodRelName = json['emp_eme_con_blood_rel_name'];
    espivStatus = json['espiv_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_salutations'] = this.empSalutations;
    data['emp_name'] = this.empName;
    data['emp_email'] = this.empEmail;
    data['emp_mobile'] = this.empMobile;
    data['emp_dob'] = this.empDob;
    data['emp_father_name'] = this.empFatherName;
    data['emp_gender'] = this.empGender;
    data['emp_residential_address'] = this.empResidentialAddress;
    data['emp_marital_status'] = this.empMaritalStatus;
    data['emp_address'] = this.empAddress;
    data['emp_emergency_contact'] = this.empEmergencyContact;
    data['emp_eme_con_blood_rel_name'] = this.empEmeConBloodRelName;
    data['espiv_status'] = this.espivStatus;
    return data;
  }
}