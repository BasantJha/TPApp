import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_WorkPlace/Employer_WorkPlace_MarkAttendance/Employer_WorkPlace_MarkAttendanceCalendar.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_WorkPlace/Employer_WorkPlace_ViewEmployees/Employer_WorkPlace_ViewEmployees.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

const searchImg = AssetImage(search_Icon);
const personImage = AssetImage(Employer_Icon_ProfileGrey);

class Employer_WorkPlace_MarkAttendanceList extends StatefulWidget {
  final List? wrk_emps;
  final String? title;
  const Employer_WorkPlace_MarkAttendanceList({super.key, this.wrk_emps, this.title});

  @override
  State<Employer_WorkPlace_MarkAttendanceList> createState() => _Employer_WorkPlace_MarkAttendanceList();
}

class _Employer_WorkPlace_MarkAttendanceList extends State<Employer_WorkPlace_MarkAttendanceList> {
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
          appBar:CJAppBar(getEmployer_WorkPlace_MarkAttendance, appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show the action type");
            Navigator.pop(context);
          })),
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
              // "hello",
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
                  child: emp_card(emp,index+1),
                );
              },
            ),
          )
        ],
      ),
    );
  }
  Color? tileColor(ind) {
    if (ind % 2 != 0) {
      return Color(0xffF4F4F4);
    }
    if (ind % 2 == 0) {
      return Color(0xffFFEFEF);
    }
    if (ind % 3 == 0) {
      return Color(0xffE7F2F8);
    }
  }
  Card emp_card(emp,ind) {
    return Card(
      shape: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: darkBlueColor,
        ),
      ),
      color: tileColor(ind),
      margin: EdgeInsets.zero,
      elevation: 4,
      child: Column(
        children: [
          SizedBox(height: 20,),
          SizedBox(
            height: 45,
            child: ListTile(
              tileColor: tileColor(ind),
              leading: Image(image: AssetImage(emp.image!.toString())),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Image(image: personImage),
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
            ),
          ),
          SizedBox(
            height: 25,
            child: Align(
              heightFactor: 0,
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 25), //////// HERE
                ),
                onPressed: ()
                {


                  TalentNavigation().pushTo(context, Employer_WorkPlace_MarkAttendanceCalendar(
                    image: emp.image!.toString(),
                    name: emp.name.toString(),
                  ));

                },
                child: Text(
                  "Mark Attendence",
                  style:
                  TextStyle(fontSize: smallLess_FontSize),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
