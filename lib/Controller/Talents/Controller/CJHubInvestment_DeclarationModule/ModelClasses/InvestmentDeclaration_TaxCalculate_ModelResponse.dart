class InvestmentDeclaration_TaxCalculate_ModelResponse {
  bool? statusCode;
  var message;
  Data? data;

  InvestmentDeclaration_TaxCalculate_ModelResponse({this.statusCode, this.message, this.data});

  InvestmentDeclaration_TaxCalculate_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var totalIncome;
  var totalSavings;
  var taxableIncome;
  var netPayableTax;
  var taxDeducted;
  var balanceTax;
  var taxSlab;

  Data(
      {this.totalIncome,
        this.totalSavings,
        this.taxableIncome,
        this.netPayableTax,
        this.taxDeducted,
        this.balanceTax,
        this.taxSlab});

  Data.fromJson(Map<String, dynamic> json) {
    totalIncome = json['total_income'];
    totalSavings = json['total_savings'];
    taxableIncome = json['taxable_income'];
    netPayableTax = json['net_payable_tax'];
    taxDeducted = json['tax_deducted'];
    balanceTax = json['balance_tax'];
    taxSlab = json['tax_slab'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_income'] = this.totalIncome;
    data['total_savings'] = this.totalSavings;
    data['taxable_income'] = this.taxableIncome;
    data['net_payable_tax'] = this.netPayableTax;
    data['tax_deducted'] = this.taxDeducted;
    data['balance_tax'] = this.balanceTax;
    data['tax_slab'] = this.taxSlab;
    return data;
  }
}