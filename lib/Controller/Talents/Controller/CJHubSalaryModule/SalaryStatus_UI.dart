import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../Constant/Constants.dart';
//import 'package:web/constants/constants.dart';


class SalaryStatus_UI
{

  static Container create_headingContainer(String value){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,20,0,0),
        child: Row(
          children: [
            SizedBox(
              width: 20.0,
              height: 20.0,
              child: Image.asset(getCJHub_LineIcon,
              ),
            ),
            SizedBox(
                width: 1.0),
            Expanded(
              flex: 1,
              child: Text(value,
                style: TextStyle(color: Colors.black,fontSize: 15),),
            ),
          ],
        ),
      ),
    );
  }

  static Container create_salaryBannerContainer(String value){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30,20,30,5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*-----------------08-08-2022-----start---------*/
            Container(
              width: double.infinity,
              height: 200,

              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          getCJHub_SalaryStatuBanner),
                      )),
              padding: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: 'Salary Status for\nthe month of\n',
                    style: new TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                      /*TextSpan(text: "Salary Status for\nthe month of\n",style: TextStyle(color: Colors.white,
    fontSize: 14.0,)),*/
                      TextSpan(text: value, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,
                        fontSize: 18.0,)),
                    ],
                  ),
                ),
                /*Text(
                  value,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                  // fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.left,
                ),*/
              ),
            )

            /*-----------------08-08-2022-----end---------*/

            /*SizedBox(
              height: 200,
              child: Image.asset("salary_status_banner.png",
              ),
            ),*/

          ],
        ),
      ),
    );
  }

  static Container create_RTEC_BannerContainer(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30,0,30,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset("rider-banner.jpg",
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Container create_cardUnselectedContainer(String salaryStatus_name){
    return Container(
        width: 320,
        height: 65.0,
        margin: const EdgeInsets.symmetric(
          // vertical: 6.0,
          horizontal: 20.0,
        ),
        child: new Stack(
          children: <Widget>[
            Container(
              height: 65.0,
              width: 320,
              margin: new EdgeInsets.only(left: 10),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                  border: Border.all(color: fourHunGreyColor,
                      width: 1.0,
                      style: BorderStyle.solid)
              ),
              padding: const EdgeInsets.only(left:30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(salaryStatus_name,
                    style: TextStyle(color: Colors.grey,
                        fontSize: 15),),
                ],
              ),
            ),
            Container(
              alignment: FractionalOffset.centerLeft,
              child: new Image(
                image: new AssetImage(getCJHub_SalaryStatusGreyTick),
                height: 30.0,
                width: 30.0,
              ),
            ),
          ],
        )
    );
  }

  static SizedBox create_sizebetweenCards(){
    return SizedBox(
      height: 15,
    );
  }

  static Container create_cardSelectedContainer(String salaryStatus_selectName, String date){
    return Container(
        width: 320,
        height: 65.0,
        margin: const EdgeInsets.symmetric(
          // vertical: 6.0,
          horizontal: 20.0,
        ),
        child: new Stack(
          children: <Widget>[
            Container(
              height: 65.0,
              width: 320,
              margin: new EdgeInsets.only(left: 10),
              decoration: new BoxDecoration(
                  color: Color(0xffF2FBFA),
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                  border: Border.all(color: fourHunGreyColor,
                      width: 1.0,
                      style: BorderStyle.solid)
              ),
              padding: const EdgeInsets.only(left:30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(salaryStatus_selectName,
                    style: TextStyle(color: Color(0xff32AAE0),
                        fontSize: 15),),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text("Date:", style: TextStyle(color: Colors.black,
                          fontSize: 15),),
                      SizedBox(
                        width: 2,
                      ),
                      Text(date, style: TextStyle(color: Colors.black,
                          fontSize: 15),),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              alignment: FractionalOffset.centerLeft,
              child: new Image(
                image: new AssetImage(getCJHub_SalaryStatusBlueTick),
                height: 30.0,
                width: 30.0,
              ),
            ),
          ],
        )
    );
  }


  static Container create_cardSelectedContainerFor_Rider(String headingName,BuildContext context,String actionName){
    return Container(
        width: 320,
        height: 65.0,
        margin: const EdgeInsets.symmetric(
          // vertical: 6.0,
          horizontal: 20.0,
        ),
        child: new Stack(
          children: <Widget>[
            Container(
              height: 65.0,
              width: 320,
              margin: new EdgeInsets.only(left: 10),
              decoration: new BoxDecoration(
                  color: Color(0xffF2FBFA),
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                  border: Border.all(color: fourHunGreyColor,
                      width: 1.0,
                      style: BorderStyle.solid)
              ),
              padding: const EdgeInsets.only(left:30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(headingName,
                    style: TextStyle(color: Color(0xff32AAE0),
                        fontSize: 15),),
                  SizedBox(
                    height: 2,
                  ),

                  createText_CardSelected_Rider(context,actionName),


                ],
              ),
            ),
            Container(
              alignment: FractionalOffset.centerLeft,
              child: new Image(
                image: new AssetImage(getCJHub_SalaryStatusBlueTick),
                height: 30.0,
                width: 30.0,
              ),
            ),
          ],
        )
    );
  }


  static Container createText_CardSelected_Rider(BuildContext context,String actionName){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,5,0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                height: 30, //height of button
                width: 170,
                child:
                MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: ()
                  {

                  },
                  child:Align(alignment: Alignment.centerRight,child:Text('View Details',
                      style: TextStyle(fontFamily: 'Vonique',
                          fontSize: 13,
                          color: blackColor))),
                )),],
        ),
      ),
    );
  }

  static Container create_cardUnselectedContainerFor_Rider(String headingName,BuildContext context,String actionName){
    return Container(
        width: 320,
        height: 65.0,
        margin: const EdgeInsets.symmetric(
          // vertical: 6.0,
          horizontal: 20.0,
        ),
        child: new Stack(
          children: <Widget>[
            Container(
              height: 65.0,
              width: 320,
              margin: new EdgeInsets.only(left: 10),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                  border: Border.all(color: fourHunGreyColor,
                      width: 1.0,
                      style: BorderStyle.solid)
              ),
              padding: const EdgeInsets.only(left:30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(headingName,
                    style: TextStyle(color: Colors.grey,
                        fontSize: 15),),
                  SizedBox(
                    height: 2,
                  ),
                  createText_CardUnSelected_Rider(context,actionName)
                ],
              ),
            ),
            Container(
              alignment: FractionalOffset.centerLeft,
              child: new Image(
                image: new AssetImage(getCJHub_SalaryStatusGreyTick),
                height: 30.0,
                width: 30.0,
              ),
            ),
          ],
        )
    );
  }

  static Container createText_CardUnSelected_Rider(BuildContext context,String actionName){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,5,0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                height: 30, //height of button
                width: 170,
                child:
                MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: ()
                  {

                    /*-------------Commented navigation class  07-06-2022 start-------------------------*/
                    if(actionName=="Add Document")
                    {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>RTEC_UploadDocuments()));
                    }
                    else if(actionName=="Add Bank Details")
                    {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>RTEC_BankDetails()));
                    }
                    else if(actionName=="Add Nominee Details")
                    {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>RTEC_NomineeDetails()));
                    }
                    else
                    {

                    }

                    /*-------------Commented navigation class  07-06-2022  end-------------------------*/

                  },
                  child:Align(alignment: Alignment.centerRight,child:Text(actionName,
                      style: TextStyle(fontFamily: 'Vonique',
                          fontSize: 13,
                          color: primaryColor))),
                )),],
        ),
      ),
    );
  }


}