class Investment_Declaration_TaxSection_ModelResponse
{
  bool? statusCode;
  var message;
  List<Data>? data;

  Investment_Declaration_TaxSection_ModelResponse({this.statusCode, this.message, this.data});


  static List<Data> loadDefaultData =[
    Data(
      id: "1",
      headName: "Chapter-VI",
      subHeadName: "A. Deduction to be claimed U\/s CH-VI (A)",
      financialYear: "2021-2022",

    )];

  Investment_Declaration_TaxSection_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var id;
  var financialYear;
  var headName;
  var subHeadName;
  var maxLimit;

  Data(
      {this.id,
        this.financialYear,
        this.headName,
        this.subHeadName,
        this.maxLimit});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    financialYear = json['financial_year'];
    headName = json['head_name'];
    subHeadName = json['sub_head_name'];
    maxLimit = json['max_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['financial_year'] = this.financialYear;
    data['head_name'] = this.headName;
    data['sub_head_name'] = this.subHeadName;
    data['max_limit'] = this.maxLimit;
    return data;
  }


}