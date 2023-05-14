
import 'package:flutter/material.dart';

import 'Constant/Constants.dart';
import 'Constant/Responsive.dart';
import 'CustomView/AppBar/CustomAppBar.dart';


class SetUPSalarypage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _SetUPSalarypage();

}


class _SetUPSalarypage extends State<SetUPSalarypage>
{

  var SchemeValue = "Esic Scheme";

  List EsiSchemeList = [
      "An employee is eligible for ESIC only when his salary is less than or equal to RS. 21000.",
    "The total ESI contribution percentage is 4% (3.25% employer contribution and 0.75% employee contribution)."
  ];

  List<Color> gradientColorEsiScheme = [
    Color(0xfffdfdfd),
    Color(0xfff9f9f9),
    Color(0xfff2f2f2),
    Color(0xffe8e8e8)
  ];

  List PFSchemeList = [
      "The employee is eligible for PF if his salary is less than or equal to RS. 15000.",
    "For any employee with a salary greater than RS. 15000,providing PF is voluntary.",
    "If the employee is already registered under the PF scheme, it is mandatory to provide PF.",
    "The total PF contribution is 25%(13% employer contribution and 12% employee contribution)"
  ];

  List<Color> gradientColorPFSchemeList = [
    Color(0xfff0fbff),
    Color(0xffc4eaff),
    Color(0xffa5e0fe),
    Color(0xff4fc1fd),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: whiteColor,
      appBar:CJAppBar("SetUp Salary", appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),
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

  MainfunctionUi()
  {
    return SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Text("Choose Social Security Benefits",
                  style: TextStyle(
                      color: lightBlueColor,
                      fontSize: large_FontSize,
                      fontWeight: normal_FontWeight,
                      fontFamily: robotoFontFamily
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                schemeBoxContainerFunction("ESIC Scheme"),
                SchemeListUI(EsiSchemeList),
                SizedBox(
                  height: 20,
                ),
                schemeBoxContainerFunction("PF Scheme"),
                SchemeListUI(PFSchemeList),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff33b8fd),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      minimumSize: Size(200, 70),
                    ),
                    onPressed: (){},
                    child: Text("Continue",
                      style: TextStyle(
                          color: whiteColor,
                          fontFamily: robotoFontFamily,
                          fontWeight: bold_FontWeight,
                          fontSize: large_FontSize
                      ),
                    )
                )
              ],
            ),
          ),
        ),
    );
  }

  schemeBoxContainerFunction(String scheme)
  {
    return InkWell(
      onTap: (){
        setState(() {
          SchemeValue = scheme;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: darkGreyColor),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.1,
                0.4,
                0.6,
                0.9,
              ],
              colors:
              scheme == "ESIC Scheme"?gradientColorEsiScheme:gradientColorPFSchemeList,
            )
        ),
        child: Row(
          children: [
            Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: darkGreyColor)
                ),
                child: SchemeValue == scheme ? Image.asset("assets/transactionDoneIcon.png",height: 20,width: 20,): Container()
            ),
            SizedBox(
              width: 10,
            ),
            Text(scheme,
              style: TextStyle(
                  color: blackColor,
                  fontFamily: robotoFontFamily,
                  fontWeight: bold_FontWeight,
                  fontSize: medium_FontSize
              ),
            )
          ],
        ),
      ),
    );
  }

  SchemeListUI(List dataList)
  {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView.builder(
          itemCount: dataList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,i){
            return ListTile(
              leading: Container(
                height: 7,
                width: 7,
                decoration: BoxDecoration(
                    color: blackColor,
                    shape: BoxShape.circle
                ),
              ),
              dense:true,
              minLeadingWidth : 7,
              contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              title: Text(dataList[i],
                style: TextStyle(
                    fontSize: medium_FontSize,
                    fontWeight: normal_FontWeight,
                    fontFamily: robotoFontFamily
                ),
              ),
            );
          }
      ),
    );
  }

}

