

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// ignore: camel_case_types
class Employees_SelectEmployeePayment extends StatefulWidget{

  const Employees_SelectEmployeePayment({Key? key}) : super(key: key);

  @override
  State<Employees_SelectEmployeePayment> createState() => _Employees_SelectEmployeePayment();
}

class _Employees_SelectEmployeePayment extends State<Employees_SelectEmployeePayment>{

  String profileimage = Employer_Icon_SelectEmployeeListIcon;
  String emailicon= Employer_Icon_EmailGrey;
  String phoneicon = phone_Icon_Grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
        appBar:CJAppBar(getEmployer_SelectEmployeePayments, appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action type");
          Navigator.pop(context);
        })) ,
      body: getResponsiveUI(),
        bottomNavigationBar: elevatedButtonBottomBar()

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            decoration:
            ShapeDecoration(shape: CircleBorder(), color: Colors.white),
            child: DecoratedBox(
              decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(profileimage)
                  )
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              child: Column(
                children: [
                  Text("Paying to Angila Jolie",
                    style: TextStyle(
                        fontSize: medium_FontSize,
                        fontWeight: semiBold_FontWeight,
                        fontFamily: robotoFontFamily
                    ),
                  ),
                ],
              )
          ),
          SizedBox(
            height: 10,
          ),
          Container(height: 40,
            child:  Row(
              children: [
                Expanded(
                    child: Center(
                      child: Container(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(phoneicon,height: 12,width: 12,color:Color(0xff969696),),
                            SizedBox(
                              width: 4,
                            ),
                            Text("mobileno",
                              style: TextStyle(color:Color(0xff969696),fontSize: 12,
                                  fontWeight: normal_FontWeight,
                                  fontFamily: robotoFontFamily
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ),
                Expanded(
                    child: Container(
                      //color: Colors.yellow,
                      //height: 20,
                      child:Row(
                        children: [
                          Image.asset(emailicon,height: 20,width: 20,color:Color(0xff969696),),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(child:  Text("nyadav@akalinfosys.com",
                            style: TextStyle(color:Color(0xff969696),fontSize: 12,
                                fontWeight: normal_FontWeight,
                                fontFamily: robotoFontFamily
                            ),
                          ))
                         ,
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              child: Text("Enter Amount",
                style: TextStyle(
                    fontSize: small_FontSize,
                    fontFamily: robotoFontFamily,
                    fontWeight: semiBold_FontWeight
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Image.asset("assets/rupayicon.png"),
                Text('\u{20B9}',
                  style: TextStyle(fontSize:40,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight,color: Color(0xff555555)),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: 150,
                  child: TextFormField(
                    style: TextStyle(
                        fontSize:40,
                        fontFamily: robotoFontFamily,
                        fontWeight: normal_FontWeight,
                        color: Color(0xff555555)
                    ),
                    onChanged: (value) {},
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        enabledBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey,width: 2),
                        ),
                        labelStyle:TextStyle(fontSize:40,
                            fontFamily: "Roboto",
                            fontWeight: normal_FontWeight,
                            color: Color(0xff555555)
                        ),
                        hintStyle: TextStyle(fontSize:40,
                            fontFamily: robotoFontFamily,
                            fontWeight: normal_FontWeight,
                            color: Color(0xff555555)
                        ),
                        hintText: "1500"
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          /*Container(
            width: 198,
            height: 72,
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius : BorderRadius.all(Radius.circular(10.0)),
              color : Color(0xffE4E4E4),
            ),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add a note'
              ),
            ),
          )*/
          Container(
            width: 198,
            height: 72,
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius : BorderRadius.all(Radius.circular(10.0)),
              color : Color(0xffE4E4E4),
            ),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Add a note',
              ),
            ),
          )
        ],
      ),
    );
  }


  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Generate BOS", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action");

      //TalentNavigation().pushTo(context, Talent_RaiseBillQRCode());

    }
    )) ;

  }

}

