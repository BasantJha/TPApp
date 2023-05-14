import 'dart:convert';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/ModelClasses/CJTalentCommonModelClass.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CustomRow/AstricRow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../Constant/ValidationClass.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../CustomView/ContainerView/CustomContainer.dart';
import '../../../../CustomView/Messages/Validation_Messages.dart';
import '../../../../CustomView/TextField/TextFieldDecoration.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../Services/Messages/Message.dart';
import '../EmployerModelClasses/EmployerSignUpModelClasses/EmployerSignUpModelClass.dart';
import '../Employer_KYC/Employer_JoinerHome.dart';
import '../Employer_SignUp/Employer_Congratulations.dart';
import 'Employer_NewCongratulations.dart';
import 'Employer_NewSignUpModelClass/Employer_AreaOfWorkModelClass.dart';
import 'Employer_NewSignUpModelClass/Employer_SignUpNewBusinessModelClass.dart';
import 'Employer_VerifyMobileNo.dart';

enum SingingCharacter { business, individual }

class Employer_SignUpNewBusiness extends StatefulWidget
{
  const Employer_SignUpNewBusiness({Key? key,required this.mobileNo}) : super(key: key);
  final String mobileNo;

  @override
  State<Employer_SignUpNewBusiness> createState() => _Employer_SignUpNewBusiness(mobileNo);
}

class _Employer_SignUpNewBusiness extends State<Employer_SignUpNewBusiness>
{

  static const regularFontWeight = FontWeight.w400;
  static const mediumDarkGreyColor = Color(0xff636363);
  SingingCharacter _character = SingingCharacter.business;
  SingingCharacter _gstCharacter = SingingCharacter.business;

  List<CommonDataEmp>? areaOfWorkList;

  String areaofworkvalue = 'Item 1';
  List<String> areaofwork = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];


  late String selectedValue;
  late String employees;
  final signUpBusinessFormKey = GlobalKey<FormState>();

  double topSpaceHeight=20;
  double spaceBetweenTitleandTextField=5;

  String userType=kEmployer_USERTYPE_Business,GSTStatus="Y",areaOfWork="",noOfEmployee="";

  String deviceId="",IPAddress="",mobileNo="";

  _Employer_SignUpNewBusiness(String mobileNo)
  {
    this.mobileNo=mobileNo;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBasicInfo();
    getServiceRequest_AreaOfWork();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(backgroundColor: whiteColor,
      appBar:CJAppBar(getEmployer_SignUpTitle, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),
      body: getResponsiveUI(),
      bottomNavigationBar:Padding(padding: EdgeInsets.only(left: 20,right:20 ),
        child: elevatedButtonBottomBar(),) ,
    );
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
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child:Form(
          key: signUpBusinessFormKey,
          //autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [


              getTheTankhaPayGrayLogoContainer,
              SizedBox(height: topSpaceHeight+10),

              getAstricRow("Are you an business / Individual?"),
              SizedBox(height: spaceBetweenTitleandTextField),
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: SingingCharacter.business,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value)
                        {
                          setState(()
                          {
                            _character = value!;
                            userType=kEmployer_USERTYPE_Business;
                            _gstCharacter=SingingCharacter.business;
                            GSTStatus="Y";

                            print("show the business value $_character");
                            print("show the business GSTStatus $GSTStatus");

                          });
                        },
                      ),
                      Text('Business')
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: SingingCharacter.individual,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value)
                        {
                          setState(() {
                            _character = value!;
                            userType=kEmployer_USERTYPE_Individual;
                            _gstCharacter=SingingCharacter.individual;
                            GSTStatus="N";

                            print("show the individaul value $_character");
                            print("show the individaul GSTStatus $GSTStatus");


                          });
                        },
                      ),
                      Text('Individual')
                    ],
                  ),

                ],
              ),

              SizedBox(height: topSpaceHeight,),

              getAstricRow("Do you have GSTIN?"),
              SizedBox(height: spaceBetweenTitleandTextField),
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: SingingCharacter.business,
                        groupValue: _gstCharacter,
                        onChanged: (SingingCharacter? value)
                        {
                          /*setState(()
                          {
                            _gstCharacter = value!;
                            GSTStatus="Y";
                          });*/
                        },
                      ),
                      Text('Yes')
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: SingingCharacter.individual,
                        groupValue: _gstCharacter,
                        onChanged: (SingingCharacter? value)
                        {
                          /*setState(()
                          {
                            _gstCharacter = value!;
                            GSTStatus="N";
                          });*/
                        },
                      ),
                      Text('No')
                    ],
                  ),

                ],
              ),

              SizedBox(height: topSpaceHeight),
              getAstricRow("Area of Work"),
              SizedBox(height: spaceBetweenTitleandTextField),
              Container(
                child:
                dropdownbutton('Select Area of Work', areaofworkvalue, areaofwork,validateMsg_state),
              ),
              SizedBox(height: topSpaceHeight),
              getAstricRow("How many Employees do you have?"),
              SizedBox(height: spaceBetweenTitleandTextField),
              Container(
                  child: TextFormField(
                   // autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    //maxLength: 4,
                    validator: (value)
                    {
                      if (value == null || value.length == 0)
                      {
                        return "Please Enter No. of Employees";
                      }
                    },
                    cursorColor: mediumDarkGreyColor,
                    style: TextStyle(),

                    decoration: getTextFieldDecoration("Please Enter Employees"),
                    onChanged: (value)
                    {
                      noOfEmployee=value;
                    },

                  )),
              SizedBox(height: topSpaceHeight),
            ],
          ),
        ),

      ),
    );
  }



  dropdownbutton(String text,String val, List list,String validatetext)
  {
    return DropdownButtonFormField2(
      //autovalidateMode: AutovalidateMode.always,
      // value: val,
      isExpanded: true,
      dropdownWidth: kIsWeb==true?webResponsive_TD_Width-40:MediaQuery.of(context).size.width-50,

      dropdownMaxHeight: 200,
      scrollbarRadius: const Radius.circular(40),
      scrollbarThickness: 6,
      scrollbarAlwaysShow: true,
      offset: Offset(-15, -16),
      decoration: decorationimage(text),

      buttonPadding: const EdgeInsets.only(left: 18, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: areaOfWorkList
          ?.map((item) => DropdownMenuItem<String>(
        value: item.industryId.toString(),
        child: Text(
          item.industryName!,
          style: const TextStyle(
              fontFamily: robotoFontFamily,
              color: mediumDarkGreyColor,
              fontSize: medium_FontSize,
              fontWeight: regularFontWeight),
        ),
      ))
          .toList(),
      validator: (value)
      {
        print("show the value $value");


        if (value == null)
        {
          return validatetext;
        }
      },
      onChanged: (value)
      {
        areaOfWork=value!;

        print("show the change value $value");

        FocusScope.of(context).requestFocus(FocusNode());
      },
      onSaved: (value)
      {
        selectedValue = value!;
        print("show the selected value $value");

      },
    );
  }

  InputDecoration decorationimage(String hintimage)
  {
    return InputDecoration(
      hintText: hintimage,
      hintStyle: TextStyle(
          color: mediumDarkGreyColor,
          fontSize: medium_FontSize,
          fontWeight: regularFontWeight,
          fontFamily: robotoFontFamily),
      // prefixIcon: Iconimg(Icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
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
  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Register Now", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action");
      //_submit();
      // TalentAnimationNavigation().pushBottomToTop(context, VerifyMobile());
      // TalentNavigation().pushTo(context, Employer_NewCongratulations());

      validateToTheFields();
    }
    )) ;
  }

  validateToTheFields()
  {
    print("show the user type $userType");
    print("show the gst status $GSTStatus");

    if (signUpBusinessFormKey.currentState!.validate())
    {
      // TalentAnimationNavigation().pushBottomToTop(context, Employer_SignUpNewBusiness());
      //TalentNavigation().pushTo(context, Employer_SignUpNewBusiness());
      createBodyWebApi_SignupBusinessInfo();
    }
  }

  /*--------------hit the login service request start---------------*/
  createBodyWebApi_SignupBusinessInfo()
  {
    var mapObject=getEmployer_BusinessInfo_RequestBody(userType,GSTStatus,areaOfWork,noOfEmployee,mobileNo,deviceId,IPAddress);
    serviceRequest_SignUpBusinessInfo(mapObject);
  }
//
  serviceRequest_SignUpBusinessInfo(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequestFor_EmployerSignUp(mapObj,JG_ApiMethod_EmployerCommonRegistration,kEmployer_FLAG_BI,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          Employer_SignUpNewBusinessModelClass businessModelClass=modelResponse as Employer_SignUpNewBusinessModelClass;
          if((commonResponse as CJTalentCommonModelClass).statusCode==true)
          {
             /* TalentNavigation().pushTo(context, Employer_NewCongratulations(message: businessModelClass.message!,
                mobileNo: businessModelClass.employerMobile!,
                registrationType: businessModelClass.registrationType!,
              registrationStatus: businessModelClass.employerStatus!.toString(),userType: businessModelClass.userType!,));
*/
              TalentNavigation().pushTo(context, Employer_NewCongratulations(message: (commonResponse as CJTalentCommonModelClass).message!,mobileNo: mobileNo,
                ));
          }

        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass modelObject=commonResponse as CJTalentCommonModelClass;
          print("show the verify message ${modelObject.message}");
          if (modelObject?.message==null || modelObject?.message=="")
          {
            CJSnackBar(context, "server  error!");
          }else
          {
            CJSnackBar(context, modelObject!.message!);
          }

        }));
  }


  getServiceRequest_AreaOfWork()
  {
    print("show 1the request2");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().getDataServiceRequest(JG_ApiMethod_EmployerAreaOfWork,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();


          Employer_AreaOfWorkModelClass employer_areaOfWorkModelClass=modelResponse as Employer_AreaOfWorkModelClass;
          print("show the data obj ${employer_areaOfWorkModelClass.commonDataEmp}");

            if(employer_areaOfWorkModelClass.commonDataEmp!.length>0)
            {
              print("show the data obj ${employer_areaOfWorkModelClass.commonDataEmp}");

              setState(() {
                areaOfWorkList=employer_areaOfWorkModelClass.commonDataEmp!;
              });
            }
            else
              {

              }
        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass modelObject=commonResponse as CJTalentCommonModelClass;
          print("show the verify message ${modelObject.message}");
          if (modelObject?.message==null || modelObject?.message=="")
          {
            CJSnackBar(context, "server  error!");
          }else
          {
            CJSnackBar(context, modelObject!.message!);
          }

        }));
  }
}

