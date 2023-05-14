
import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../Constant/ConstantIcon.dart';

var socialSecurityBenefitModelList=[
  socialSecurityBenefitModel(
      title: "Healthcare\nBenefits",
      image: ThankhaPay_Icon_HealthCardIcon,
  status: CJThankhaPay_HealthCareBenefit),
  socialSecurityBenefitModel(
      title: "Insurance\nBenefits", image: ThankhaPay_Icon_InsuranceIcon,
      status: CJThankhaPay_InsuranceBenefits),
  socialSecurityBenefitModel(
      title: "Retirement\nBenefits", image: Employer_Icon_RetirementIcon,
      status: CJThankhaPay_RetirementBenefits),
  socialSecurityBenefitModel(
      title: "Other\nBenefits", image: ThankhaPay_Icon_OtherBenefitsIcon,
      status: CJThankhaPay_OtherBenefits),
];



class socialSecurityBenefitModel {
  String? title;
  String? image;
  String? status;

  socialSecurityBenefitModel({this.title, this.image,this.status});

  socialSecurityBenefitModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    status = json['status'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['status'] = this.status;

    return data;
  }
}
var getBundleName="assets/employeebenefitsfiles";
var getBenefitFileExtension="_benefits.html";
var getPrivacyPolicyFileExtension=".html";


String getBenefitHTMLLoadPath(String fileName)
{
  if(fileName=="terms_of_use" || fileName=="privacy_policy")
    {
      return "$getBundleName/$fileName" + getPrivacyPolicyFileExtension;
    }
  else {
    return "$getBundleName/$fileName" + getBenefitFileExtension;
  }
}
