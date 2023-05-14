
//import 'dart:html';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employees_Payments/Employees_LatestTransactionDescription.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employees_Payments/Employees_SelectEmployeesList.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:flutter/material.dart';


// ignore: camel_case_types
class Employees_Payments extends StatefulWidget{

  const Employees_Payments({Key? key}) : super(key: key);

  @override
  State<Employees_Payments> createState() => _Employees_Payments();
}

class _Employees_Payments extends State<Employees_Payments>{



  late final Map<String,List<Container>> map= {
    "Latest Transactions": [
      latestTransactionUI("Kamla Devi","Success","13 sep 2022, 9:55 AM","40000.00"),
      latestTransactionUI("Kamla Devi","Success","13 sep 2022, 9:55 AM","4000.00"),
      latestTransactionUI("Kamla Devi","Success","13 sep 2022, 9:55 AM","4000.00")
    ],
    "Pending Payment Request": [
      pendingPaymentRequest("Reena Devi is requesting payment of 35000/-","12:am 16-09-2022"),
    ],
  };

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar:CJAppBar(getEmployer_Payments, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })) ,
      body: getResponsiveUI(),
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

  SingleChildScrollView MainfunctionUi(){
    return SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                child: Column(
                  children: [
                    Text("Choose or Scan Employee to",
                      style: TextStyle(
                          fontSize: large_FontSize,
                          fontWeight: normal_FontWeight,
                          fontFamily: robotoFontFamily,
                          color: lightBlueColor
                      ),
                    ),
                    Text("make Payment",
                      style: TextStyle(
                          fontSize: large_FontSize,
                          fontWeight: normal_FontWeight,
                          fontFamily: robotoFontFamily,
                          color: lightBlueColor
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 130,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius : BorderRadius.all(Radius.circular(15.0)),
                    //color : Color(0xffC6C6C6),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffc6c6c6),
                        Color(0xffd9edee)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    border : Border.all(
                      color: Color(0xffc5c5c5),
                      width: 1,
                    ),
                  ),
                  child:  InkWell(onTap: ()
                    {

                      TalentNavigation().pushTo(context, Employees_SelectEmployeesList());

                    },child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Employer_Icon_SelectEmployee),
                      SizedBox(
                        height: 2,
                      ),
                      Text("Select",
                        style: TextStyle(
                            fontFamily: robotoFontFamily,
                            fontSize: small_FontSize,
                            fontWeight: semiBold_FontWeight
                        ),
                      ),
                      Text("Employee",
                        style: TextStyle(
                            fontFamily: robotoFontFamily,
                            fontSize: small_FontSize,
                            fontWeight: semiBold_FontWeight
                        ),
                      )
                    ],
                  ),),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 130,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius : BorderRadius.all(Radius.circular(15.0)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffc6c6c6),
                        Color(0xffd9edee)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    border : Border.all(
                      color: Color(0xffc5c5c5),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Employer_Icon_ScanQrCode),
                      SizedBox(
                        height: 2,
                      ),
                      Text("Scan",
                        style: TextStyle(
                            fontFamily: robotoFontFamily,
                            fontSize: small_FontSize,
                            fontWeight: semiBold_FontWeight
                        ),
                      ),
                      Text("QR code",
                        style: TextStyle(
                            fontFamily: robotoFontFamily,
                            fontSize: small_FontSize,
                            fontWeight: semiBold_FontWeight
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
                itemCount: map.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  String key = map.keys.elementAt(index);
                  List list = map.values.elementAt(index);
                  return ListTile(
                      title: key == "Pending Payment Request" ?
                      Padding(
                        padding: EdgeInsets.only(top: 10,left: 5),
                        child: Container(
                          child: Text("$key",
                            style: TextStyle(
                                fontWeight: semiBold_FontWeight,
                                fontFamily: robotoFontFamily,
                                fontSize: medium_FontSize,
                                color: blackColor
                            ),
                          ),
                        ),
                      ) :
                      Padding(
                        padding: EdgeInsets.only(top: 10,left: 3),
                        child: Container(
                          // color: Colors.yellow,
                            padding: EdgeInsets.only(right: 15),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex:1,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text("$key",
                                          style: TextStyle(
                                              fontWeight: semiBold_FontWeight,
                                              fontFamily: robotoFontFamily,
                                              fontSize: medium_FontSize,
                                              color: blackColor
                                          ),
                                        ),
                                      )
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: TextButton(
                                        onPressed: (){},
                                        child: Text("View All",
                                          style: TextStyle(
                                              fontSize: small_FontSize,
                                              fontFamily: robotoFontFamily,
                                              fontWeight: normal_FontWeight
                                          ),
                                        )
                                    ),
                                  )
                                ],
                              ),
                            )
                        ),
                      ),
                      subtitle: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            //height: 200,
                            child: ListView.builder(
                                itemCount: list.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index){
                                  return list[index];
                                }
                            ),
                          )
                        ],
                      )
                  );
                }),
          ],
        )
    );
  }

  pendingPaymentRequest(String data, String timespan) {
    return Container(
      margin: EdgeInsets.only(right: 20,top: 10),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: lightGreyColor),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          // height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xffF3F0C5)
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              child: Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape. circle,
                        color: Colors.white
                    ),
                    child: Image.asset(JobSeeker_Icon_Rupee),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    //flex: 3,
                      child: Container(
                        child: ListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data,
                                  style: TextStyle(
                                      fontFamily: robotoFontFamily,
                                      fontSize: medium_FontSize,
                                      fontWeight: FontWeight.normal,
                                      color: blackColor
                                  ),
                                )
                              ],
                            ),
                            subtitle: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(timespan,
                                    style: TextStyle(
                                        fontSize: small_FontSize,
                                        fontFamily: robotoFontFamily,
                                        fontWeight: normal_FontWeight,
                                        color: darkBlueColor
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                        onTap: (){},
                                        child: Text("Decline",style: TextStyle(color: redColor,fontSize: smallLess_FontSize,fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight),)
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    InkWell(
                                        onTap: (){},
                                        child: Text("Pay",style: TextStyle(color: greenColor,fontSize: smallLess_FontSize,fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight),)
                                    )
                                  ],
                                )
                              ],
                            )
                        ),
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  latestTransactionUI(String benificiryname,String status,String Date,String amount)
  {

    return Container(
      decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          border: Border.all(
            // width: 2,
              color: lightGreyColor
          )
      ),
      margin: EdgeInsets.only(right: 20,top: 10),
      child: InkWell(onTap: ()
        {
          TalentNavigation().pushTo(context, Employees_LatestTransactionDescription());

        },child: ListTile(
          leading: Image.asset(Employer_Icon_Paid),
          title: Text("Paid to $benificiryname",
            style: TextStyle(
                fontSize: small_FontSize,
                fontFamily: robotoFontFamily,
                fontWeight: semiBold_FontWeight
            ),
          ),
          subtitle: Row(
            children: [
              Text("$status,",
                style: TextStyle(
                    fontWeight: normal_FontWeight,
                    fontFamily: robotoFontFamily,
                    fontSize: smallLess_FontSize,
                    color: Color(0xff317600)
                ),
              ),
              SizedBox(
                width: 1,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text("$Date",
                  style: TextStyle(
                      fontFamily: robotoFontFamily,
                      fontSize: smallLess_FontSize
                  ),
                ),
              )
            ],
          ),
          trailing: Text("\u{20B9}$amount",
            style: TextStyle(
                fontSize: small_FontSize,
                fontFamily: robotoFontFamily,
                fontWeight: semiBold_FontWeight
            ),
          )
      ),),
    );
  }





}