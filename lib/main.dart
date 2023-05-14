
import 'dart:async';
import 'package:contractjobs/Controller/LoginView/Controller/LoginOptionController.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/Services/AESAlgo/encrypt.dart';
import 'package:contractjobs/smsListener.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;
import 'Controller/Employers/Controller/EmployerModelClasses/EmployerAddEmployeeModelClass/LeaveTemplateModelClass.dart';
import 'Controller/Employers/Controller/Employer_KYC/EmployerGST_Verification.dart';
import 'Controller/Employers/Controller/Employer_KYC/Employer_JoinerCompanyDetails.dart';
import 'Controller/Employers/Controller/Employer_KYCModelClass/Employer_KYCStatusModelClass.dart';
import 'Controller/Employers/Controller/Employer_NewDashboard/Employer_NewWorkPlace/Employer_NewWorkPlaceEmployees/Employer_NewWorkPlaceEmployeeLinkSent/Employer_NewWorkPlaceAddDOJ.dart';
import 'Controller/Employers/Controller/Employer_NewSignUp/Employer_NewCongratulations.dart';
import 'Controller/Employers/Controller/Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'Controller/Employers/Controller/Employer_NewSignUp/Employer_SignUpNewInfo.dart';
import 'Controller/JoiningProfile/KYCModule/PAN_Verification.dart';
import 'Controller/JoiningProfile/KYCModule/UAN_Verification.dart';
import 'Controller/JoiningProfile/TEC_BankInfoVerify.dart';
import 'Controller/Talents/Controller/CJHubNotificationView/notificationServices/LocalNotificationService.dart';
import 'Controller/Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import 'Controller/TankhaPayModule/Controller/TankhPaySignUp/TankhaPayTermsandConditions.dart';
import 'Controller/TankhaPayPinNumber/TankhaPayVerify4DigitPin.dart';
import 'CustomUPI_Integration.dart';
import 'CustomView/CJHubCustomView/Method.dart';
import 'CustomView/CJHubCustomView/SharedPreference.dart';
import 'CustomView/ContainerView/CustomContainer.dart';
import 'New_setUpSalary_Page.dart';
import 'Services/AESAlgo/EncryptedMapBody.dart';
import 'Services/CJEmployerService/CJEmployerServiceURL.dart';
import 'Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import 'Telephony.dart';
import 'package:upgrader/upgrader.dart';

import 'TransactionUi.dart';
import 'UpiPage.dart';
import 'customUPIPage.dart';
import 'demoUPIPage.dart';


/*---------------push notification message start 28-11-2022----------------*/
Future<void> backroundHandler(RemoteMessage message) async {
  print(" This is message from background");
  print(message.notification!.title);
  print(message.notification!.body);
}
/*---------------push notification message end 28-11-2022----------------*/


void main() async {


  /*-----------------------network connection----------start 28-12-2022------*/

  /*WidgetsFlutterBinding.ensureInitialized();
  NetworkReachability connectionStatus = NetworkReachability.getInstance();
  connectionStatus.initialize();*/

  print("show the data type");
  /*-----------------------network connection----------end 28-12-2022------*/

  /*---------------initialize push notification  start 28-12-2022----------------*/

  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBu28QgI5yEpAaiyJHdWh81IkKLPBTfQKg",
            authDomain: "tankhapay.firebaseapp.com",
            projectId: "tankhapay",
            storageBucket: "tankhapay.appspot.com",
            messagingSenderId: "82665791823",
            appId: "1:82665791823:web:d13f983ae0d8d8022aa53a",
            measurementId: "G-GLHXM7PC6M")
    );
    FirebaseMessaging.onBackgroundMessage(backroundHandler);
  }
  else{
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(backroundHandler);
  }

  /*---------------initialize push notification  end 28-12-2022----------------*/

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff00BFFF)
  ));


  runApp(MyApp());

  configLoading();
}



/*---------loader code start---28-11-2021----------*/

void configLoading()
{

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.orange
    ..backgroundColor = Colors.grey[100]
    ..indicatorColor = Colors.orange
    ..textColor = Colors.grey
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

/*---------loader code end---28-11-2021----------*/

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: MyHomePage()
      ),

      /*---------loader code start---28-11-2022----------*/
      builder: EasyLoading.init(),
      /*---------loader code end---28-11-2022----------*/

    );
  }
}

class MyHomePage extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);

  //final String title;

  @override
  _MyStatelessWidget createState() => _MyStatelessWidget();

}


class _MyStatelessWidget extends State<MyHomePage> with TickerProviderStateMixin {

  Timer? _timer;
  bool? _visible = true;

  AnimationController? controller;
  Animation<double>? animation;

  String notificationMsg = "Waiting for notifications";

  String TankhaPayUserId = "", deviceId = "";
  String TankhaPayUserType = "", notificationToken = "";
  var isAuthenticated;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /*---------27-01-2023 start--------*/
    CallToTheNotificationApi();
    /*---------27-01-2023 end--------*/



      Timer(Duration(seconds: 5),
            () =>

            // TalentNavigation().pushTo(context, TankhaPayVerify4DigitPin())
            // TalentNavigation().pushTo(context, Employer_JoinerHome(liveModelObj:Employer_VerifyMobileNoModelClass(employerMobile: "9569734648") ,))
            // TalentNavigation().pushTo(context, TEC_JoiningProfileUpdate(liveModelObj:VerifyOTP_ModelResponse(statusCode: true,message: "",data:Data(jsId:"3695",empMobile: "9911473909",empName: "manishi",tpCode: "TP1074",empCode: "-9999"))))
            // TalentAnimationNavigation().pushBottomToTop(context, UAN_Verification(verifyOTP_ModelResponse: VerifyOTP_ModelResponse(data:Data(jsId:"3700",empMobile: "",empName: "",empCode: "-9999"),)))
            //TalentNavigation().pushTo(context, Employer_NewWorkPlaceAddDOJ(liveModelObj: Employer_VerifyMobileNoModelClass(),))
            //  TalentNavigation().pushTo(context, TEC_JoiningProfileDashboard(verifyOTP_ModelResponse: VerifyOTP_ModelResponse(statusCode: true,message: "",data:Data(jsId:"3708",empMobile: "9911473909",empName: "manishi",tpCode: "TP1074",empCode: "-9999"),)))
//
            SharedPreference.getTankhaPay_PinNumber().then((pinNumber) =>  {

              print("show the pinNumber $pinNumber"),
              if(pinNumber=="" || pinNumber==null)
                {
                  TalentNavigation().pushTo(context, LoginOptionController())
                }
              else
                {
                  TalentNavigation().pushTo(context, TankhaPayVerify4DigitPin())
                }


            })

    );

    /*---------loader code start---28-11-2021----------*/
    EasyLoading.addStatusCallback((status) {
      // //print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer!.cancel();
      }
    });
   /*---------loader code end---28-11-2021----------*/
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          getTheTankhaPayWhiteLogoContainer
        ],
      ),
    );
  }


  /*------------28-11-2022 start-----------*/

  CallToTheNotificationApi()
  {
    if(kIsWeb)
    {
    }
    else
    {
      showPushNotificationState();
    }
  }

  void showPushNotificationState()
  {

    LocalNotificationService.initilize();
    FirebaseMessaging.instance.getToken().then((token) {
      print("token: $token");
      notificationToken = token!;

      setPushNotificationToken(notificationToken);
      //getBasicInfo();
    });

    // Terminated State
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        setState(() {
          notificationMsg =
          "${event.notification!.title} ${event.notification!
              .body} I am coming from terminated state";
        });
        // //print("This message from terminated state");
      }
    });

    // Foregrand State
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      setState(()
      {
        notificationMsg =
        "${event.notification!.title} ${event.notification!
            .body} I am coming from foreground";
      });
      // //print("This message from foreground");
    });

    // background State
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(()
      {
        notificationMsg =
        "${event.notification!.title} ${event.notification!
            .body} I am coming from background";
      });
      // //print("This message from background");
    });
  }

  setPushNotificationToken(String notificationToken)
  {
    SharedPreference.setTankhaPay_NotificationToken(notificationToken);
  }

  getBasicInfo()
  {

     SharedPreference.getTankhaPay_UserId().then((value) =>  {
       TankhaPayUserId=value,
      print('TankhaPayUserId $value'),
    });

    SharedPreference.getTankhaPay_UserType().then((value) =>  {
      TankhaPayUserType=value,
      print('TankhaPayUserType $value'),
    });

     Method.getDeviceId().then((value) =>
     {
       deviceId = value,

       if(TankhaPayUserId != "" && TankhaPayUserType!="")
         {
           saveNotificationToken()
         }
     });
  }

  saveNotificationToken() async
  {
    var mapObj=Map();
    mapObj["user_id"]=TankhaPayUserId;
    mapObj["user_type"]=TankhaPayUserType;
    mapObj["device_id"]=deviceId;
    mapObj["token"]=notificationToken;

    try {
      final response = await http.post(
        Uri.parse(TankhaPay_SavePushNotificationTokenApi),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },

        body: getEncrypted_MapBody(mapObj),
      );

      print(response.statusCode);
      // //print('response.statusCode');

      if (response.statusCode == 200) {
        print(response.body);
        // //print("success");
      } else {

        print("failure");
        throw Exception('Failed to create get product.');
      }
    }
    catch (e) {
      // //print(e);
    }
  }
}

 