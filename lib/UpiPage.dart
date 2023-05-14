
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:flutter/material.dart';

import 'CustomView/AppBar/AppBarTitle.dart';
import 'CustomView/AppBar/CustomAppBar.dart';


class customUpiPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _customUpiPage();

}

class _customUpiPage extends State<customUpiPage>
{

  var radioValue = 0;

   var upiAppValue  = 2;

   List<Widget> UpiAppList = [
     InkWell(
       child: Image.asset("assets/CustomUPIIcon/gpayIcon.png",
           height: 40,width: 40
       ),
       onTap: (){

       },
     ),
     InkWell(
       child: Image.asset("assets/CustomUPIIcon/phonepeIcon.png",
           height: 40,width: 40
       ),
       onTap: (){

       },
     ),
     InkWell(
       child: Image.asset("assets/CustomUPIIcon/paytmIcon.png",
           height: 40,width: 40
       ),
       onTap: (){

       },
     ),
     InkWell(
       child: Image.asset("assets/CustomUPIIcon/amazonPayIcon.png",
           height: 40,width: 40
       ),
       onTap: (){

       },
     ),
   ];

  @override
  Widget build(BuildContext context) {
     return Scaffold(
         appBar: CJAppBar("Rapay",
             appBarBlock: AppBarBlock(appBarAction: ()
             {
               // print("show the action type");
               Navigator.pop(context);
             })),
       backgroundColor: whiteColor,
       body: Responsive(
         mobile: MainFunctionUI(),
         tablet: Container(
           width: flutterWeb_desktopWidth,
           child: MainFunctionUI(),
         ),
         desktop: Container(
           width: flutterWeb_desktopWidth,
           child: MainFunctionUI(),
         ),

       ),
     );
  }


  SingleChildScrollView MainFunctionUI()
  {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
                color: whiteColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Repayment Amount",
                            style: TextStyle(
                                color: blackColor,
                                fontSize: medium_FontSize,
                                fontFamily: robotoFontFamily,
                                fontWeight: semiBold_FontWeight
                            ),
                          ),
                          Text("\u{20B9}100",
                            style: TextStyle(
                                color: redColor,
                                fontSize: medium_FontSize,
                                fontFamily: robotoFontFamily,
                                fontWeight: semiBold_FontWeight
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: darkGreyColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                children: [
                                  radioButtonWithPaymentHeading('UPI Apps',0),
                                  constantSizedBox(),
                                  Visibility(
                                    visible: radioValue == 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: GridView.builder(
                                        itemCount: UpiAppList.length,
                                        shrinkWrap: true,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            crossAxisSpacing: 50.0,
                                            mainAxisSpacing: 50.0
                                        ),
                                        itemBuilder: (BuildContext context, int index){
                                          return UpiAppList[index];
                                        },
                                      ),
                                    )
                                  ),
                                  Divider(
                                    height: 10,
                                    color: darkGreyColor,
                                  ),
                                  constantSizedBox(),
                                  radioButtonWithPaymentHeading('UPI ID',1),
                                  subtitleHeadingText("Please enter details of UPI ID"),
                                  Visibility(
                                    visible: radioValue == 1,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 60,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(width: 1, color: darkGreyColor),
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all<Color>(darkGreyColor),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                  ),
                                                )
                                            ),
                                            onPressed: (){},
                                            child: Text("Pay")
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Visibility(
                                    visible: radioValue == 1,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 60,
                                        ),
                                        Expanded(
                                          child: Text("The UPI ID is in the format of Name/PhoneNumber@BankName",
                                            style: TextStyle(
                                                fontWeight: semiBold_FontWeight,
                                                fontSize: small_FontSize,
                                                fontFamily: robotoFontFamily,
                                                color: darkGreyColor
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                )
            ),
          )
        ),
      ),
    );
  }


  radioButtonWithPaymentHeading(String upIHeading,int value)
  {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            child: Radio(
              value: value,
              groupValue: radioValue,
              onChanged: (value) {
                setState(() {
                  radioValue = value!;
                });
              },
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Text(upIHeading,
            style: TextStyle(
                color: blackColor,
                fontSize: medium_FontSize,
                fontFamily: robotoFontFamily,
                fontWeight: normal_FontWeight
            ),
          ),
        ],
      ),
    );
  }

  constantSizedBox()
  {
    return  SizedBox(
      height: 20,
    );
  }


  subtitleHeadingText(String text)
  {
    return Row(
      children: [
        Container(
          height: 20,
          width: 60,
        ),
        Text(text,
          style: TextStyle(
              fontWeight: normal_FontWeight,
              fontSize: small_FontSize,
              fontFamily: robotoFontFamily,
              color: darkGreyColor
          ),
        )
      ],
    );
  }



}

