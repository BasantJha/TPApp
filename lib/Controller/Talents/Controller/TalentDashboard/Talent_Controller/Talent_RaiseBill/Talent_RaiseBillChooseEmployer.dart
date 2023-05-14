import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/Messages/Talent_TextMessages.dart';
import 'package:flutter/material.dart';
import 'dart:math';


void main() => runApp(const Talent_RaiseBillChooseEmployer());

class  Talent_RaiseBillChooseEmployer extends StatefulWidget
{
  const Talent_RaiseBillChooseEmployer({key});

  @override
  State<Talent_RaiseBillChooseEmployer> createState() => _Talent_RaiseBillChooseEmployer();
}

class _Talent_RaiseBillChooseEmployer extends State<Talent_RaiseBillChooseEmployer>
{

  var raiseBillChooseEmployerList=getRaiseBillChooseEmployerList;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(color: whiteColor,
      debugShowCheckedModeBanner:false,

      home: Scaffold(

        appBar:CJAppBar(getTalent_RaiseABillInvoiceTitle, appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action type");
          Navigator.pop(context);
        })),
        body: getResponsiveUI(),
        // body:employer(),
      ),
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

  Container MainfunctionUi()
  {
   return Container(padding: EdgeInsets.only(top: 20,bottom: 20),color: whiteColor,child: ListView.builder(
        itemCount: raiseBillChooseEmployerList.length,
        itemBuilder: (BuildContext context, int index)
        {
          // ImageProvider companylogo;
          return ListTile(
            leading: raiseBillChooseEmployerList[index].companylogo == null ?
            CircleAvatar(child: Text('${raiseBillChooseEmployerList[index].companyname[0]}'),
                backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)]):
            CircleAvatar(backgroundImage: AssetImage("${raiseBillChooseEmployerList[index].companylogo}"),
              backgroundColor: Colors.white,),
            title: Text('${raiseBillChooseEmployerList[index].companyname}',
              style: TextStyle(
                color: darkBlueColor,
                fontWeight: bold_FontWeight,fontFamily: robotoFontFamily
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${raiseBillChooseEmployerList[index].email}',
                  style: TextStyle(fontWeight: bold_FontWeight,fontFamily: robotoFontFamily),
                ),
                Text('${raiseBillChooseEmployerList[index].mobileno}',
                  style: TextStyle(fontWeight: bold_FontWeight,fontFamily: robotoFontFamily),
                ),
              ],
            ),
          );
        }
    ),);

  }
}






