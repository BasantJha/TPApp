import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:contractjobs/Constant/ConstantIcon.dart';

import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../Constant/ValidationClass.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/ButtonDecoration/CustomButtonAction.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../CustomView/CustomRow/AstricRow.dart';
import '../../../../../CustomView/Messages/Validation_Messages.dart';
import '../../../../../CustomView/TextField/TextFieldDecoration.dart';
import '../../../../../CustomView/ViewHint/CustomViewHint.dart';
import '../../../../../CustomView/ViewHint/ViewHintText.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../Employer_KYC/Employer_JoinerHome.dart';
import '../../Employer_KYCModelClass/Employer_CityModelClass.dart';
import '../../Employer_KYCModelClass/Employer_StateModelClass.dart';
import '../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'Employer_NewProfile.dart';

class Employer_NewProfileEditBilling extends StatefulWidget {
  // const Employer_Business({Key? key}) : super(key: key);
  Employer_NewProfileEditBilling(
      {Key? key,
      required this.billingAddress,
      required this.pincode,
      required this.state,
      required this.city, this.liveModelObj})
      : super(key: key);
  final String billingAddress;
  final String pincode;
  String? state;
  String? city;
  final Employer_VerifyMobileNoModelClass? liveModelObj;

  @override
  State<Employer_NewProfileEditBilling> createState() =>
      _Employer_NewProfileEditBilling();
}

class _Employer_NewProfileEditBilling
    extends State<Employer_NewProfileEditBilling> {
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();

  static const regularFontWeight = FontWeight.w400;
  static const mediumDarkGreyColor = Color(0xff636363);
  final billingAddress_FormKey = GlobalKey<FormState>();

  List<CommonStateList>? stateList;
  List<CommonCityList>? cityList;
  String? state;
  String? city;
  List<String> selectedItemValue = <String>[];

  late String selectedValue;
  bool companyName_Visibility = false;
  bool companyWebsite_Visibility = false;

  String action = "employerBillingAddres",
      accountid = "18",
      companyAddress = "",
      companyAddress2 = "",
  // stateId = "",
  // cityId = "",
      pinCode = "",
      mobileNo = "";

  @override
  void initState() {
    // TODO: implement initState
    addresscontroller.text = widget.billingAddress;
    pincodecontroller.text = widget.pincode;

    super.initState();
    // getBasicInfo();

    getServiceRequest_AllStatesList();
    createBodyWebApi_AllCityList();
    // var cityname =
    //     cityList?.where((element) => element.id == widget.city).toList();
    // print("City name ${cityname}");
    print("City name ${cityList}");

    print("state name ${widget.state}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CJAppBar(getEmployer_BillingAddressTitle,
          appBarBlock: AppBarBlock(appBarAction: () {
            print("show the action type");
            Navigator.pop(context);
          })),
      body: getResponsiveUI(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            left: elevatedButtonLeftRightPadding,
            right: elevatedButtonLeftRightPadding),
        child: elevatedButtonBottomBar(),
      ),
    );
  }

  Responsive getResponsiveUI() {
    return Responsive(
      mobile: MainfunctionUi(),
      tablet: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUi(),
        ),
      ),
      desktop: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUi(),
        ),
      ),
    );
  }

  SingleChildScrollView MainfunctionUi() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: Form(
          key: billingAddress_FormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: getViewHintTextBlue(getEmployer_BillingAddressHint),
              ),
              SizedBox(height: 20),
              getAstricRow("Address"),
              SizedBox(height: 7),
              Container(
                //padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: TextFormField(
                    controller: addresscontroller,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter(
                          RegExp(r'[a-z A-Z0-9.\-/=,\;\s]*'),
                          allow: true)
                    ],
                    validator: validateToAddress,
                    onChanged: (val) {
                      setState(() {
                        companyAddress = val;
                      });
                    },
                    maxLines: 2,
                    cursorColor: mediumDarkGreyColor,
                    style: TextStyle(),
                    decoration: getTextFieldDecorationWithPrefixIcon(
                        locationGrey_Icon, widget.billingAddress),
                  )),
              SizedBox(height: 20),
              getAstricRow("State"),
              SizedBox(height: 7),
              Container(
                padding: EdgeInsets.only(top: 4, bottom: 4),
                child: stateDropDown(locationGrey_Icon, validateMsg_state),
              ),
              SizedBox(height: 20),
              getAstricRow("City"),
              SizedBox(height: 7),
              Container(
                padding: EdgeInsets.only(top: 4, bottom: 4),
                child: cityDropDown(
                    'Select City', locationGrey_Icon, validateMsg_city),
              ),
              SizedBox(height: 20),
              getAstricRow("Pin Code"),
              SizedBox(height: 7),
              Container(
                //padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: TextFormField(
                    controller: pincodecontroller,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: validateToPincode,
                    onChanged: (val) {
                      setState(() {
                        pinCode = val;
                      });

                      // address = val;
                    },
                    cursorColor: mediumDarkGreyColor,
                    style: TextStyle(),
                    decoration: getTextFieldDecorationWithPrefixIcon(
                        locationGrey_Icon, widget.pincode),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  stateDropDown(String icon, String validateText) {
    return DropdownButtonFormField2(
        isExpanded: true,
        value: widget.state,
        dropdownWidth: kIsWeb==true?webResponsive_TD_Width-40:MediaQuery.of(context).size.width-50,

        dropdownMaxHeight: 200,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: Offset(-40, -15),
        decoration: decorationimage(icon),
        buttonPadding: const EdgeInsets.only(left: 18, right: 10),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        items: stateList
            ?.map((item) => DropdownMenuItem<String>(
          value: item.id.toString(),
          child: Text(
            item.state!,
            style: const TextStyle(
                fontFamily: robotoFontFamily,
                color: mediumDarkGreyColor,
                fontSize: large_FontSize,
                fontWeight: regularFontWeight),
          ),
        ))
            .toList(),
        onChanged: (value) {
          state = value;
          print("show the state name $state");
          var cityname =
          cityList?.where((element) => element.id == widget.city).toList();
          print("City name length ${cityname.toString()}");
          setState(() {
            widget.state = value!;
            createBodyWebApi_AllCityList();
            cityList?.clear(); // added line
            widget.city = null as String;
          });
          print("show the state name ${widget.state}");
          FocusScope.of(context).requestFocus(FocusNode());
        },
        onSaved: (value) {
          selectedValue = value!;
        },
        validator: (value) {
          print("show the value $value");

          widget.state = value!;

          if (value == null) {
            return validateText;
          }
        });
  }

  cityDropDown(String text, String icon, String validateText) {
    return DropdownButtonFormField2(
        hint: widget.city == null ? Text(validateText) : Text(""),
        isExpanded: true,
        value: widget.city,
        dropdownWidth: kIsWeb==true?webResponsive_TD_Width-40:MediaQuery.of(context).size.width-50,

        dropdownMaxHeight: 200,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: Offset(-40, -15),
        decoration: decorationimage(icon),
        buttonPadding: const EdgeInsets.only(left: 18, right: 10),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        items: cityList
            ?.map((item) => DropdownMenuItem<String>(
          value: item.id.toString(),
          child: Text(
            item.district!,
            style: const TextStyle(
                fontFamily: robotoFontFamily,
                color: mediumDarkGreyColor,
                fontSize: large_FontSize,
                fontWeight: regularFontWeight),
          ),
        ))
            .toList(),
        onChanged: (value) {
          // cityId=value!;
          // print("show the city name $cityId");
          setState(() {
            widget.city = value!;
          });
          print("show the city name${widget.city}");
          FocusScope.of(context).requestFocus(FocusNode());
        },
        onSaved: (value) {
          selectedValue = value!;
        },
        validator: (value) {
          print("show the value $value");

          widget.city = value!;

          if (value == null) {
            return validateText;
          }
        });
  }

  InputDecoration decorationimage(String Icon) {
    return InputDecoration(
      // hintText: hintimage,
      hintStyle: TextStyle(
          color: mediumDarkGreyColor,
          fontSize: large_FontSize,
          fontWeight: regularFontWeight,
          fontFamily: robotoFontFamily),
      prefixIcon: Iconimg(Icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }

  Container Iconimg(String icon) {
    return Container(
      //padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
      margin: EdgeInsets.fromLTRB(11, 11, 11, 11),
      height: 5.0,
      width: 5.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            icon,
          ),
        ),
      ),
    );
  }

  Container elevatedButtonBottomBar() {
    return CJElevatedBlueButton("Submit",
        elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: () {
          print("show the continue action 11");

          print("getcity$city");
          print("getstate$state");
          if (billingAddress_FormKey.currentState!.validate()) {
            createBodyWebApi_SignupCompanyDetails();
          }

          // Navigator.pop(context,[Employer_JoinerHome]);
        }));
  }

  /*--------------get the all states list----------------*/

  getServiceRequest_AllStatesList() {
    print("show 1the request2");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().getDataServiceRequest(JG_ApiMethod_GetAllStates,
        cjEmployerResponseBlock: CJEmployerResponseBlock(
            employerSuccessBlock: <T>(commonResponse, modelResponse) {
              EasyLoading.dismiss();

              Employer_StateModelClass employer_stateModelClass =
              modelResponse as Employer_StateModelClass;
              print(
                  "show the data obj ${employer_stateModelClass.commonStateList}");

              if (employer_stateModelClass.commonStateList!.length > 0) {
                print(
                    "show the data obj ${employer_stateModelClass.commonStateList}");

                setState(() {
                  stateList = employer_stateModelClass.commonStateList!;
                });
              } else {}
            }, employerFailureBlock: <T>(commonResponse, modelResponse) {
          EasyLoading.dismiss();

          CJTalentCommonModelClass modelClass =
          modelResponse as CJTalentCommonModelClass;
          if (modelClass?.message == null || modelClass?.message == "") {
            CJSnackBar(context, "server 1 error!");
          } else {
            CJSnackBar(context, modelClass!.message!);
          }
        }));
  }

  createBodyWebApi_AllCityList() {
    print("show city reuest");
    var mapObject =
    getEmployer_CompanyDetailsAllCities_RequestBody(widget.state!);
    serviceRequest_AllCityList(mapObject);
  }

  serviceRequest_AllCityList(Map mapObj) {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(
        mapObj, JG_ApiMethod_GetAllCities,
        cjEmployerResponseBlock: CJEmployerResponseBlock(
            employerSuccessBlock: <T>(commonResponse, modelResponse) {
              EasyLoading.dismiss();
              Employer_CityModelClass employer_cityModelClass =
              modelResponse as Employer_CityModelClass;

              print("show the data obj ${employer_cityModelClass.commonCityList}");

              if (employer_cityModelClass.commonCityList!.length > 0) {
                print(
                    "show the data obj ${employer_cityModelClass.commonCityList}");

                setState(() {
                  cityList = employer_cityModelClass.commonCityList!;
                });
              }
              print("citylist$cityList");

              ////
            }, employerFailureBlock: <T>(commonResponse, failure) {
          EasyLoading.dismiss();

          CJTalentCommonModelClass signUpModelClass =
          commonResponse as CJTalentCommonModelClass;
          if (signUpModelClass?.message == null ||
              signUpModelClass?.message == "") {
            CJSnackBar(context, "server 1 error!");
          } else {
            CJSnackBar(context, signUpModelClass!.message!);
          }
        }));
  }

  /*--------------hit the company details service request start---------------*/
  createBodyWebApi_SignupCompanyDetails() {
    int i = 0;
    String selectedStateName = "";
    for (i = 0; i < stateList!.length; i++) {
      var searchStateId = stateList![i].id;
      if (searchStateId.toString() == widget.state) {
        selectedStateName = stateList![i].state!;
        break;
      }
    }
    String selectedCityName = "";
    int j = 0;
    for (j = 0; j < cityList!.length; j++) {
      var searchCityId = cityList![j].id;
      if (searchCityId.toString() == widget.city) {
        selectedCityName = cityList![j].district!;
        break;
      }
    }

    accountid = widget.liveModelObj?.tpAccountId;
    var mapObject = getEmployer_UpdateBillingAddress_RequestBody(
        accountid,
        addresscontroller.text,
        "",
        selectedStateName,
        selectedCityName,
        pinCode);
    serviceRequest_BillingAddressUpdate(mapObject);
  }

  serviceRequest_BillingAddressUpdate(Map mapObj) {
    print("poststate${widget.state}");
    print("postcity${widget.city}");

    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(
        mapObj, JG_ApiMethod_EmployerUpdateProfile,
        cjEmployerResponseBlock: CJEmployerResponseBlock(
            employerSuccessBlock: <T>(commonResponse, modelResponse) {
              EasyLoading.dismiss();
              CJTalentCommonModelClass billingModelClass =
              commonResponse as CJTalentCommonModelClass;
              if (billingModelClass.statusCode == true) {
                // TalentNavigation().pushTo(context, Employer_JoinerHome(message: "",mobileNo: "",registrationType: "",registrationStatus: 0,userType: "",));

                Navigator.pop(context, [Employer_NewProfile]);
                CJSnackBar(context, billingModelClass!.message!);
              }
            }, employerFailureBlock: <T>(commonResponse, failure) {
          EasyLoading.dismiss();

          CJTalentCommonModelClass billingModelClass =
          commonResponse as CJTalentCommonModelClass;
          if (billingModelClass?.message == null ||
              billingModelClass?.message == "") {
            CJSnackBar(context, "server 1 error!");
          } else {
            CJSnackBar(context, billingModelClass!.message!);
          }
        }));
  }
}

