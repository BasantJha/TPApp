// import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:circles_background/circles_background/circles_background.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

import '../../../../../Constant/ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../Services/AESAlgo/EncryptedMapBody.dart';
import '../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceKey.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../../Talents/ModelClasses/CJHubSupportModelClass/HrConnect_PendingQuery_ModelResponse.dart';
import '../../../../Talents/ModelClasses/CJHubSupportModelClass/HrConnect_SaveMsg_ModelResponse.dart';
import '../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../TankhaPayModelClasses/TankhaPaySupportModelClass/TankhaPayGetPendingTrailModelClass.dart';
import '../../../TankhaPayModelClasses/TankhaPaySupportModelClass/TankhaPaySupportCreateQueryModelClass.dart';
import '../../../TankhaPayModelClasses/TankhaPaySupportModelClass/chatmodelclass.dart';
import '../ThankhaPayProfile/TankhaPayProfileChild.dart';
import 'TankhaPayCreateTickets.dart';
import 'TankhaPayHelpSupport.dart';

const imagepick = AssetImage(TankhaPay_ChatIcon_Icon);
const sendIcon = AssetImage(TankhaPay_SendIcon_Icon);
//
var chats = [
   /*ChatModel(
       message: "Lorem ipsum dolor sit amet, consectetur sender",
       user: "sender")*/
  // ChatModel(
  //     message: "Lorem ipsum dolor sit amet, consectetur reciever",
  //     user: "reciever"),
  // ChatModel(
  //     message: "Lorem ipsum dolor sit amet, consectetur sender 2",
  //     user: "sender"),
  // ChatModel(
  //     message: "Lorem ipsum dolor sit amet, consectetur reciever 2",
  //     user: "reciever"),
  // ChatModel(
  //     message: "Lorem ipsum dolor sit amet, consectetur reciever 3",
  //     user: "reciever"),
];

class TankhaPayTrailQuery extends StatefulWidget
{
  const TankhaPayTrailQuery({Key? key, this.completedEmpCode, required this.queryId, required this.createdOn, required this.status, required this.empName, }) : super(key: key);

  final String? completedEmpCode;
  final String queryId;
  final String createdOn;
  final String status;
  final String empName;

  @override
  State<TankhaPayTrailQuery> createState() => _TankhaPayTrailQuery();
}

class _TankhaPayTrailQuery extends State<TankhaPayTrailQuery> {


  ImageSource sourceType_GALLERY=ImageSource.gallery;
  ImageSource sourceType_CAMERA=ImageSource.camera;

  String selectedFileName = ' ';
  var selectedFileInBase64Encoded="";
  var selectedFileEXT="";


  final chatFormKey = GlobalKey<FormState>();
  TextEditingController inputController = TextEditingController();
  ScrollController listScrollController = ScrollController();

  var sMsg = "";

  bool imageVisibility=false;

  bool chatVisibility=false;
  Color statusColorCode=greenColor;
  Color chatColorCode=whiteColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.status==kCJHub_Support_QueryType_OpenValue)
      {
        chatVisibility=true;
        statusColorCode=greenColor;
        chatColorCode=Colors.grey[300]!;
      }
    else if(widget.status==kCJHub_Support_QueryType_CloseValue)
      {
        chatVisibility=false;
        statusColorCode=redColor;
        chatColorCode=Colors.grey[50]!;

      }
    else
      {

      }
   /* chats.add(ChatModel(message: "Lorem ipsum dolor sit amet, consectetur sender",
        user: "sender"));
    chats.add(ChatModel(message: "Lorem ipsum dolor sit amet, consectetur sender",
        user: "Employee"));
    chats.add(ChatModel(message: "Lorem ipsum dolor sit amet, consectetur sender",
        user: "Employee"));*/

    createBodyWebApi_getQueryTrail();
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
       // color: Colors.white,
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
             ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [Text("Ticket ID: "), Text("#${widget.queryId}")],
              ),
              Wrap(
                children: [Text("Created Date: "), Text("${widget.createdOn}")],
              ),
              Wrap(
                children: [
                  Text("Status: "),
                  Text(
                    "${widget.status}",
                    style: TextStyle(color: statusColorCode),
                  )
                ],
              ),
            ],
          ),
          /*trailing: InkWell(onTap: ()
          {
            Navigator.pop(context);
            tapToCreateQuery();
          },child: Icon(
            Icons.add,
            color: lightBlueColor,
          ),),*/
        ),
              SizedBox(height: 20,),
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child:  ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      //physics: NeverScrollableScrollPhysics(),
                      itemCount: chats.length,
                      itemBuilder: (context, index)
                      {
                        var chat = chats[index];
                        return (chat.user == "Employee")
                            ? sender_chat(
                            chat.message.toString(), chat.img.toString())
                            : reciver_chat(chat.message.toString());
                      },
                      controller: listScrollController,
                    ),
                  ),
                ),
                // Divider(height: 0, color: Colors.black26),

                Container(
                  color: chatColorCode,
                  height: 60,
                  child: chatVisibility==true ? bottomNavigationForChat():null,
                ),
              ],
            ),
          ],
        ),
      );

  }
 /* tapToCreateQuery()
  {

    Navigator.push(context, MaterialPageRoute(builder: (_)=>

        Responsive(
            mobile: TankhaPayCreateTickets(completedEmpCode: widget.completedEmpCode,),
            tablet: Center(
              child: Container(
                width: webResponsive_TD_Width,
                child: TankhaPayCreateTickets(completedEmpCode: widget.completedEmpCode,),
              ),
            ),

            desktop: Center(
              child: Container(
                width: webResponsive_TD_Width,
                child: TankhaPayCreateTickets(completedEmpCode: widget.completedEmpCode,),
              ),
            )
        )
    )
    ).then((value)
    {

    });
  }*/
//////
  Padding bottomNavigationForChat()
  {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Form(
        key: chatFormKey,
        child: TextFormField(
            controller: inputController,
            validator: (value) {
              if (value!.isEmpty) {
                return "";
              }
              return null;
            },
            onChanged: (value)
            {
              setState(() {
                sMsg = value;
              });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Type Message',
              hintStyle: TextStyle(
                color: blackColor,
                fontSize: large_FontSize,
              ),
              filled: true, //<-- SEE HERE
              fillColor: Color(0xffE5E5E5),
              suffixIcon: Wrap(
                children: [
                  IconButton(
                    onPressed: ()
                    {


                      if(kIsWeb)
                      {
                       // openGalleryFor_Web_And_Mobile(GALLERY);
                        showDialog(context: context, builder: (BuildContext context) => showDialogBoxFor_Web());


                      }else
                      {
                        showDialog(context: context, builder: (BuildContext context) => showDialogBoxFor_Mobile());
                      }

                    },
                    icon: ImageIcon(
                      imagepick,
                      color: blackColor,
                    ),
                  ),
                  IconButton(
                    onPressed: ()
                    {
                      validateToTheFields();
                    },
                    icon: ImageIcon(
                      sendIcon,
                      color: blackColor,
                    ),
                  ),
                ],
              ), //<-- SEE HERE
            )),
      ),
    );
  }

  Container showDialogBoxFor_Web()
  {
    return Container(
        child: Padding(
          padding: EdgeInsets.only(top:1),
          child: Dialog(
            child: Container(
              height: 80,
              width: 20,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 12,),
                    ListTile(
                      leading: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: ()
                        {
                          // print("show the uploadType $uploadType");
                          //openGalleryFor_Web_And_Mobile(GALLERY);
                          openCameraFor_Mobile(GALLERY);

                        },
                        child:Padding(padding:EdgeInsets.only(top: 8),
                          child:Text("Select Document From Gallery",style: TextStyle(fontSize: 14,color: Colors.black)) ,
                        ) ,
                      ),
                      trailing: Icon(Icons.attach_file_sharp),
                    ),

                  ],
                ),),
            ),
          ),
        )
    );
  }
  Container showDialogBoxFor_Mobile()
  {
    return Container(
        child: Padding(
          padding: EdgeInsets.only(top:1),
          child: Dialog(
            child: Container(
              height: 120,
              width: 20,
              child: Center(
                child: Column(
                  children: [
                    ListTile(
                      leading: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: ()
                        {
                          // print("show the uploadType $uploadType");
                          //openGalleryFor_Web_And_Mobile(GALLERY);
                          openCameraFor_Mobile(GALLERY);

                        },
                        child:Padding(padding:EdgeInsets.only(top: 8),
                          child:Text("Select Document From Gallery",style: TextStyle(fontSize: 14,color: Colors.black)) ,
                        ) ,
                      ),
                      trailing: Icon(Icons.attach_file_sharp),
                    ),
                    ListTile(
                      leading: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: ()
                        {
                          // print("show the uploadType $uploadType");
                          openCameraFor_Mobile(CAMERA);


                        },
                        child: Text("Take Document by Camera",style: TextStyle(fontSize: 14,color: Colors.black)),
                      ),
                      trailing: Icon(Icons.camera_enhance_outlined),
                    ),
                  ],
                ),),
            ),
          ),
        )
    );
  }

  openCameraFor_Mobile(String sourceType) async
  {
    final ImagePicker _picker = ImagePicker();
    XFile? image;

    if (!kIsWeb)
    {
      //MOBILE
      if(sourceType==CAMERA)
      {
        image = await _picker.pickImage(source: sourceType_CAMERA);
      }else
      {
        image = await _picker.pickImage(source: sourceType_GALLERY);
      }
    }else
    {
      //WEB
      image = await _picker.pickImage(source: sourceType_GALLERY);
    }

    // MOBILE
    if (!kIsWeb)
    {
      if (image != null)
      {
        var selected = File(image.path);
        var f = await selected.readAsBytes();
        var base64Eccode=base64Encode(f);
        selectedFileName=image.path.split('/').last;
        var fileExt=selectedFileName.split('.').last;

        setState(()
        {

          selectedFileInBase64Encoded = base64Eccode;
          selectedFileEXT = fileExt;

          createBodyWebApi_saveQueryTrail();


          print("show the selectedFileInBase64Encoded $selectedFileInBase64Encoded");
          print("show the selectedFileEXT $selectedFileEXT");
          print("show the selectedFileName $selectedFileName");

        });

      }
      else
      {
        //showToast("No file selected");
      }
    }
    // WEB
    else if (kIsWeb)
    {

      if (image != null)
      {
        var f = await image.readAsBytes();
        var base64Eccode=base64Encode(f);
        selectedFileName=image.name.split('/').last;
        var fileExt=selectedFileName.split('.').last;

        setState(()
        {

          selectedFileInBase64Encoded = base64Eccode;
          selectedFileEXT = fileExt;

          print("show the selectedFileInBase64Encoded $selectedFileInBase64Encoded");
          print("show the selectedFileEXT $selectedFileEXT");
          print("show the selectedFileName $selectedFileName");

          createBodyWebApi_saveQueryTrail();

          //webPAN=f;
        });
      }
      else
      {
        //showToast("No file selected");
      }
    }
    else
    {
      //showToast("Permission not granted");
    }
    Navigator.pop(context);
  }


//
  Row sender_chat(String msg, String img)
  {
    //String img="https://source.unsplash.com/user/c_v_r/1900x800";
    String imageURL=img;
    print("show the image $img");

    Color colorCode ;

    if(imageURL == "null" || imageURL == "")
      {
        imageVisibility=false;
        colorCode = Color(0xff33B8FD);

      }
    else
      {
        imageVisibility=true;
        colorCode = whiteColor;

      }


    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 5,
          child: ListTile(
            trailing: CircleAvatar(
              backgroundColor: lightBlueColor,
              child: Text(
                getProfileEmpName(widget.empName),
                style: TextStyle(
                  color: whiteColor,
                  fontSize: largeExcel_FontSize,
                ),
              ),
            ),
            title: Card(
              color: colorCode,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Visibility(visible: imageVisibility,child:Image.network(img!, width: 100, height: 100, fit: BoxFit.cover,) ,),
                    //(imageURL != "" || imageURL != null) ? Image.network(img!, width: 100, height: 100, fit: BoxFit.cover,) : SizedBox(),
                    (msg != "" || img != null) ? Text(msg, style: TextStyle(color: whiteColor, fontSize: large_FontSize,),) : SizedBox()
                  ],
                ),
                // child: (msg == "null")
                //     ? Image.file(File(img))
                //     : Text(
                //         msg,
                //         style: TextStyle(
                //           color: whiteColor,
                //           fontSize: large_FontSize,
                //         ),
                //       ),
              ),
            ),
          ),
        ),
      ],
    );
  }
//////////
  Widget chatImage(String img)
  {
    return Image.file(File(img));
  }

  Row reciver_chat(String msg)
  {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xffE5E5E5),
              child: Text(
                "TP",
                style: TextStyle(
                  color: whiteColor,
                  fontSize: largeExcel_FontSize,
                ),
              ),
            ),
            title: Card(
              color: Color(0xffE5E5E5),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  msg,
                  style: TextStyle(
                    color: blackColor,
                    fontSize: large_FontSize,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(),
        )
      ],
    );
  }

  void validateToTheFields()
  {
    if (chatFormKey.currentState!.validate())
    {
      print("message - $sMsg");
      createBodyWebApi_saveQueryTrail();
      inputController.clear();
    }
  }

  createBodyWebApi_saveQueryTrail()
  {

  var mapObject=getCJHub_Support_SaveQueryTrail_RequestBody(widget.completedEmpCode!,
        "12345",widget.queryId.toString(),widget.status.toString(),sMsg.toString(),selectedFileInBase64Encoded,
  selectedFileName,selectedFileEXT);
    serviceRequest_SaveQueryTrail(mapObject);
  }
  serviceRequest_SaveQueryTrail(Map mapObj)
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.get_HRConnect_SavePendingQuery_Trail,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          HrConnect_SaveMsg_ModelResponse createQueryModelClass=success as HrConnect_SaveMsg_ModelResponse;
          if(createQueryModelClass?.statusCode==true)
          {
            //CJSnackBar(context, createQueryModelClass!.message!);

            selectedFileInBase64Encoded = "";
            selectedFileEXT = "";
            selectedFileName="";

            createBodyWebApi_getQueryTrail();

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

  createBodyWebApi_getQueryTrail()
  {
    /*Map getCJHub_Support_SaveQueryTrail_RequestBody(String completedEmpCode,
    String ipAddress,String queryId,String replyStatus,String queryComment,
    String documentPathBase64,String documentName,String documentExt)*/

    var mapObject=getCJHub_Support_GetQueryTrail_RequestBody(widget.completedEmpCode!,widget.queryId.toString());
    serviceRequest_GetQueryTrail(mapObject);
  }
  serviceRequest_GetQueryTrail(Map mapObj)
  {
    print("show 1the request12 11");
    print("show the// request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.get_HRConnect_PendingThread,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          TankhaPayGetPendingTrailModelClass createQueryModelClass=success as TankhaPayGetPendingTrailModelClass;
          List<QueriesTrail>? queriesTrail=createQueryModelClass.data!.queriesTrail;


          if(createQueryModelClass?.statusCode==true)
          {
            //CJSnackBar(context, createQueryModelClass!.message!);

            int i=0;
            int count=queriesTrail!.length-1;
            chats=[];
            for(i=count;i>=0;--i)
            {
              var userType=queriesTrail![i].usertype;
              QueriesTrail OBJ=queriesTrail![i];

              setState(()
              {
                chats.add(ChatModel(
                  message: OBJ.queryComment,
                  user: userType,
                  img: OBJ.documentPath,
                ));
              });
            }

          }

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();
//
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
//
}
//