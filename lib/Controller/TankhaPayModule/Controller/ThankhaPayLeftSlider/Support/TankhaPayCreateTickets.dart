import 'dart:convert';

import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/Controller/Employers/Controller/Employer_KYC/Employer_JoinerAggrementChild.dart';
import 'package:contractjobs/Controller/TankhaPayModule/Controller/TankhaPayDrawer/TankhaPayDrawer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Constant/ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AlertView/Alert.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/ButtonDecoration/CustomButtonAction.dart';
import '../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../CustomView/CustomRow/AstricRow.dart';
import '../../../../../CustomView/TextField/TextFieldDecoration.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceKey.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../TankhaPayModelClasses/TankhaPaySupportModelClass/TankhaPaySupportCreateQueryModelClass.dart';
import '../../../TankhaPayModelClasses/TankhaPaySupportModelClass/TankhaPaySupportSubjectList.dart';
import 'TankhaPayHelpSupport.dart';

class TankhaPayCreateTickets extends StatefulWidget {
  const TankhaPayCreateTickets({Key? key, this.completedEmpCode}) : super(key: key);
  final String? completedEmpCode;

  @override
  State<TankhaPayCreateTickets> createState() => _TankhaPayCreateTickets();
}

class _TankhaPayCreateTickets extends State<TankhaPayCreateTickets> {
  PickedFile? imageFile;
  final ImagePicker picker = ImagePicker();

  static const mediumDarkGreyColor = Color(0xff636363);


  String? selectedItem;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;


  //TankhaPaySupportSubjectList? subjectList;
  List<Tickets>? subjectList=[Tickets(ticketId: "",ticketName: "")];
  String subjectId="",subjectDesc="",queryComment="";

  String selectedFileName = ' ';
  var selectedFileInBase64Encoded="";
  var selectedFileEXT="";

  String deviceId="",IPAddress="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    createBodyWebApi_SubjectTickets();
    getBasicInfo();
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

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CJAppBarBgBlue("", appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action 1type");
        Navigator.pop(context);
      })),
      body: getResponsiveUI(),
      bottomNavigationBar: Padding(padding: EdgeInsets.only(left: 80,right: 80),child: elevatedButtonBottomBar(),),
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

  CirclesBackground  MainfunctionUi()
  {
    return CirclesBackground(
      circles:getCircleInfoForHome,
      child: getTheCustomColumn(),);
  }

  Container getTheCustomColumn()
  {
    return Container(
        padding: EdgeInsets.only(left: 5, right: 5), child: Column(
        children: [

          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(getEmployee_HelpandSupportTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: whiteColor,
                  fontFamily: robotoFontFamily,
                  fontSize: 20.0),
            ),


          ),
          SizedBox(height: 20,),
          Expanded(flex: 1,child:  SingleChildScrollView(
            child: Form(
              key: _formKey,
              //autovalidateMode: AutovalidateMode.always,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Create Ticket",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: large_FontSize,
                            fontWeight: bold_FontWeight,
                            fontFamily: robotoFontFamily,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: getAstricRow('Type'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: dropdown("Select Type", "Please Select Type Of Issue"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: getAstricRow('Message'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            style: TextStyle(
                              color: textFieldHeadingColor,
                            ),
                            decoration: getTextFieldDecoration('Write Message'),
                            maxLines: 4,
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              FilteringTextInputFormatter(
                                  RegExp(r'[a-z A-Z0-9.\-/=,\;\s]*'),
                                  allow: true)
                            ],
                            validator: (value)
                            {
                              String pattern = r'(^[0-9,a-z A-Z.\-/=\;]*$)';
                              RegExp regExp = new RegExp(pattern);
                              if (value == null || value.trim().length == 0) {
                                return "Please Enter Message";
                              } else if ( 3 > value.length) {
                                return "Message should not be less than 3 character";
                              } else if (!regExp.hasMatch(value)) {
                                return "Message should be a-z and 0-9";
                              }
                              return null;
                            },
                            onChanged: (val)
                            {
                              queryComment = val!;
                              print("show the subject description $queryComment");
                            },
                          )),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: getWithoutAstricRow('Attach Image(Optional)'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 60,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  '$selectedFileName',
                                  style: TextStyle(color: darkGreyColor),
                                )),
                            SizedBox(
                              width: 2,
                            ),
                            IconButton(
                              icon: Image.asset(
                                TankhaPay_Attachment_Icon,
                                width: 25,
                                height: 25,
                              ),
                              onPressed: ()
                              {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) =>  bottomSheet()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                     /* Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          selectedFileName == ' ' ? "Please Attach File" : "Success",
                          style: TextStyle(
                              color:
                              selectedFileName == ' ' ? Colors.red : Colors.white
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
              ),
            ),
          ))

        ]));
  }



  dropdown(hinttext, message)
  {
    return DropdownButtonFormField2(
      isExpanded: true,
      dropdownWidth: kIsWeb==true?webResponsive_TD_Width-40:MediaQuery.of(context).size.width-50,
      dropdownMaxHeight: 200,
      scrollbarRadius: const Radius.circular(40),
      scrollbarThickness: 6,
      scrollbarAlwaysShow: true,
      offset: Offset(-15, -16),
      icon: Image.asset(TankhaPay_DropdownArrow_Icon),
      decoration: getTextFieldDecoration(hinttext),
      items: subjectList!.map((obj) => DropdownMenuItem(
          value: obj.ticketId,
          child: Text(obj.ticketName!,
            style: TextStyle(fontSize: textFieldHeadingFontWeight),
          ))).toList() ,
      validator: (value)
      {
        if (value == null)
        {
          return message;
        }
      },
      onChanged: (value)
      {
//
        print("show the selected subject value $value");
        subjectId = value!;

        print("show the subject id $subjectId");

        FocusScope.of(context).requestFocus(FocusNode());
      },
      onSaved: (value)
      {
        //selectedItem = value;
      },
    );
  }

  InputDecoration getTextFieldDecorationWithSuffixIconimages(String hintText, String iconName, Widget methodname, fileimagename)
  {
    return InputDecoration(
      hintText: hintText,
      errorText: validatePassword(fileimagename),
      labelText: '$fileimagename',
      hintStyle: TextStyle(
        color: Colors.grey,
        fontWeight: bold_FontWeight,
      ),
      suffixIcon: Container(
        height: 30.0,
        width: 30.0,
        child: IconButton(
          icon: Image.asset(
            iconName,
            width: 25,
            height: 25,
          ),
          onPressed: ()
          {
            showModalBottomSheet(
              context: context,
              builder: ((builder) => methodname),
            );
          },
        ),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 2.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  String? validatePassword(String value)
  {
    if (value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    }
    return null;
  }

  bottomSheet()
  {
    if(kIsWeb)
      {
        return Container(
          height: 50,
          width: 100,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.image, color: darkGreyColor),
                  label: Text(
                    'Select the picture from Gallery',
                    style: TextStyle(
                      color: darkGreyColor,
                    ),
                  )),
            ],
          ),
        );

      }
    else
      {
        return Container(
          height: 100,
          width: 100,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: kIsWeb
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.image, color: darkGreyColor),
                  label: Text(
                    'Select the picture from Gallery',
                    style: TextStyle(
                      color: darkGreyColor,
                    ),
                  )),
            ],
          )
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextButton.icon(
                onPressed: ()
                {
                  takePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.add_a_photo, color: darkGreyColor),
                label: Text(
                  'Take the picture from Camera',
                  style: TextStyle(
                    color: darkGreyColor,
                  ),
                )),
            TextButton.icon(
              onPressed: ()
              {
                takePhoto(ImageSource.gallery);
                Navigator.pop(context);
              },
              icon: Icon(Icons.image, color: darkGreyColor),
              label: Text(
                'Select the picture from Gallery',
                style: TextStyle(
                  color: darkGreyColor,
                ),
              ),
            ),
          ]),
        );

      }
  }

  void takePhoto(ImageSource source) async
  {
    if (kIsWeb)
    {
      final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
      var imageName = pickedFile?.path.split('/').last;
      if (pickedFile == null) return;
      final imageTemp = File(pickedFile.path);
      print(imageName);
      print(imageTemp);
      setState(()
      {
        print(imageName);
        selectedFileName = imageName!;
        // imageFile = pickedFile;
      });
    }
    else
    {
      final pickedFile = await picker.getImage(
        source: source,imageQuality: 50
      );
      var imageName = pickedFile?.path.split('/').last;
      if (pickedFile == null) return;
      final selectedImageFile = File(pickedFile.path);

      var selectedImageInBytesFormat = await selectedImageFile.readAsBytes();
      selectedFileInBase64Encoded=base64Encode(selectedImageInBytesFormat);
      selectedFileEXT=imageName!.split(".").last;

     // print("show the image selectedFileEXT $selectedFileEXT");
     // print("show the image path $selectedFileInBase64Encoded");

      setState(()
      {
        print(imageName);
        selectedFileName = imageName!;
      });
    }
  }


  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Create Ticket",
        elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
        {
          print("demo");
          validateToTheFields();

        }));
  }

  void validateToTheFields()
  {
    if (_formKey.currentState!.validate())
    {
      print(selectedItem);
      createBodyWebApi_CreateQuery();
    }
  }


  createBodyWebApi_SubjectTickets()
  {
    var mapObject=getCJHub_Support_SubjectTicketList_RequestBody(widget.completedEmpCode!);
    serviceRequest_SubjectTickets(mapObject);
  }
  serviceRequest_SubjectTickets(Map mapObj)
  {
    print("show 1the request12");
    print("show the// request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.get_HRConnect_Subject_Tickets,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          TankhaPaySupportSubjectList subjectListObj=success as TankhaPaySupportSubjectList;
          if(subjectListObj?.statusCode==true)
          {
            setState(() {
              subjectList=subjectListObj.tickets;
            });
          }

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonObject= failure as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
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

  createBodyWebApi_CreateQuery()
  {
    int i=0;
    for(i=0;i<subjectList!.length;i++)
    {
      var searchSubjectObj=subjectList![i];

      if(searchSubjectObj.ticketId==subjectId)
      {
        subjectDesc=subjectList![i].ticketName!;
        break;
      }
    }


    //Map getCJHub_Support_SaveQuery_RequestBody(String empCode,String mobileNo,
    // String dateOfBirth, String ipAddress,String subjectId,
    // String subjectDesc,String documentPathBase64,String documentName,String documentExt)
    var mapObject=getCJHub_Support_SaveQuery_RequestBody(widget.completedEmpCode!,
        IPAddress,subjectId,subjectDesc,queryComment,selectedFileInBase64Encoded,selectedFileName,selectedFileEXT);
    serviceRequest_CreateQuery(mapObject);
  }
  serviceRequest_CreateQuery(Map mapObj)
  {
    print("show 1the request12 11");
    print("show the// request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.save_HRConnect_CreateQuery,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          TankhaPaySupportCreateQueryModelClass createQueryModelClass=success as TankhaPaySupportCreateQueryModelClass;
          if(createQueryModelClass?.statusCode==true)
          {
            //CJSnackBar(context, createQueryModelClass!.message!);

            Navigator.pop(context, [TankhaPayHelpSupport()]);

            CJSnackBar(context, createQueryModelClass!.message!);
           // showDialog(context: context, builder: (_)=>successDialogMethodForAllMessages(context,createQueryModelClass!.message!));

          }

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonObject= failure as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
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
