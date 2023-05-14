// ignore: camel_case_types
class SalaryStatus_ModelResponse
{
  bool? statusCode;
  String? message;
  Data? data;

  SalaryStatus_ModelResponse({this.statusCode, this.message, this.data});

  SalaryStatus_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var empCode;
  var mprMonth;
  var mprYear;
  var salaryStatus;
  var attendanceReceiveDate;
  var payrollProcessingDate;
  var accountProcessingDate;
  var bankTransferDate;
  var salaryMonths;

  Data(
      {this.empCode,
        this.mprMonth,
        this.mprYear,
        this.salaryStatus,
        this.attendanceReceiveDate,
        this.payrollProcessingDate,
        this.accountProcessingDate,
        this.bankTransferDate,
        this.salaryMonths});

  Data.fromJson(Map<String, dynamic> json) {
    empCode = json['emp_code'];
    mprMonth = json['mpr_month'];
    mprYear = json['mpr_year'];
    salaryStatus = json['salary_status'];
    attendanceReceiveDate = json['attendance_receive_date'];
    payrollProcessingDate = json['payroll_processing_date'];
    accountProcessingDate = json['account_processing_date'];
    bankTransferDate = json['bank_transfer_date'];
    salaryMonths=json['salary_months'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_code'] = this.empCode;
    data['mpr_month'] = this.mprMonth;
    data['mpr_year'] = this.mprYear;
    data['salary_status'] = this.salaryStatus;
    data['attendance_receive_date'] = this.attendanceReceiveDate;
    data['payroll_processing_date'] = this.payrollProcessingDate;
    data['account_processing_date'] = this.accountProcessingDate;
    data['bank_transfer_date'] = this.bankTransferDate;
    data['salary_months'] = this.salaryMonths;

    return data;
  }
}