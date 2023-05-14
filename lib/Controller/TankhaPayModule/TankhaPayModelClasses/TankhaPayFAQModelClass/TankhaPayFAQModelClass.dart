class TankhaPayFAQModelClass {
  bool? statusCode;
  String? message;
  List<Data>? data;

  TankhaPayFAQModelClass({this.statusCode, this.message, this.data});

  TankhaPayFAQModelClass.fromJson(Map<String, dynamic> json) {
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
  int? faqId;
  String? category;
  String? question;
  String? answer;
  int? seqOrd;
  String? categoryCd;

  Data(
      {this.faqId,
        this.category,
        this.question,
        this.answer,
        this.seqOrd,
        this.categoryCd});

  Data.fromJson(Map<String, dynamic> json) {
    faqId = json['faq_id'];
    category = json['category'];
    question = json['question'];
    answer = json['answer'];
    seqOrd = json['seq_ord'];
    categoryCd = json['category_cd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['faq_id'] = this.faqId;
    data['category'] = this.category;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['seq_ord'] = this.seqOrd;
    data['category_cd'] = this.categoryCd;
    return data;
  }
}