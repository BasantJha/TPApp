import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../Constant/Constants.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceKey.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../JoiningProfile/JoiningProfileModelClass/EmployeeUANVerifyModelClass.dart';
import '../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../TankhaPayModelClasses/TankhaPayProfileModelClass/TankhaPayUpdateAddressModelClass.dart';

ListTile profileListTile(String title, String value)
{
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


class EditableTextRowForProfile extends StatefulWidget
{
  EditableTextRowForProfile({Key? key, required this.title, required this.CurrentAddressValue, required this.jsId,}) : super(key: key);

  final String title;
  late String CurrentAddressValue;
  final String jsId;

  @override
  State<EditableTextRowForProfile> createState() => _EditableTextRow();
}

class _EditableTextRow extends State<EditableTextRowForProfile>
{
  bool isEditable = false;
  TextEditingController textcontroller = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    textcontroller.text=widget.CurrentAddressValue;
    return Form(
      key: formkey,
      child: Row(
        children: [
          Expanded(
              child: ListTile(
                title: Text(
                  widget.title,
                  style: TextStyle(
                    color: darkBlueColor,
                    fontSize: medium_FontSize,
                    fontWeight: bold_FontWeight,
                  ),
                ),
                subtitle: !isEditable
                    ? Text(
                  widget.CurrentAddressValue,
                  style: TextStyle(
                    fontSize: small_FontSize,
                    color: blackColor,
                  ),
                )
                    : TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp("[a-zA-Z0-9-,. ]"))
                  ],
                  textInputAction: TextInputAction.done,
                  controller: textcontroller,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Address shouldn't be empty";
                    }
                    return null;
                  },
                ),
                dense: true,
              )),
          !isEditable
              ? ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: darkGreyColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              setState(() {
                isEditable = true;
              });
            },
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "Edit",
                  style: TextStyle(color: blackColor),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.edit,
                  color: blackColor,
                  size: 15,
                ),
              ],
            ),
          )
              : ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: darkGreyColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              setState(() {
                if (formkey.currentState?.validate() ?? true)
                {
                  isEditable = false;

                  createBodyWebApi_updateAddressForEmployee();
                  widget.CurrentAddressValue = textcontroller.text;
                }
              });
            },
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "Submit",
                  style: TextStyle(color: blackColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  /*----------start-----------------Update Address Api-----------------------------------------*/

/*
  UpdateAddressserviceBodyRequest(address)
  {
    var type = "UpdateAddress";

    var jsId = "2715";
    var createdBy = "5610";
    var mapObject =
    post_updateAddress_RequestBody(type, address, jsId, createdBy);
    UpdateAddressserviceRequest(mapObject);
  }

  UpdateAddressserviceRequest(Map mapObj) {
    print("show the request object $mapObj");

    VerifyUANServiceRequest().postDataServiceRequest(
        mapObj, VA_ApiMethod_UpdateUANorAddress,
        verifyuanResponseBlock:
        VerifyUANResponseBlock(vaSuccessBlock: <T>(success) {
          UpdateUANorADDRESSSModel verifymodel =
          success as UpdateUANorADDRESSSModel;

          if (verifymodel.statusCode == true) {
            showSnackBarAsBottomSheet(context, verifymodel.message!);
            print("success");
          }
          CJSnackBar(context, verifymodel.message!);
        }, vaFailureBlock: <T>(failure) {
          UpdateUANorADDRESSSModel verifymodel =
          failure as UpdateUANorADDRESSSModel;
          if (verifymodel.message == null || verifymodel.message == "") {
            showSnackBarAsBottomSheet(context, verifymodel.message!);
          }
          showSnackBarAsBottomSheet(context, verifymodel.message!);
          print("show the request failure");
        }));
  }
*/

  createBodyWebApi_updateAddressForEmployee()
  {
    var mapObject=getCJHub_EmployeeUpdateProfileAddress_RequestBody(widget.jsId,textcontroller.text);
    serviceRequestForEmployee(mapObject);
  }
//
  /*-----------employee login web api start--------------*/
  serviceRequestForEmployee(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequestFor_UANandAddress(mapObj, WebApi.verify_UANNumber_and_UpdateProfileAddress,kTankhaPay_ProfileAddress_ActionValue,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          print("show sucess");

          CJTalentCommonModelClass updateAddressModelClass=success as CJTalentCommonModelClass;
          if(updateAddressModelClass.statusCode==true)
          {
            print("show sucess1");
            CJSnackBar(context, updateAddressModelClass.message!);

          }

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();
          print("show failure");

          CJTalentCommonModelClass modelObject=failure as CJTalentCommonModelClass;
          if (modelObject.message==null || modelObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context, modelObject.message!);
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
//
        }));
  }
/*------------------end----------Update Address Api-------------------------------*/
}

String getProfileEmpName(String empName)
{
  print("show the empname $empName");
  if(empName != "")
  {

    var getName = empName.trim().split(" ");
    print("show the emp name $getName");

    String completeName = "";
    if (getName.length >= 2) {
      var firstName = getName[0];
      firstName = firstName.substring(0, 1);
      var lastName = getName[1];
      print("show the emp lastName1 $lastName");

      if(lastName=="")
        {

        }
      else
        {
          lastName = lastName.substring(0, 1);
        }
      print("show the emp lastName2 $lastName");
      completeName = firstName + lastName;
      return completeName.toUpperCase();
    }
    else {
      var firstName = "";
      if (getName.length == 1) {
        firstName = getName[0];
        firstName = firstName.substring(0, 1);
      }
      return firstName.toUpperCase();
    }
  }else
    {
      return "TP";
    }
}

String getEmpNameBehalfOfBank(String empName)
{
  if(empName != "") {
    var getName = empName.trim().split(" ");
    String completeName = "";
    if (getName.length >= 2) {
      var firstName = getName[0];
      return firstName;
    }
    else {
      var firstName = "";
      if (getName.length == 1) {
        firstName = getName[0];
      }
      return firstName;
    }
  }else
  {
    return "TP";
  }
}

