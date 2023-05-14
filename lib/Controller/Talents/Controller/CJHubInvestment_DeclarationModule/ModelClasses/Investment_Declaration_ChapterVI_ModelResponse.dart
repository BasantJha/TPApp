
class Investment_Declaration_ChapterVI_ModelResponse {
  bool? statusCode;
  var message;
  Data? data;

  Investment_Declaration_ChapterVI_ModelResponse({this.statusCode, this.message, this.data});

  Investment_Declaration_ChapterVI_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  List<SectionInvestmentHeadList>? sectionInvestmentHeadList;
  List<InvestmentChoices>? investmentChoices;

  Data({this.sectionInvestmentHeadList, this.investmentChoices});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['section_investment_head_list'] != null) {
      sectionInvestmentHeadList = <SectionInvestmentHeadList>[];
      json['section_investment_head_list'].forEach((v) {
        sectionInvestmentHeadList!.add(new SectionInvestmentHeadList.fromJson(v));
      });
    }
    if (json['investment_choices'] != null) {
      investmentChoices = <InvestmentChoices>[];
      json['investment_choices'].forEach((v) {
        investmentChoices!.add(new InvestmentChoices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sectionInvestmentHeadList != null) {
      data['section_investment_head_list'] =
          this.sectionInvestmentHeadList!.map((v) => v.toJson()).toList();
    }
    if (this.investmentChoices != null) {
      data['investment_choices'] =
          this.investmentChoices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SectionInvestmentHeadList {
  var financialYear;
  var headId;
  var sectionName;
  var investmentId;
  var investmentName;
  var investmentDescription;
  var investmentAmount;
  var investmentComment;
  var maxLimit;

  SectionInvestmentHeadList(
      {this.financialYear,
        this.headId,
        this.sectionName,
        this.investmentId,
        this.investmentName,
        this.investmentDescription,
        this.investmentAmount,
        this.investmentComment,
        this.maxLimit});

  SectionInvestmentHeadList.fromJson(Map<String, dynamic> json) {
    financialYear = json['financial_year'];
    headId = json['head_id'];
    sectionName = json['section_name'];
    investmentId = json['investment_id'];
    investmentName = json['investment_name'];
    investmentDescription = json['investment_description'];
    investmentAmount = json['investment_amount'];
    investmentComment = json['investment_comment'];
    maxLimit = json['max_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['financial_year'] = this.financialYear;
    data['head_id'] = this.headId;
    data['section_name'] = this.sectionName;
    data['investment_id'] = this.investmentId;
    data['investment_name'] = this.investmentName;
    data['investment_description'] = this.investmentDescription;
    data['investment_amount'] = this.investmentAmount;
    data['investment_comment'] = this.investmentComment;
    data['max_limit'] = this.maxLimit;
    return data;
  }
}

class InvestmentChoices {
  var parentSeniorCitizen;
  var disabilityMoreThan80;
  var empWithSevereDisability;

  InvestmentChoices(
      {this.parentSeniorCitizen,
        this.disabilityMoreThan80,
        this.empWithSevereDisability});

  InvestmentChoices.fromJson(Map<String, dynamic> json) {
    parentSeniorCitizen = json['parent_senior_citizen'];
    disabilityMoreThan80 = json['disability_more_than_80'];
    empWithSevereDisability = json['emp_with_severe_disability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent_senior_citizen'] = this.parentSeniorCitizen;
    data['disability_more_than_80'] = this.disabilityMoreThan80;
    data['emp_with_severe_disability'] = this.empWithSevereDisability;
    return data;
  }
}