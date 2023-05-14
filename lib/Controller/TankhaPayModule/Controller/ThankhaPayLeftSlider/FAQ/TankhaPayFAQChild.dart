class TankhaFAQModel {
  String? title;
  String? body;

  TankhaFAQModel({this.title, this.body});

  TankhaFAQModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}

var getFAQList=[
  TankhaFAQModel(
      title: "How do I update my personal information for EPF ?",
      body:
      "If you want to change your personal details such as name, date of birth, date of exit, father's/husband's name, or date of joining, please fill out the Joint Declaration Form and mail it to us along with copies of any 2 of the documents: PAN card, Voter's Identity Card, Aadhar Card, Passport, Driving License, High School Certificate, Birth certificate, Pay slip, ID card, Attendance register, Register of eligibility."),
  TankhaFAQModel(
      title:
      "I have raised a transfer request on EPF portal/Change of basic details/approval of KYC",
      body:
      "If you want to change your personal details such as name, date of birth, date of exit, father's/husband's name, or date of joining, please fill out the Joint Declaration Form and mail it to us along with copies of any 2 of the documents: PAN card, Voter's Identity Card, Aadhar Card, Passport, Driving License, High School Certificate, Birth certificate, Pay slip, ID card, Attendance register, Register of eligibility."),
  TankhaFAQModel(
      title: "I have raised a request for approval of KYC on the EPF portal.",
      body:
      "If you want to change your personal details such as name, date of birth, date of exit, father's/husband's name, or date of joining, please fill out the Joint Declaration Form and mail it to us along with copies of any 2 of the documents: PAN card, Voter's Identity Card, Aadhar Card, Passport, Driving License, High School Certificate, Birth certificate, Pay slip, ID card, Attendance register, Register of eligibility."),
  TankhaFAQModel(
      title: "I have raised a request for approval of KYC on the EPF portal.",
      body:
      "If you want to change your personal details such as name, date of birth, date of exit, father's/husband's name, or date of joining, please fill out the Joint Declaration Form and mail it to us along with copies of any 2 of the documents: PAN card, Voter's Identity Card, Aadhar Card, Passport, Driving License, High School Certificate, Birth certificate, Pay slip, ID card, Attendance register, Register of eligibility."),
  TankhaFAQModel(
      title: "I have raised a request for approval of KYC on the EPF portal.",
      body:
      "If you want to change your personal details such as name, date of birth, date of exit, father's/husband's name, or date of joining, please fill out the Joint Declaration Form and mail it to us along with copies of any 2 of the documents: PAN card, Voter's Identity Card, Aadhar Card, Passport, Driving License, High School Certificate, Birth certificate, Pay slip, ID card, Attendance register, Register of eligibility."),
];