import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'Employer_WorkPlace_ViewEmployeesDialog.dart';


const searchImg = AssetImage(search_Icon);
const personImageCircular = AssetImage(Employer_Icon_ProfileGrey);
const personImageSimple = AssetImage(Employer_Icon_WorkPlacePersonGrey);
const phoneImg = AssetImage(phone_Icon_Grey);
const mailImg = AssetImage(Employer_Icon_EmailGrey);
const calenderImg = AssetImage(Talent_Icon_Passbook_calendar);

class Employer_WorkPlace_ViewEmployees extends StatefulWidget
{
  final List? wrk_emps;
  final String? title;
  const Employer_WorkPlace_ViewEmployees({super.key, this.wrk_emps, this.title});

  @override
  State<Employer_WorkPlace_ViewEmployees> createState() => _Employer_WorkPlace_ViewEmployees();
}

class _Employer_WorkPlace_ViewEmployees extends State<Employer_WorkPlace_ViewEmployees> {
  List? emps;
  String? heading;
  @override
  void initState() {
    super.initState();

    emps = widget.wrk_emps;
    heading = widget.title;
  }

  void searchResult(String query) {
    final suggestions = widget.wrk_emps!.where((emp) {
      var empName = emp.name!.toString().toLowerCase();
      var input = query.toLowerCase();

      // print(input);
      // print(empName);

      return empName.contains(input);
    }).toList();

    // print("show the search records $suggestions");

    // print(suggestions.length);

    setState(() => emps = suggestions);
  }

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      child: Scaffold(backgroundColor: whiteColor,
        appBar:CJAppBar(getEmployer_ViewEmployee, appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action type");
          Navigator.pop(context);
        })) ,
        body: getResponsiveUI(),
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
  Padding MainfunctionUi()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              heading!,
              style: TextStyle(
                color: darkBlueColor,
                fontFamily: robotoFontFamily,
                fontSize: viewHeadingFontweight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              tileColor: Color(0xffF5F5F5),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xffE3E3E3), width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              title: TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Search Job",
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.black, fontSize: 18.0),
                onChanged: searchResult,
              ),
              trailing: ImageIcon(searchImg),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: emps!.length,
              itemBuilder: (context, index) {
                final emp = emps![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: emp_card(emp),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Card emp_card(emp)
  {
    return Card(
      shape: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: darkBlueColor,
        ),
      ),
      color: whiteColor,
      margin: EdgeInsets.zero,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        child: ListTile(
          tileColor: whiteColor,
          leading: Image(image: AssetImage(emp.image!.toString())),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Image(image: personImageCircular),
                SizedBox(
                  width: 4,
                ),
                Text(
                  emp.name.toString(),
                  style: TextStyle(
                    fontFamily: robotoFontFamily,
                    color: darkBlueColor,
                    fontWeight: bold_FontWeight,
                    fontSize: small_FontSize,
                  ),
                )
              ],
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Image(image: phoneImg,width: 12,height: 12,),
                    SizedBox(
                      width: 4,
                    ),
                    Text(emp.phone.toString(),
                        style: TextStyle(
                          fontFamily: robotoFontFamily,
                          fontSize: small_FontSize,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Image(image: mailImg,width: 12,height: 12,),
                    SizedBox(
                      width: 4,
                    ),
                    Text(emp.email.toString(),
                        style: TextStyle(
                          fontFamily: robotoFontFamily,
                          fontSize: small_FontSize,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Image(image: calenderImg,width: 12,height: 12,),
                    SizedBox(
                      width: 4,
                    ),
                    Text(emp.deputedDate.toString(),
                        style: TextStyle(
                          fontFamily: robotoFontFamily,
                          fontSize: small_FontSize,
                        ))
                  ],
                ),
              ),
            ],
          ),
          trailing: PopupMenuButton(
            shape: Border(
                left: BorderSide(
                  width: 2,
                  color: darkBlueColor,
                )),
            icon: Icon(Icons.more_vert),
            iconSize: 30,
            splashRadius: 5,
            padding: EdgeInsets.zero,
            itemBuilder: (context) => [
              PopupMenuItem(
                  child: TextButton(
                    child: Text(
                      "Attendence",
                      style: TextStyle(
                        color: blackColor,
                      ),
                    ),
                    onPressed: ()
                    {
                      Navigator.of(context).pop();
                      showFancyCustomDialog(context,emp);

                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

}
