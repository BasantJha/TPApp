
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:flutter/material.dart';



// ignore: camel_case_types
class Employees_LatestTransactionDescription extends StatefulWidget{
  @override
  State<Employees_LatestTransactionDescription> createState() => _Employees_LatestTransactionDescription();
}

class _Employees_LatestTransactionDescription extends State<Employees_LatestTransactionDescription>{

  String verifiedicon = Employer_Icon_VerifiedPaymentGreen;


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Color(0xffFFFFFF),
        leading: Padding(
          padding: EdgeInsets.only(left: 15,top: 30.0,bottom: 30.0),
          child: Container(
              width: 50,
              height: 43,
              child: IconButton(
                onPressed: ()
                {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios,color: blackColor,),
              ),
              decoration: BoxDecoration(
                borderRadius : BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color : darkGreyColor,
              )
          ),
        ),
        titleSpacing: 10,
        title: Container(
          // color: Colors.yellow,
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Text("Payment Paid",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: semiBold_FontWeight,
                      fontFamily: robotoFontFamily,
                      fontSize: large_FontSize
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all<Color>(
                      Colors.white),
                ),
                onPressed: (){},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Share",
                      style: TextStyle(fontSize: 11,
                        color: lightBlueColor,

                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    ImageIcon(
                      AssetImage(Share_Icon,),
                      color: lightBlueColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: whiteColor,
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

  SingleChildScrollView MainfunctionUi()
  {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 2,
              child: Container(
                //height: 145,
                padding: EdgeInsets.only(left: 20,top: 20,bottom: 20),
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: lightGreyColor),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Amount",
                      style: TextStyle(
                          fontSize: medium_FontSize,
                          fontFamily: robotoFontFamily,
                          fontWeight: normal_FontWeight
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text('\u{20B9}',
                          style: TextStyle(fontSize:35,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight,color: Color(0xff555555)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text("4500",
                            style: TextStyle(fontSize:35,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight,color: Color(0xff555555)),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset( verifiedicon,height: 35,width: 35,)
                      ],
                    ),
                    Column(
                      children: [
                        Text("Four Thousand Five Hundred Only",
                          style: TextStyle(
                              fontSize: medium_FontSize,
                              fontFamily: robotoFontFamily,
                              fontWeight: normal_FontWeight
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 2,
              child: Container(
                //height: 248,
                width: double.infinity,
                padding: EdgeInsets.only(left: 20,top: 10,bottom: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: lightGreyColor),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("To",
                      style: TextStyle(
                          fontSize: medium_FontSize,
                          fontFamily: robotoFontFamily,
                          fontWeight: normal_FontWeight
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        Text("Akal Information System Ltd.",
                          style: TextStyle(
                              fontSize: medium_FontSize,
                              fontFamily: robotoFontFamily,
                              fontWeight: normal_FontWeight
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        Text("(For Lokesh Aggarwal)",
                          style: TextStyle(
                              fontFamily: robotoFontFamily,
                              fontSize: medium_FontSize,
                              color: Color(0xff828282)
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Paid at: 5:00, 5-9-2022",
                      style: TextStyle(
                          fontFamily: robotoFontFamily,
                          fontSize: medium_FontSize,
                          color: Color(0xff828282)
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        Text("Order id: 2663646664",
                          style: TextStyle(
                              fontFamily: robotoFontFamily,
                              fontSize: medium_FontSize,
                              color: Color(0xff828282)
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:  MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: (){},
                        child: Text("Pay Again",
                          style: TextStyle(
                              color: Colors.blue
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


}