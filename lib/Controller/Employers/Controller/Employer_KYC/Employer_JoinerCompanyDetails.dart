import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Employers/Controller/Employer_SignUp/Employer_Business_SignUpKYC.dart';
import 'package:contractjobs/Controller/Employers/Controller/Employer_SignUp/Employer_SignUpKYC.dart';
import 'package:contractjobs/Controller/JobSeekers/ModelClasses/CJCommonResponse.dart';
import 'package:contractjobs/Controller/Talents/ModelClasses/CJTalentCommonModelClass.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CustomRow/AstricRow.dart';
import 'package:contractjobs/CustomView/TextField/TextFieldDecoration.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../Constant/CJAppFlowConstants.dart';
import '../../../../Constant/ValidationClass.dart';
import '../../../../CustomView/BoxDecoration/ContainerBoxDecoration.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../CustomView/HintWidget/HintMessage.dart';
import '../../../../CustomView/Messages/Validation_Messages.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../Services/Messages/Message.dart';
import '../EmployerModelClasses/EmployerSignUpModelClasses/EmployerSignUpModelClass.dart';
import '../Employer_KYCModelClass/Employer_CityModelClass.dart';
import '../Employer_KYCModelClass/Employer_KYCStatusModelClass.dart';
import '../Employer_KYCModelClass/Employer_StateModelClass.dart';
import '../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_AreaOfWorkModelClass.dart';
import '../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../Employer_SignUp/Employer_Congratulations.dart';
import '../Employer_TabBarController/Employer_TabBarController.dart';
import 'Employer_JoinerHome.dart';

class Employer_JoinerCompanyDetails extends StatefulWidget
{
  const Employer_JoinerCompanyDetails({Key? key, required this.employer_kycStatusModelClass, this.liveModelObj}) : super(key: key);

  final Employer_KYCStatusModelClass employer_kycStatusModelClass;
  final Employer_VerifyMobileNoModelClass? liveModelObj;


  @override
  State<Employer_JoinerCompanyDetails> createState() => _Employer_JoinerCompanyDetails(this.employer_kycStatusModelClass);
}
//
class _Employer_JoinerCompanyDetails extends State<Employer_JoinerCompanyDetails>
{

  static const regularFontWeight = FontWeight.w400;
  static const mediumDarkGreyColor = Color(0xff636363);

  final companyDetails_FormKey = GlobalKey<FormState>();

  List<CommonStateList>? stateList;
  List<CommonCityList>? cityList;

  late String selectedValue;
  var selectUserType="";
  bool companyName_Visibility=false;
  bool companyWebsite_Visibility=false;

  String companyName="", companyAddress="", stateId="", cityId="", pinCode="", website="";
  String deviceId="",IPAddress="",mobileNo="";
  final GlobalKey companyGlobalKey = GlobalKey();
  final GlobalKey addressGlobalKey = GlobalKey();
  bool enableStatus=false,addressEnableStatus=false;

  TextEditingController companyName_Controller = TextEditingController();
  TextEditingController companyAddress_Controller = TextEditingController();

  TextEditingController pinCide_Controller = TextEditingController();

  _Employer_JoinerCompanyDetails(employerModelClassObj)
  {
    Employer_KYCStatusModelClass modelObject=employerModelClassObj as Employer_KYCStatusModelClass;
    this.selectUserType=modelObject.userType;
    this.mobileNo=modelObject.employerMobile;

    if(modelObject.gstinNoIsverifyYN=="Y")
      {

        companyName=modelObject.companyName;;
        companyAddress=modelObject.gstPrincipalAddress+", "+modelObject.gstAdditionalAddress;

        companyName_Controller.text=modelObject.companyName;
        companyAddress_Controller.text=modelObject.gstPrincipalAddress+", "+modelObject.gstAdditionalAddress;

        enableStatus=false;
        addressEnableStatus=false;

      }
     else
      {
        if(modelObject.aadharNoIsverifyYN==TankhaPay_Aadhaar_NR) {
          companyName="";
          companyAddress="";
          enableStatus=true;
          addressEnableStatus=true;
        }
        else
          {
            companyName="";
            companyAddress=modelObject.gstPrincipalAddress+","+modelObject.city+","+modelObject.state;
            enableStatus=true;
            addressEnableStatus=false;
          }


      }


    if(this.selectUserType==kEmployer_USERTYPE_Business)
    {
      //use for business
      companyName_Visibility=true;
      companyWebsite_Visibility=true;
      selectUserType=kEmployer_USERTYPE_Business;

    }else
    {
      //use for Individual
      companyName_Visibility=false;
      companyWebsite_Visibility=false;
      selectUserType=kEmployer_USERTYPE_Individual;

      companyName="";
      website="";
    }



  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBasicInfo();

    getServiceRequest_AllStatesList();
  }

  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(onTap: ()
      {
        dismissTheFirstResponder();
      },child: Scaffold(backgroundColor: whiteColor,
      appBar:CJAppBar(getEmployer_SignUpTitle, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),
      body: getResponsiveUI(),
      bottomNavigationBar: Padding(padding: EdgeInsets.only(left: elevatedButtonLeftRightPadding,right:elevatedButtonLeftRightPadding ),
        child: elevatedButtonBottomBar(),) ,
    ),);
  }
  dismissTheFirstResponder()
  {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
  Responsive getResponsiveUI()
  {
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


  SingleChildScrollView MainfunctionUi()
  {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
        child:Form(
          key: companyDetails_FormKey,
          // autovalidateMode: AutovalidateMode.always,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child:selectUserType==kEmployer_USERTYPE_Business?getViewHintTextBlue(getEmployer_KYCCompanyDetailsHint):getViewHintTextBlue("Update Profile")),

              Visibility(visible: companyName_Visibility,child:SizedBox(height: 20),),
              Visibility(visible: companyName_Visibility,child: getAstricRowWithInfo(selectUserType==kEmployer_USERTYPE_Business?"Company Name":"Name",context,companyGlobalKey,getCompanyName_Hint),),
              Visibility(visible: companyName_Visibility,child:SizedBox(height: 7),),
              Visibility(visible: companyName_Visibility,child:Container(
                //padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: TextFormField(controller: companyName_Controller,
                    enabled: enableStatus,
                    //autovalidateMode: AutovalidateMode.always,
                    // maxLength: 10,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp(r'[a-zA-Z\s.]*'), allow: true)
                    ],
                    validator: enableStatus ? validateToCompanyName:null ,
                    onChanged: ( val) {
                      setState(() {
                        companyName = val;
                      });

                      // name = val;
                    },
                    cursorColor: mediumDarkGreyColor,
                    style: TextStyle(),
                    decoration: getTextFieldDecorationWithPrefixIcon(Employer_Icon_CompanyIcon,companyName),

                  )),),
//
              SizedBox(height: 20),

              selectUserType==kEmployer_USERTYPE_Business?getAstricRowWithInfo("Registered Address",context,addressGlobalKey,getCompanyName_Hint):getAstricRow("Address"),

              SizedBox(height: 7),
              Container(
                //padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: TextFormField(enabled: addressEnableStatus,controller: companyAddress_Controller,
                    //autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp(r'[a-z A-Z0-9.\-/=,\;\s]*'), allow: true)
                    ],
                    validator:  addressEnableStatus ? validateToAddress:null,
                    onChanged: ( val)
                    {
                      setState(() {
                        companyAddress = val;
                      });

                    },
                    maxLines: 2,
                    cursorColor: mediumDarkGreyColor,
                    style: TextStyle(),

                    decoration: getTextFieldDecorationWithPrefixIcon(locationGrey_Icon,companyAddress),

                  )),
              SizedBox(height: 20),
              getAstricRow("State"),
              SizedBox(height: 7),
              Container(
                child: stateDropDown('Select State', locationGrey_Icon, validateMsg_state),
              ),
              SizedBox(height: 20),



              getAstricRow("City"),

              SizedBox(height: 7),
              Container(
                child: cityDropDown('Select City', locationGrey_Icon,  validateMsg_city),
              ),
              SizedBox(height: 20),
              getAstricRow("Pin Code"),
              SizedBox(height: 7),
              Container(
                //padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: TextFormField(
                   // autovalidateMode: AutovalidateMode.always,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: validateToPincode,
                    onChanged: ( val) {
                      setState(() {
                        pinCode = val;
                      });

                      // address = val;
                    },
//
                    cursorColor: mediumDarkGreyColor,
                    style: TextStyle(),
                    decoration: getTextFieldDecorationWithPrefixIcon(locationGrey_Icon,"Enter Pin Code"),

                  )),

              Visibility(visible: companyWebsite_Visibility,child:SizedBox(height: 20),),
              Visibility(visible: companyWebsite_Visibility,child:getAstricRow("Company Website"),),
              Visibility(visible: companyWebsite_Visibility,child:SizedBox(height: 7),),
              Visibility(visible: companyWebsite_Visibility,child:Container(
                  child: TextFormField(
                    //autovalidateMode: AutovalidateMode.always,
                    // keyboardType: TextInputType.text,
                    // inputFormatters: [
                    //   FilteringTextInputFormatter(RegExp(r'[a-zA-Z\s.]*'), allow: true)
                    // ],
                    validator: validateToWebsite,
                    onChanged: ( val)
                    {
                      setState(() {
                        website = val;
                      });

                      // name = val;
                    },
                    cursorColor: mediumDarkGreyColor,
                    style: TextStyle(),
                    /*decoration: decoration('anshu@akalinfosys.com',
                                        Employer_Icon_EmailGrey),*/
                    decoration: getTextFieldDecorationWithPrefixIcon(Employer_Icon_WebsiteGrey,"Enter company website"),

                  )),)
            ],
          ),
        ),

      ),
    );
  }

  stateDropDown(String text, String icon,  String validateText)
  {
    return DropdownButtonFormField2(
     // value: val,
      isExpanded: true,
        dropdownWidth: kIsWeb==true?webResponsive_TD_Width-40:MediaQuery.of(context).size.width-50,
        dropdownMaxHeight: 200,
      scrollbarRadius: const Radius.circular(40),
      scrollbarThickness: 6,
      scrollbarAlwaysShow: true,
      offset: Offset(-40, -15),
      decoration: decorationimage(text, icon),

      buttonPadding: const EdgeInsets.only(left: 18, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: stateList?.map((item) => DropdownMenuItem<String>(
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
      onChanged: (value)
      {
        stateId=value!;
        print("show the state name $stateId");

        FocusScope.of(context).requestFocus(FocusNode());

        createBodyWebApi_AllCityList();

      },
      onSaved: (value) {
        selectedValue = value!;
      },
        validator: (value)
        {
          print("show the value $value");

          stateId=value!;


          if (value == null || value.isEmpty)
          {
            return validateText;
          }
        }
    );
  }
  cityDropDown(String text, String icon,  String validateText)
  {
    return DropdownButtonFormField2(
      // value: val,
        isExpanded: true,
        dropdownWidth: kIsWeb==true?webResponsive_TD_Width-40:MediaQuery.of(context).size.width-50,

        dropdownMaxHeight: 200,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: Offset(-40, -15),
        decoration: decorationimage(text, icon),

        buttonPadding: const EdgeInsets.only(left: 18, right: 10),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        items: cityList?.map((item) => DropdownMenuItem<String>(
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
        onChanged: (value)
        {
          cityId=value!;
          print("show the city name $cityId");

          FocusScope.of(context).requestFocus(FocusNode());


        },
        onSaved: (value) {
          selectedValue = value!;
        },
        validator: (value)
        {
          print("show the value $value");

          cityId=value!;


          if (value == null)
          {
            return validateText;
          }
        }
    );
  }

  InputDecoration decorationimage(String hintimage, String Icon)
  {
    return InputDecoration(
      hintText: hintimage,
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
          image: AssetImage(icon,),
        ),
      ),
    );
  }


  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Submit", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action 111");

      submit();
    }
    )) ;

  }

  submit()
  {

    if (companyDetails_FormKey.currentState!.validate())
    {
      print("show the continue action 1");

      createBodyWebApi_SignupCompanyDetails();
    }
    else
    {
      print("show the continue action 2");

      CJSnackBar(context, "Please validate to the fields");
    }

  }

  getBasicInfo()
  {
    Method.getDeviceId().then((value) => {
      deviceId=value,
      //print('show device id $value'),
    });

    Method.getIPAddress().then((value) => {
      IPAddress=value,
    });
  }

  /*--------------get the all states list----------------*/

  getServiceRequest_AllStatesList()
  {
    print("show 1the request2");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().getDataServiceRequest(JG_ApiMethod_GetAllStates,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          Employer_StateModelClass employer_stateModelClass=modelResponse as Employer_StateModelClass;
          print("show the data obj ${employer_stateModelClass.commonStateList}");

          if(employer_stateModelClass.commonStateList!.length>0)
          {
            print("show the data obj ${employer_stateModelClass.commonStateList}");

            setState(() {
              stateList=employer_stateModelClass.commonStateList!;
            });
          }
          else
          {
          }
        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass modelClass=modelResponse as CJTalentCommonModelClass;
          if (modelClass?.message==null || modelClass?.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context, modelClass!.message!);
          }
        }));
  }

  createBodyWebApi_AllCityList()
  {

    print("show city reuest");
    var mapObject=getEmployer_CompanyDetailsAllCities_RequestBody(stateId);
    serviceRequest_AllCityList(mapObject);
  }
  serviceRequest_AllCityList(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_GetAllCities,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          Employer_CityModelClass employer_cityModelClass=modelResponse as Employer_CityModelClass;
          print("show the data obj ${employer_cityModelClass.commonCityList}");

          if(employer_cityModelClass.commonCityList!.length>0) {
            print("show the data obj ${employer_cityModelClass
                .commonCityList}");

            setState(() {
              cityList = employer_cityModelClass.commonCityList!;
            });
          }

          ////

        }, employerFailureBlock:<T>(commonResponse,failure)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass signUpModelClass=commonResponse as CJTalentCommonModelClass;
          if (signUpModelClass?.message==null || signUpModelClass?.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context, signUpModelClass!.message!);
          }

        }));
  }

  /*--------------hit the company details service request start---------------*/
  createBodyWebApi_SignupCompanyDetails()
  {
    int i=0;
    String selectedStateName="";
    for(i=0;i<stateList!.length;i++)
      {
        var searchStateId=stateList![i].id;
        if(searchStateId.toString()==stateId)
          {
            selectedStateName=stateList![i].state!;
            break;
          }
      }
    String selectedCityName="";
    int j=0;
    for(j=0;j<cityList!.length;j++)
    {
      var searchCityId=cityList![j].id;
      if(searchCityId.toString()==cityId)
      {
        selectedCityName=cityList![j].district!;
        break;
      }
    }

    print("show the selectedStateName $selectedStateName");
    print("show the selectedCityName $selectedCityName");


    var mapObject=getEmployer_CompanyDetails_RequestBody(companyName,companyAddress,selectedStateName,selectedCityName,pinCode,website,mobileNo,deviceId,IPAddress);
    serviceRequest_SignUpCompanyDetails(mapObject);

  }

  serviceRequest_SignUpCompanyDetails(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequestFor_EmployerSignUp(mapObj,JG_ApiMethod_EmployerCommonRegistration,kEmployer_FLAG_CD,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          if((commonResponse as CJTalentCommonModelClass).statusCode==true)
          {
            CJSnackBar(context, (commonResponse as CJTalentCommonModelClass).message!);
            TalentNavigation().pushTo(context, Employer_JoinerHome(liveModelObj: widget.liveModelObj,));
          }


        }, employerFailureBlock:<T>(commonResponse,failure)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass signUpModelClass=commonResponse as CJTalentCommonModelClass;
          if (signUpModelClass?.message==null || signUpModelClass?.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }
          else
          {
            CJSnackBar(context, signUpModelClass!.message!);
          }

        }));
  }


}

