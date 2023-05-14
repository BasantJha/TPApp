

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/Services/AESAlgo/EncryptedMapBody.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../Constant/ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../CustomView/CircleAvatar/CircleAvatar.dart';
import '../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../JoiningProfile/JoiningProfileModelClass/EmployeeKYCStatusModelClass.dart';
import '../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../TankhaPayModelClasses/TankhaPayProfileModelClass/TankhaPayUpdateAddressModelClass.dart';
import 'TankhaPayProfileChild.dart';
import 'package:path/path.dart' as Path;
import 'package:http/http.dart' as http;

class TankhaPayProfile extends StatefulWidget
{
  const TankhaPayProfile({super.key, this.completedEmpCode, this.jsId});
  //const TankhaPayProfile({Key? key, this.completedEmpCode}) : super(key: key);

  final String? completedEmpCode;
  final String? jsId;

  @override
  State<TankhaPayProfile> createState() => _TankhaPayProfile();
}

class _TankhaPayProfile extends State<TankhaPayProfile>
{

  EmployeeKYCStatusModelClass? profileData=EmployeeKYCStatusModelClass(statusCode:true, message:"",
      data:Data(empName: "",postOffered: "",email: "",jsId: 0,empDob: "",gender: "",mobile: "",
      residentialAddress: "",permanentAddress: "",accountContactName: ""));

 //
  List<PlatformFile>? _paths;

  final _picker = ImagePicker();
  File? _pickedImage;
  Uint8List? webImage;
  String? imageURL = "https://th.bing.com/th/id/OIP.0l7k5zqRUVQ5Yq9eTpW2LgHaLJ?pid=ImgDet&rs=1";
  String employeeName="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    createBodyWebApi_VerifyKYCStatusForEmployee();
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(backgroundColor: whiteColor,
        appBar:CJAppBarBgBlue("", appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action type");
          Navigator.pop(context);
        })),
      body: getResponsiveUI(context),
      //bottomNavigationBar: elevatedButtonBottomBar()
    );
    context=context;
  }
  Responsive getResponsiveUI(BuildContext context)
  {
    return Responsive(
      mobile: MainfunctionUi(context),
      tablet: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUi(context),
        ),
      ),
      desktop: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUi(context),
        ),
      ),
    );
  }
  CirclesBackground  MainfunctionUi(BuildContext context)
  {
    return CirclesBackground(
      circles:getCircleInfoForHome,
      child: getTheProfileData(context),);
  }


  Column getTheProfileData(BuildContext context)
  {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Text(getTalent_TabProfileTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: whiteColor,
                fontFamily: robotoFontFamily,
                fontSize: 20.0),
          ),


        ),
        SizedBox(height: 35,),

        Expanded(flex: 1,child: SingleChildScrollView(child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 /* CircleAvatar(
                    radius: 35,
                    backgroundImage:
                    AssetImage(Talent_Icon_profileDrawer),
                    child: InkWell(onTap: ()
                      {

                      },),
                  ),*/
                  Stack(children: <Widget>[
                    CircleAvatar(
                      radius: 50,
                      child: _pickedImage == null
                          ? getProfileName(employeeName)
                          : imageURL == null
                          ? SizedBox()
                          : ClipOval(
                        child: kIsWeb
                            ? webImage == null
                            ? Image.network(
                          imageURL!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                            : ClipRRect(
                          child: Image.memory(
                            webImage!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                            : ClipRRect(
                          borderRadius:
                          BorderRadius.circular(350),
                          child: Image.file(
                            _pickedImage!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                   /* Positioned(
                      right: 2.0,
                      bottom: 0.0,
                      child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: InkWell(
                            onTap: ()
                            {
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
                    ),*/
                  ]),

                ],
              ),
              profileListTile("Employee Name", profileData!.data!.empName),
              profileListTile("Designation", profileData!.data!.postOffered),
              profileListTile("Email Id", profileData!.data!.email),
              profileListTile(getTPCode, profileData!.data!.tpcode.toString()),
              profileListTile("Date of Birth", profileData!.data!.empDob),
              profileListTile("Gender", profileData!.data!.gender),
              profileListTile("Mobile No.", profileData!.data!.mobile),
              //profileListTile("Current Address", profileData!.data!.residentialAddress),

              EditableTextRowForProfile(
                  title: "Current Address",
                  CurrentAddressValue:
                  profileData!.data!.residentialAddress,jsId: widget.jsId!,),
              profileListTile(
                  "Permanent Address", profileData!.data!.permanentAddress),
              profileListTile("Client Name", profileData!.data!.accountContactName)
            ],
          ),
        ),))


      ],
    );
  }
  ListTile profileListTile(String title, String value) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: darkBlueColor,
          fontSize: medium_FontSize,
          fontWeight: bold_FontWeight,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          fontSize: small_FontSize,
          color: blackColor,
        ),
      ),
      dense: true,
    );
  }
  /*---------------camera and gallery functionality start-------------*/

  Widget openBottomSheet()
  {
    if(kIsWeb)
      {
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
                  onTap: (()
                  {
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
    else
      {
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
                  onTap: (()
                  {
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
                  onTap: (()
                  {
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

  Future<File?> _fileFromImageUrl() async
  {
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
  Future useForWeb() async
  {
    final path = await webPickedImage();
    setState(()
    {
      _pickedImage = File(path!.first.name);
      webImage = path!.first.bytes!;
    });
    Navigator.of(context).pop();
   String base64Image = base64Encode(path.first.bytes!);

    createBodyWebApi_updateProfilePicture(base64Image);
  }
  Future webPickedImage() async
  {

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
    } on PlatformException catch (e)
    {
      log('Unsupported operation' + e.toString());
    } catch (e) {
      log(e.toString());
    }
  }
/*----------------------end web image pick -------------------------------------------------------------------*/

/*----------------------start mobile image pick -------------------------------------------------------------------*/
  Future useForMobile(source) async
  {
    final path = await mobilePickedImage(source);

    setState(() {
      _pickedImage = path;
    });
    final bytes = File(_pickedImage!.path).readAsBytesSync();
    Navigator.of(context).pop();
    String base64Image = base64Encode(bytes);

    createBodyWebApi_updateProfilePicture(base64Image);
  }
  Future mobilePickedImage(source) async
  {
    XFile? image = await _picker.pickImage(source: source);
    if (image == null) return;

    final permanentImage = await SavePermanently(image.path);
    return permanentImage;
  }

  Future<File> SavePermanently(String path) async
  {
    final directory = await getApplicationDocumentsDirectory();
    final name = Path.basename(path);
    final image = File('${directory.path}/$name');
    return File(path).copy(image.path);
  }
  /*---------------camera and gallery functionality end-------------*/




  /*-------------GET BENEFIT DATA START-----------------*/

  createBodyWebApi_VerifyKYCStatusForEmployee()
  {
    var mapObject=getCJHub_EmployeeKYCStatus_RequestBody(widget.jsId!);
    serviceRequestForEmployee(mapObject);
  }
  serviceRequestForEmployee(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.get_EmployeeKYC_Status,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();

          EmployeeKYCStatusModelClass profileObj=success as EmployeeKYCStatusModelClass;
          if(profileObj.statusCode==true)
          {

             setState(() {
               profileData=profileObj;
               imageURL=profileData!.data!.photopath;
               employeeName=getProfileEmpName(profileData!.data!.empName);

               print("show the photopath $imageURL");
               _fileFromImageUrl();

            });
          }

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();

          EmployeeKYCStatusModelClass profileData=failure as EmployeeKYCStatusModelClass;
          if (profileData.message==null || profileData.message=="")
          {
            CJSnackBar(context!, "server 1 error!");
          }else {
            CJSnackBar(context!, profileData.message!);
          }
        }, talentHandleExceptionBlock: <T>(handleException)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonObject= handleException as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }

        }));
  }


/*-------------GET BENEFIT DATA END-----------------*/

/*------------update profile address---------------*/

  createBodyWebApi_updateProfilePicture(String profilePictureObj)
  {
    var getEncryptedEmpCode=getEncrypted_EmpCode(widget.completedEmpCode!);
    var mapObject=getCJHub_UpdateProfilePhoto_RequestBody(getEncryptedEmpCode,profilePictureObj,"ip",widget.jsId);
    serviceRequestForEmployeeProfileUpdatePicture(mapObject);
  }
  serviceRequestForEmployeeProfileUpdatePicture(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.tankhaPayUpdateProfilePicture_api,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();

          TankhaPayUpdateAddressModelClass profileObj=success as TankhaPayUpdateAddressModelClass;
          if(profileObj.statusCode==true)
          {

            CJSnackBar(context!, profileObj.message!);
          }

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();

          TankhaPayUpdateAddressModelClass modelObject=failure as TankhaPayUpdateAddressModelClass;
          if (modelObject.message==null || modelObject.message=="")
          {
            CJSnackBar(context!, "server 1 error!");
          }else {
            CJSnackBar(context!, modelObject.message!);
          }
        }, talentHandleExceptionBlock: <T>(handleException)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonObject= handleException as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }

        }));
  }

}