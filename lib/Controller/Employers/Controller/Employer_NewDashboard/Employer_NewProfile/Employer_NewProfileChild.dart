import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../Constant/ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'Employer_NewProfile.dart';
import 'Employer_NewProfileModel.dart';

var getEmployerProfileList=[
  //profile_data_model(title: "profile_image", value: ""),
  profile_data_model(title: "Employer Name", value: ""),
  profile_data_model(title: "Employer Type", value: ""),
  profile_data_model(title: "Phone", value: ""),
  profile_data_model(title: "Email Id", value: ""),
  profile_data_model(title: "Registered Address", value: ""),
];

var getEmployerProfileEditList=[
  profile_data_model_2(title: "Billing Address", value: ""),
 /* profile_data_model_2(title: "Pin", value: ""),*/
];
//profile_data_model_2(title: "Pin", value: ""),


//

class EditableDateRow extends StatefulWidget
{
  EditableDateRow({Key? key, required this.title, required this.DateValue, required this.selectedDate, this.liveModelObj,}) : super(key: key);

  final String title;
  late String DateValue;
  final int selectedDate;
  final Employer_VerifyMobileNoModelClass? liveModelObj;
//

  @override
  State<EditableDateRow> createState() => _EditableDateRowState();
}

class _EditableDateRowState extends State<EditableDateRow>
{
  bool isEditable = false;
  TextEditingController textcontroller = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List<int> payoutDateList = [for (int i = 1; i <= 31; i++) i];
  int? selectedPayoutDate;
  int date = 7;
  int? value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //date=widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Row(
        children: [
          Expanded(
              child: ListTile(
                title: Text(
                  widget.title,
                  style: TextStyle(
                      color: lightBlueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: large_FontSize),
                ),
                subtitle: Text(
                  "${widget.DateValue}",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: small_FontSize),
                ),

               /*--------26-2-2023 start--------*/
               /* trailing: !isEditable
                    ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
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
                      //!isEditable?
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
                )
                    : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButton(
                        focusColor: Colors.white,
                        underline: Container(),
                        hint: Text(
                          "Select Date   ",
                          style: TextStyle(
                              color: Colors.black, fontSize: medium_FontSize),
                        ),
                        icon: Image.asset(dropdown_arrow_Icon),
                        iconSize: 25,
                        value: selectedPayoutDate,
                        style: const TextStyle(
                            fontFamily: robotoFontFamily,
                            color: blackColor,
                            fontSize: large_FontSize,
                            fontWeight: normal_FontWeight),
                        alignment: Alignment.center,
                        elevation: 0,
                        menuMaxHeight: 100.0,
                        isDense: true,
                        items: payoutDateList.map((selectedPayoutDateObj) {
                          return DropdownMenuItem(
                            child: Text(selectedPayoutDateObj.toString()),
                            value: selectedPayoutDateObj,
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          value = newValue;
                          setState(() {
                            selectedPayoutDate = newValue!;
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        value = null;
                        if (selectedPayoutDate == null) {
                          return CJSnackBar(context, "Please Select Date");
                        }
                        setState(() {
                          createBodyWebApi_updatePayoutDate();
                        });
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: large_FontSize,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                dense: true,*/
                /*--------26-2-2023 end--------*/

              )),
        ],
      ),
    );
  }
  /*----------start-----------------Update Profile payoutdate Api-----------------------------------------*/

  createBodyWebApi_updatePayoutDate()
  {
    var mapObject = getEmployer_EmployerUpdatePayOutDate_RequestBody(widget.liveModelObj?.tpAccountId,
        selectedPayoutDate.toString());
    serviceRequest(mapObject);
  }

  serviceRequest(Map mapObj)
  {
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj, JG_ApiMethod_EmployerUpdateProfile, cjEmployerResponseBlock:
    CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
    {

      EasyLoading.dismiss();
      CJTalentCommonModelClass commonModelClass = commonResponse as CJTalentCommonModelClass;

      if (commonModelClass.statusCode == true)
      {
        print("success");
        setState(() {

          isEditable = false;
          widget.DateValue = "${selectedPayoutDate.toString()}${getDayNumberSuffix(selectedPayoutDate!)} of every month";
          selectedPayoutDate = null;

        });
        CJSnackBar(context, commonModelClass.message!);
      }
    }, employerFailureBlock: <T>(commonResponse,modelResponse)
    {
      EasyLoading.dismiss();
      CJTalentCommonModelClass commonModelClass = commonResponse as CJTalentCommonModelClass;
      if (commonModelClass.statusCode == true)
      {
        print("success");
        CJSnackBar(context, commonModelClass.message!);
      }
    }));
  }

/*------------------end----------Update Profile ----------payoutdate---------API------------*/

}


