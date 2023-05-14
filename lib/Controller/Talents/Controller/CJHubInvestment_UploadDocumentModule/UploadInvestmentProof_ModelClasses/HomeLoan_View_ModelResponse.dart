
class HomeLoan_View_ModelResponse {
  bool? statusCode;
  var message;
  List<Data>? data;

  HomeLoan_View_ModelResponse({this.statusCode, this.message, this.data});

  HomeLoan_View_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var loanNo;
  var loanSanctionDate;
  var principalAmount;
  var intrestAmount;
  var nameOfOwner;
  var loanType;
  var loanHolderName;
  var loanHolderType;
  var lenderName;
  var lenderPanNumber1;
  var lenderPanNumber2;
  var lenderPanNumber3;
  var lenderPanNumber4;
  var approvalStatus;
  var documentPath;
  var documentName;
  var originalDocumentName;
  var propertyValue;
  var loanAmount;
  var isBefore01Apr1999;
  var isFirstTimeBuyer;

  Data(
      {this.loanNo,
        this.loanSanctionDate,
        this.principalAmount,
        this.intrestAmount,
        this.nameOfOwner,
        this.loanType,
        this.loanHolderName,
        this.loanHolderType,
        this.lenderName,
        this.lenderPanNumber1,
        this.lenderPanNumber2,
        this.lenderPanNumber3,
        this.lenderPanNumber4,
        this.approvalStatus,
        this.documentPath,
        this.documentName,
        this.originalDocumentName,
        this.propertyValue,
        this.loanAmount,
        this.isBefore01Apr1999,
        this.isFirstTimeBuyer});

  Data.fromJson(Map<String, dynamic> json) {
    loanNo = json['loan_no'];
    loanSanctionDate = json['loan_sanction_date'];
    principalAmount = json['principal_amount'];
    intrestAmount = json['intrest_amount'];
    nameOfOwner = json['name_of_owner'];
    loanType = json['loan_type'];
    loanHolderName = json['loan_holder_name'];
    loanHolderType = json['loan_holder_type'];
    lenderName = json['lender_name'];
    lenderPanNumber1 = json['lender_pan_number1'];
    lenderPanNumber2 = json['lender_pan_number2'];
    lenderPanNumber3 = json['lender_pan_number3'];
    lenderPanNumber4 = json['lender_pan_number4'];
    approvalStatus = json['approval_status'];
    documentPath = json['document_path'];
    documentName = json['document_name'];
    originalDocumentName = json['original_document_name'];
    propertyValue = json['property_value'];
    loanAmount = json['loan_amount'];
    isBefore01Apr1999 = json['is_before_01_apr_1999'];
    isFirstTimeBuyer = json['is_first_time_buyer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_no'] = this.loanNo;
    data['loan_sanction_date'] = this.loanSanctionDate;
    data['principal_amount'] = this.principalAmount;
    data['intrest_amount'] = this.intrestAmount;
    data['name_of_owner'] = this.nameOfOwner;
    data['loan_type'] = this.loanType;
    data['loan_holder_name'] = this.loanHolderName;
    data['loan_holder_type'] = this.loanHolderType;
    data['lender_name'] = this.lenderName;
    data['lender_pan_number1'] = this.lenderPanNumber1;
    data['lender_pan_number2'] = this.lenderPanNumber2;
    data['lender_pan_number3'] = this.lenderPanNumber3;
    data['lender_pan_number4'] = this.lenderPanNumber4;
    data['approval_status'] = this.approvalStatus;
    data['document_path'] = this.documentPath;
    data['document_name'] = this.documentName;
    data['original_document_name'] = this.originalDocumentName;
    data['property_value'] = this.propertyValue;
    data['loan_amount'] = this.loanAmount;
    data['is_before_01_apr_1999'] = this.isBefore01Apr1999;
    data['is_first_time_buyer'] = this.isFirstTimeBuyer;
    return data;
  }
}