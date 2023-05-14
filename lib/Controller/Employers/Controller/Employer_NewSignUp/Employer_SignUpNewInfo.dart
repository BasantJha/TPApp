import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CustomRow/AstricRow.dart';
import 'package:contractjobs/Services/CJEmployerService/CJEmployerServiceKey.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../Constant/CJAppFlowConstants.dart';
import '../../../../Constant/ValidationClass.dart';
import '../../../../CustomView/AlertView/Alert.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../CustomView/ContainerView/CustomContainer.dart';
import '../../../../CustomView/Messages/Validation_Messages.dart';
import '../../../../CustomView/TextField/TextFieldDecoration.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../Services/Messages/Message.dart';
import '../../../LoginView/Controller/LoginViewController.dart';
import '../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../EmployerModelClasses/EmployerSignUpModelClasses/EmployerSignUpModelClass.dart';
import '../Employer_KYC/Employer_JoinerHome.dart';
import '../Employer_TabBarController/Employer_TabBarController.dart';
import 'Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'Employer_SignUpNewBusiness.dart';
import 'Employer_SignUpNewInfoChild.dart';
import 'Employer_VerifyMobileNo.dart';

class Employer_SignUpNewInfo extends StatefulWidget
{
  const Employer_SignUpNewInfo({Key? key}) : super(key: key);


  @override
  State<Employer_SignUpNewInfo> createState() => _Employer_SignUpNewInfo();
}

class _Employer_SignUpNewInfo extends State<Employer_SignUpNewInfo>
{

  static const mediumDarkGreyColor = Color(0xff636363);

   String name="";
   String mobileNo="";
   String pinCode="";
   String emailId = "";

  final signUpInfoFormKey = GlobalKey<FormState>();

  double topSpaceHeight=15;
  double spaceBetweenTitleandTextField=5;

  String deviceId="",IPAddress="",otp="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBasicInfo();
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
      bottomNavigationBar:Padding(padding: EdgeInsets.only(left: 0,right:0 ,top: 5),
        child: elevatedButtonBottomBar(),) ,
    ),);
  }
  dismissTheFirstResponder()
  {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
  Container elevatedButtonBottomBar()
  {
    /*return CJElevatedBlueButton("Continue", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action");

      validateToTheFields();
     // TalentNavigation().pushTo(context, Employer_SignUpNewBusiness());
       //TalentAnimationNavigation().pushBottomToTop(context, Employer_VerifyMobileNo());
    }
    )) ;*/

    return Container(child: ListTile(
      title: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: lightBlueColor,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            minimumSize: const Size(200, 65)),
        child: Text(
          'Continue',
          style: TextStyle(fontSize: 20),
        ),
        onPressed: ()
        {
          validateToTheFields();
          // TalentNavigation().pushTo(context, Employer_SignUpNewBusiness());
          //TalentAnimationNavigation().pushBottomToTop(context, Employer_VerifyMobileNo());

        },
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: employerSignUpInfoBottomBar(context),
      ),
    ),);
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
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child:Form(
          key: signUpInfoFormKey,
          // autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [


              getTheTankhaPayGrayLogoContainer,

              SizedBox(height: topSpaceHeight),
              getAstricRow("Employer Name"),
              SizedBox(height: spaceBetweenTitleandTextField),
              Container(
                  child: TextFormField(
                    //maxLength: 10,
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp(r'[a-zA-Z\s]*'), allow: true)
                    ],
                    validator: validateToName,
                    onChanged: ( val) {
                      setState(() {
                        name = val;
                      });
                    },
                    keyboardType: TextInputType.text,
                    cursorColor: mediumDarkGreyColor,
                    style: TextStyle(),
                    decoration: getTextFieldDecoration("Enter Employer Name"),

                  )),
              SizedBox(height: topSpaceHeight),
              getAstricRow("Mobile Number"),
              SizedBox(height: spaceBetweenTitleandTextField),
              Container(
                child: TextFormField(
                  maxLength: 10,
                  validator: validateToMobileNo,
                  onChanged: ( val) {
                    setState(() {
                      mobileNo = val!;

                      if(mobileNo.length==10)
                        {
                          dismissTheFirstResponder();
                        }
                    });
                  },
                  // initialValue: " ",
                  style: TextStyle(fontSize: medium_FontSize,color: blackColor),
                  // controller: new TextEditingController(text: "+91"),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  decoration: getMobileTextFieldDecoration('Enter Mobile Number'),
                  // onChanged: (value)
                  // {
                  //   int count=value.length;
                  //   print("show the input data $count");
                  // },
                ),
              ),
              SizedBox(height:topSpaceHeight),
              getAstricRow("Email Address"),
              SizedBox(height: spaceBetweenTitleandTextField),
              Container(
                  child: TextFormField(validator: validateEmailId,
                    inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9@a-zA-Z-a-z._~!%^&*_=+}{'?-]")),
                  ],
                    onChanged: (value)
                    {
                      emailId = value;
                      },

                    cursorColor: mediumDarkGreyColor,
                    style: TextStyle(),
                    decoration: getTextFieldDecoration("Enter Email Address"),

                  )),
              SizedBox(height: topSpaceHeight),

              getAstricRow("Pincode"),
              SizedBox(height: spaceBetweenTitleandTextField),
              Container(
                  child: TextFormField(
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: validateToPincode,
                    onChanged: ( val) {
                      setState(() {
                        pinCode = val;
                        if(pinCode.length==6)
                        {
                          dismissTheFirstResponder();
                        }
                      });
                    },
                    cursorColor: mediumDarkGreyColor,
                    style: TextStyle(),
                    decoration: getTextFieldDecoration("Enter Pincode"),
                  )),
              SizedBox(height: topSpaceHeight),
            ],
          ),
        ),

      ),
    );
  }

  InputDecoration getMobileTextFieldDecoration(String hintText)
  {
    return InputDecoration(
      labelStyle: TextStyle(fontSize: large_FontSize, fontWeight: bold_FontWeight, color: Colors.grey),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: textFieldBorderColor,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      hintText: hintText,
      prefixIcon: Container(/*color: Colors.red,*/padding: EdgeInsets.only(left: 5),width: 60,child: Row(children:
      [
        Container(width: 20,child: Image(image: AssetImage("ind.png"),),),
        Container(/*color: Colors.red,*/width: 25,child: Text("+91",textAlign: TextAlign.right,style: TextStyle(fontWeight: bold_FontWeight,fontSize: 12),),),
/*
        Container(*/
/*color: Colors.blue,*//*
width: 25,child: Icon(Icons.arrow_drop_down_sharp,color: Colors.black)),
*/
      ],

      ),

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

  validateToTheFields()
  {
    if (signUpInfoFormKey.currentState!.validate())
    {
      // TalentAnimationNavigation().pushBottomToTop(context, Employer_SignUpNewBusiness());
      //TalentNavigation().pushTo(context, Employer_SignUpNewBusiness());
      createBodyWebApi_Signup();
    }
  }

  /*--------------hit the login service request start---------------*/
  createBodyWebApi_Signup()
  {

    name=name.trim();
    var mapObject=getEmployer_SignUpInfo_RequestBody(name,mobileNo,emailId,pinCode,deviceId,IPAddress);
    serviceRequest_SignUp(mapObject);
  }

  serviceRequest_SignUp(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequestFor_EmployerSignUp(mapObj,JG_ApiMethod_EmployerCommonRegistration,kEmployer_FLAG_SU,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();


          CJTalentCommonModelClass commonObject=commonResponse as CJTalentCommonModelClass;
          Employer_VerifyMobileNoModelClass modelObject=modelResponse as Employer_VerifyMobileNoModelClass;
          checkTheEmployerStatus(commonObject,modelObject);

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
//
  /*-----------14-12-2022 start--------------*/
  checkTheEmployerStatus(CJTalentCommonModelClass commonModelClass,Employer_VerifyMobileNoModelClass modelObject)
  {
    print("show the request type");
    //var checkMessage=message.toLowerCase().contains("exists");

    var registrationStatus=modelObject.employerStatus!;
    var registrationType=modelObject.signupFlag!;
    //var userType=modelObject.userType!;
    var mobileNo=modelObject.employerMobile!;
    var message=commonModelClass.message!;
    var isMobileOtpVerify=modelObject.isMobileOtpVerify;

    if(registrationType==kEmployer_FLAG_SU && isMobileOtpVerify=="N")
    {
      TalentAnimationNavigation().pushBottomToTop(context, Employer_VerifyMobileNo(mobileNo: mobileNo,userArriveFrom: CJEMPLOYER_ArriveFROM_SIGNUP,));
    }
    else if(registrationType==kEmployer_FLAG_SU && isMobileOtpVerify=="Y")
    {
      print("show the signup");
      TalentNavigation().pushTo(context, Employer_SignUpNewBusiness(mobileNo: mobileNo));
    }
    else
    {

      print("show the registration type $registrationStatus");

      if (registrationStatus == kEmployer_STATUS_SIGNUP &&
          registrationType == kEmployer_FLAG_SU) {

        TalentNavigation().pushTo(
            context, Employer_SignUpNewBusiness(mobileNo: mobileNo));
      }
      else if (registrationStatus == kEmployer_STATUS_SIGNUP &&
          registrationType == kEmployer_FLAG_BI) {
        /*--show the pending status(show the alert message and text type BLUE color)----*/
        Navigator.pop(context,[LoginViewController(employeeRoleType: "", navigationTitle: "", title: "", subTitle: "")]);
        showDialog(context: context, builder: (_)=>failedDialogMethod(context,message,blackColor));

      }
      else if (registrationStatus == kEmployer_STATUS_AV) {
        /*--manage the account verify  status(user fill the KYC)----*/

     /*   TalentNavigation().pushTo(
            context, Employer_JoinerHome(
          mobileNo: mobileNo,
          ));
*/
        showDialog(context: context, builder: (_)=>successDialogMethod(context,message));

        print("show the step 4");
      }
      else if (registrationStatus == kEmployer_STATUS_KYC ||
          registrationStatus == kEmployer_STATUS_CD ||
          registrationStatus == kEmployer_STATUS_EA) {
        /* --USER REACH TO THE Employer joiner home manage the status(2,3,4)----*/

      /*  TalentNavigation().pushTo(
            context, Employer_JoinerHome(
          mobileNo: mobileNo,
         ));*/
        print("show the step 4");
      }
      else if (registrationStatus == kEmployer_STATUS_REJECT) {
        /* --when employer  account rejected then(show the alert message and text type red color)----*/
        Navigator.pop(context,[LoginViewController(employeeRoleType: "", navigationTitle: "", title: "", subTitle: "")]);
        showDialog(context: context, builder: (_)=>failedDialogMethod(context,message,redColor));

      }
      //SECURITY REASON(BECAUSE Information leak)
     /* else if (registrationStatus >= kEmployer_STATUS_SP) {
        *//* --employer login successfully then user reach to the main dashboard----*//*
        TalentNavigation().pushTo(
            context, Employer_TabBarController(selectedRegistrationType: 1,));
      }*/
      else {
        //      //TalentNavigation().pushTo(context, Employer_JoinerHome(message: "",mobileNo: "",registrationType: "",registrationStatus: 0,userType: kEmployer_USERTYPE_Business,))
        print("show the load data");
        alertViewWithoutAction(context, message, redColor);
      }
    }


  }
/*-----------14-12-2022 end--------------*/

}

