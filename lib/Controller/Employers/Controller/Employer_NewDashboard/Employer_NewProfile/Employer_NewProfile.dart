

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Controller/Talents/ModelClasses/CJTalentCommonModelClass.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/CJSnackBar/CJSnackBar.dart';
import 'package:contractjobs/Services/CJEmployerService/CJEmployerServiceBody.dart';
import 'package:contractjobs/Services/CJEmployerService/CJEmployerServiceRequest.dart';
import 'package:contractjobs/Services/CJEmployerService/CJEmployerServiceURL.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as Path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CircleAvatar/CircleAvatar.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../../TankhaPayModule/Controller/TankhaPayDrawer/TankhaPayDrawer.dart';
import '../../../../TankhaPayModule/Controller/ThankhaPayLeftSlider/ThankhaPayProfile/TankhaPayProfileChild.dart';
import '../../EmployerDashboard/Employer_LeftDrawer/Employer_LeftDrawer.dart';
import '../../EmployerModelClasses/EmployerProfileModelClasses/EmployerProfileModelClass.dart';
import '../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'Employer_NewProfileChild.dart';
import 'Employer_NewProfileEditBilling.dart';
import 'Employer_NewProfileModel.dart';

class Employer_NewProfile extends StatefulWidget {
  const Employer_NewProfile({super.key, this.liveModelObj/*, this.employerProfileVisibility*/});

  final Employer_VerifyMobileNoModelClass? liveModelObj;
 // final bool? employerProfileVisibility;


  @override
  State<Employer_NewProfile> createState() => _Employer_NewProfile();
}

class _Employer_NewProfile extends State<Employer_NewProfile> {


  List<PlatformFile>? _paths;
  final _picker = ImagePicker();
  File? _pickedImage;
  Uint8List? webImage;
  String? imageURL = "";
  String employeeName = "", selectedPictureName = "";
  int frequencyDate = 0;

  String state = "";
  String city = "";

  var profile_data = getEmployerProfileList;
  //var profile_data = [];

  var profile_data_2 = getEmployerProfileEditList;

  EmployerProfileModelClass? employerProfileModelClass;
  String billingAddress = "", pinCode = "";

  String payoutDate="";

  @override
  void initState() {
    super.initState();

    createBodyWebApi_GETEmployerProfile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: EmployerNavigation_Drawer(liveModelObj: widget.liveModelObj,),
          appBar: /*widget.employerProfileVisibility! ? */CJAppBarBgBlue("", appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show 1the action 1type");
            Navigator.pop(context);
          }))/*: null*/,
      backgroundColor: whiteColor,
      body: MainfunctionUi(),
    ));
  }

  Column MainfunctionUi()
  {
    return Column(
      children: [

        CirclesBackground(
          circles: getCircleInfoForHome,
          child: ListTile(
            title: Text(
              "Profile",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: largeExcel_FontSize,fontFamily: robotoFontFamily,fontWeight: bold_FontWeight,color: whiteColor),
            ),
          ),
        ),


        SizedBox(
            height: kIsWeb
                ? MediaQuery.of(context).size.height * 0.7
                : MediaQuery.of(context).size.height * 0.78,
            child: getTheCustomColumn())

        //getTheCustomColumn()
      ],
    );
//
  }

  ListView getTheCustomColumn()
  {
    return ListView(
      children: [
        SizedBox(
          height: 22,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                    child: kIsWeb
                        ? webImage == null
                            ? imageURL == "" || imageURL == null
                                ? getProfileName(employeeName)
                                : ClipRRect(
                                    child: Image.network(
                                      imageURL!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                            : ClipRRect(
                                child: Image.memory(
                                  webImage!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              )

//--------------------------------for mobile--------------------------------------------------------//
                        : _pickedImage == null
                            ? getProfileName(employeeName)
                            : imageURL == "" || imageURL == null
                                ? SizedBox()
                                : ClipOval(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(350),
                                      child: Image.file(
                                        _pickedImage!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                  ),
                ),
                Positioned(
                  right: 2.0,
                  bottom: 0.0,
                  child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => openBottomSheet()),
                          );
                        },
                        child: ImageIcon(
                          AssetImage(Talent_Icon_cameraDrawer),
                          size: 15,
                          color: Colors.grey,
                        ),
                      )),
                ),
              ]),
              /*ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: ()
                  {


                  },
                  child: Row(
                    children: [
                      Text(
                        'Edit',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: large_FontSize,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.black,
                      ),
                    ],
                  ))*/
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: profile_data.length,
          itemBuilder: (context, index) {
            profile_data_model obj = profile_data[index];
            print("show the profile_data_model $obj");
            print("show the value ${obj.value}");

            return ListTile1(obj.title!, obj.value!);
          },
        ),
        divider(),
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile2(profile_data_2[0].title!,
                  profile_data_2[0].value!, "BillingAddress");
            },
            separatorBuilder: (context, index) {
              return divider();
            },
            itemCount: 1),
        divider(),
        EditableDateRow(
          DateValue: frequencyDate==0 ? "Set Payout Date":"$frequencyDate${getDayNumberSuffix(frequencyDate)} of every month",
          title: "Payout Date",
          selectedDate: frequencyDate,liveModelObj: widget.liveModelObj,
        ),
        divider(),
        /*ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile2(
                  profile_data_2[1].title!, profile_data_2[1].value!, "SetPin");
            },
            separatorBuilder: (context, index) {
              return divider();
            },
            itemCount: 1),
        divider(),*/
      ],
    );
  }


  Padding divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      child: Divider(
        thickness: 1,
        height: 1,
      ),
    );
  }

  ListTile ListTile2(String title, String subTitle, String actionType) {
    return ListTile(
      title: getTitleText(title),
      subtitle: getSubTitleText(subTitle),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: (() {
          if (actionType == "BillingAddress") {
            pushTo(
                context,
                Employer_NewProfileEditBilling(
                  billingAddress: billingAddress,
                  pincode: pinCode,
                  state: state,
                  city: city.toString(),liveModelObj: widget.liveModelObj,
                ));
          } else {
            //use for the set pin
            CJSnackBar(context, "comming soon...");
          }
        }),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "Edit",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: large_FontSize,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.edit,
              size: 20,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  pushTo<T>(BuildContext context, navigateView) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => Responsive(
                mobile: navigateView,
                tablet: Center(
                  child: Container(
                    width: webResponsive_TD_Width,
                    child: navigateView,
                  ),
                ),
                desktop: Center(
                  child: Container(
                    width: webResponsive_TD_Width,
                    child: navigateView,
                  ),
                )))).then((value) {
      createBodyWebApi_GETEmployerProfile();
    });
  }

  ListTile ListTile1(String title, String subTitle) {
    return ListTile(
      dense: true,
      title: getTitleText(title),
      subtitle: getSubTitleText(subTitle),
    );
  }

  Text getTitleText(String text) {
    return Text(
      text,
      style: TextStyle(fontFamily: robotoFontFamily,
          color: lightBlueColor,
          fontWeight: FontWeight.bold,
          fontSize: large_FontSize),
    );
  }

  Text getSubTitleText(String text2) {
    return Text(
      text2,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: small_FontSize,fontFamily: robotoFontFamily),
    );
  }

  Widget openBottomSheet() {
    if (kIsWeb) {
      return Container(
        height: 90.0,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: <Widget>[
            const Text(
              "Choose Profile photo",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(children: <Widget>[
              InkWell(
                onTap: (() {
                  kIsWeb ? useForWeb() : useForMobile(ImageSource.gallery);
                }),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Select Picture From Gallery"),
                    ],
                  ),
                ),
              ),
            ])
          ],
        ),
      );
    } else {
      return Container(
        height: 150.0,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: <Widget>[
            const Text(
              "Choose Profile photo",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(children: <Widget>[
              InkWell(
                onTap: (() {
                  kIsWeb ? useForWeb() : useForMobile(ImageSource.camera);
                }),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Take Picture From Camera"),
                    ],
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: (() {
                  kIsWeb ? useForWeb() : useForMobile(ImageSource.gallery);
                }),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Select Picture From Gallery"),
                    ],
                  ),
                ),
              ),
            ])
          ],
        ),
      );
    }
  }

  Future<File?> _fileFromImageUrl() async {
    if (imageURL != "" && imageURL != null) {
      final response = await http.get(Uri.parse(imageURL!));

      if (kIsWeb) {
        final urlimageweb = imageURL;
        setState(() {
          _pickedImage = File(urlimageweb!);
        });
      } else {
        print(response.statusCode);
        final documentDirectory = await getApplicationDocumentsDirectory();

        final androidfile =
            File(Path.join(documentDirectory.path, 'imagetest.png'));

        androidfile.writeAsBytesSync(response.bodyBytes);
        setState(() {
          _pickedImage = androidfile;
        });

        print(_pickedImage.toString());
        return androidfile;
      }
    }
  }

  /*----------------------start web image pick -------------------------------------------------------------------*/
  Future useForWeb() async {
    final path = await webPickedImage();
    selectedPictureName = path!.first.name;
    print("show the selectedPictureName $selectedPictureName");

    setState(() {
      _pickedImage = File(path!.first.name);
      webImage = path!.first.bytes!;
    });
    Navigator.of(context).pop();
    String base64Image = base64Encode(path.first.bytes!);

    createBodyWebApi_updateProfilePicture(base64Image);
  }

  Future webPickedImage() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: [
          'png',
          'jpg',
          'jpeg',
        ],
      ))
          ?.files;

      return _paths;
    } on PlatformException catch (e) {
      log('Unsupported operation' + e.toString());
    } catch (e) {
      log(e.toString());
    }
  }

/*----------------------end web image pick -------------------------------------------------------------------*/

/*----------------------start mobile image pick -------------------------------------------------------------------*/
  Future useForMobile(source) async {
    final path = await mobilePickedImage(source);

    setState(() {
      _pickedImage = path;
    });
    final bytes = File(_pickedImage!.path).readAsBytesSync();
    Navigator.of(context).pop();
    String base64Image = base64Encode(bytes);

    createBodyWebApi_updateProfilePicture(base64Image);
  }

  Future mobilePickedImage(source) async {
    XFile? image = await _picker.pickImage(source: source, imageQuality: 40);
    if (image == null) return;

    final permanentImage = await SavePermanently(image.path);
    return permanentImage;
  }

  Future<File> SavePermanently(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = Path.basename(path);
    selectedPictureName = name;

    final image = File('${directory.path}/$name');
    return File(path).copy(image.path);
  }

  /*---------------camera and gallery functionality end-------------*/

/*----------------------end mobile image pick -------------------------------------------------------------------*/

/*-----------------------profile image api call--------------Start---------------------------------------------*/
  createBodyWebApi_updateProfilePicture(String base64Image) async {
    var mapObject = getEmployer_EmployerUpdateProfilePhoto_RequestBody(
        widget.liveModelObj?.tpAccountId, selectedPictureName, base64Image);
    serviceRequestForUpdateProfile(mapObject);
  }

  serviceRequestForUpdateProfile(Map mapObj) {
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(
        mapObj, JG_ApiMethod_EmployerUpdateProfile,
        cjEmployerResponseBlock: CJEmployerResponseBlock(
            employerSuccessBlock: <T>(commonResponse, modelResponse) {
          CJTalentCommonModelClass commonModelClass =
              commonResponse as CJTalentCommonModelClass;

          if (commonModelClass.statusCode == true) {

            print("success");
            CJSnackBar(context, commonModelClass.message!);
            EasyLoading.dismiss();

            createBodyWebApi_GETEmployerProfile();
          }
        }, employerFailureBlock: <T>(commonResponse, modelResponse) {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonModelClass =
              commonResponse as CJTalentCommonModelClass;

          if (commonModelClass.statusCode == true) {
            print("success");
            CJSnackBar(context, commonModelClass.message!);
          }
        }));
  }

/*-----------------------profile image api call-----------END------------------------------------------------*/

  createBodyWebApi_GETEmployerProfile()
   {
    var mapObject =
        getEmployer_GETEmployerProfile_RequestBody(widget.liveModelObj?.tpAccountId);

    print("show the account id ${widget.liveModelObj?.tpAccountId}");
    serviceRequestForGETProfile(mapObject);
  }

  serviceRequestForGETProfile(Map mapObj) {
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(
        mapObj, JG_ApiMethod_GETEmployerProfile,
        cjEmployerResponseBlock: CJEmployerResponseBlock(
            employerSuccessBlock: <T>(commonResponse, modelResponse) {
          EasyLoading.dismiss();

          employerProfileModelClass = modelResponse as EmployerProfileModelClass;


            setState(() {

              employerProfileModelClass = employerProfileModelClass;
              imageURL = employerProfileModelClass!.profilePhotoPath;

              print("show the profile imageURL $imageURL");

              /*-----------3-3-2023 start------------*/

              if(imageURL==null || imageURL=="")
                {
                  widget.liveModelObj?.profilePhotoPath="";
                }
              else
                {
                  widget.liveModelObj?.profilePhotoPath=imageURL;
                }
              /*-----------3-3-2023 end------------*/


              state = employerProfileModelClass!.stateId.toString();
              city = employerProfileModelClass!.cityId.toString();

              print("show the state name $state");
              employeeName = getProfileEmpName(employerProfileModelClass!.employerName);

              profile_data[0].value = employerProfileModelClass!.employerName;
              profile_data[1].value = employerProfileModelClass!.userType;
              profile_data[2].value = employerProfileModelClass!.employerMobile;
              profile_data[3].value = employerProfileModelClass!.employerEmail;
              profile_data[4].value = employerProfileModelClass!.companyAddress;

              billingAddress = employerProfileModelClass!.billAddress;

              /*----------3-3-3023 start-----------*/
             // pinCode = employerProfileModelClass!.companyPincode;
              pinCode = employerProfileModelClass!.billPincode; //discuss by chandra mohan
              /*----------3-3-3023 end-----------*/

              profile_data_2[0].value = employerProfileModelClass!.billAddress;


              frequencyDate = employerProfileModelClass!.payoutFrequencyDt;

              //Set Payout Date

              print("show the photopath $imageURL");
              print("show the city ${city}");

              if (imageURL == "" || imageURL == null) {
              } else {
                _fileFromImageUrl();
              }

              employerProfileModelClass = employerProfileModelClass;

            });


        }, employerFailureBlock: <T>(commonResponse, modelResponse) {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonModelClass =
              commonResponse as CJTalentCommonModelClass;

          if (commonModelClass.statusCode == true) {
            print("success");
            CJSnackBar(context, commonModelClass.message!);
          }
        }));
  }
}
String getDayNumberSuffix(int day) {
  if (day >= 11 && day <= 13) {
    return "th";
  }
  switch (day % 10) {
    case 1:
      return "st";
    case 2:
      return "nd";
    case 3:
      return "rd";
    default:
      return "th";
  }
}