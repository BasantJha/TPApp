import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_RaiseBill/Talent_RaiseBillChooseEmployer.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_RaiseBill/Talent_RaiseBillOfService.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_RaiseBill/Talent_RaiseBillQRCode.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/MarginSizeBox/MarginSizeBox.dart';
import 'package:contractjobs/CustomView/Text/TextStyle.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';


class Talent_RaiseBillInvoice extends StatefulWidget
{
  @override
  _Talent_RaiseBillInvoice createState() => _Talent_RaiseBillInvoice();
}

class _Talent_RaiseBillInvoice extends State<Talent_RaiseBillInvoice> {
  final List<String> items = <String>[
    'Salary',
    'PF',
    'ESIC',
    'LWF',
    'TDS',
    'Gratuity',
    'Convenience Charges',
    'Support Fee',
    'Sub Total'

  ];
  final List<int> amounts = <int>[3000, 450, 120, 0, 0, 86, 146, 146,3948];

  TextEditingController nameController = TextEditingController();
  var getTextStyle=TextStyle(color: blackColor,
      fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight,
      fontSize: 12);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar:CJAppBar(getTalent_RaiseABillInvoiceTitle, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),
      body:getResponsiveUI(),
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

  MainfunctionUi()
  {
    return Container(color: whiteColor,child:ListView(
      children: [
       // SizedBox_5px,
        Center(child:getViewHintTextBlue(getTalent_Passbook_GenerateBillOfInvoiceHint),),

        SizedBox_10px,

        Container(
            child:
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text("Employer Name",
                style: TextStyle(fontSize: 13,fontFamily: robotoFontFamily,fontWeight:semiBold_FontWeight ),
              ),
            )
        ),
        Container(
            child:
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text("8765748776",
                style: TextStyle(fontSize: 12,fontFamily: robotoFontFamily,fontWeight:semiBold_FontWeight ),
              ),
            )
        ),

        SizedBox_20px,
        Container(
            child:
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 162, 0),
              child: Text("Invoice No.: 9867598",
                style: TextStyle(fontSize: 13,fontFamily: robotoFontFamily,fontWeight:semiBold_FontWeight ),
              ),
            )
        ),

        Container(
            child:
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 200, 0),
              child: Text(
                "Date: 13-09-2022",
                style: TextStyle(fontSize: 12,fontFamily: robotoFontFamily,fontWeight:semiBold_FontWeight ),
              ),
            )
        ),

        SizedBox_20px,
        Container(
          height: 50,
          margin:  EdgeInsets.fromLTRB(15, 0, 15, 0),
          color: Colors.lightBlue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Item",
                  style: TextStyle(fontSize: 16,color: whiteColor),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Amount",
                  style: TextStyle(fontSize: 16,color: whiteColor),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            ListView.builder(
              physics:  ClampingScrollPhysics(),
              shrinkWrap: true,
              padding:  EdgeInsets.all(10),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index)
              {
                if (index == items.length - 1)
                {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 1,
                        color: Colors.grey,
                      ),
                      ListTile(
                        title: Text(items[index],style:
                        TextStyle(color: blackColor,fontSize: 14,fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight),),
                        trailing: Text('₹${amounts[index]}',style:
                        TextStyle(color: blackColor,fontSize: 14,fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight)),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 1,
                          color: Colors.grey),
                    ],
                  );
                }
                return ListTile(
                  title: Text(items[index],style:
                  TextStyle(color: blackColor,fontSize: 14,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight)),
                  trailing: Text('₹${amounts[index]}',style:
                  TextStyle(color: blackColor,fontSize: 14,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight)),
                );
              },
            ),
          ],
        ),
        SizedBox_10px,

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding:  EdgeInsets.fromLTRB(180, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text("Sub Total:   ₹4543",style: getTextStyle,),
                  SizedBox_5px,

                  Text("GST 18%:   ₹179",style: getTextStyle,),
                  SizedBox_5px,

                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () {},
                      child:  Text("Total:  ₹4252542"))
                ],
              ),
            ),
          ],
        ),
        SizedBox_20px,

      ],
    ) ,);

  }

  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Generate QR Code", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action");

      TalentNavigation().pushTo(context, Talent_RaiseBillQRCode());

    }
    )) ;

  }
}
