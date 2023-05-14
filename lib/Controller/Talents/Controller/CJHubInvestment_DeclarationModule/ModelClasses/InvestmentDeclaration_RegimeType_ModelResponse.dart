
class InvestmentDeclaration_RegimeType_ModelResponse
{
  bool? statusCode;
  var message;
  Data? data;

  InvestmentDeclaration_RegimeType_ModelResponse({this.statusCode, this.message, this.data});

  InvestmentDeclaration_RegimeType_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var regimeType;
  var declarationMessage;
  var declarationOrProof;

  Data({this.regimeType, this.declarationMessage, this.declarationOrProof});

  Data.fromJson(Map<String, dynamic> json) {
    regimeType = json['regime_type'];
    declarationMessage = json['declaration_message'];
    declarationOrProof = json['declaration_or_proof'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['regime_type'] = this.regimeType;
    data['declaration_message'] = this.declarationMessage;
    data['declaration_or_proof'] = this.declarationOrProof;
    return data;
  }
}