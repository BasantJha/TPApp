import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_WorkPlace/Employer_WorkPlace_MarkAttendance/Employer_WorkPlace_MarkAttendanceList.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_WorkPlace/Employer_WorkPlace_UploadAttendance/Employer_WorkPlace_UploadAttendance.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_WorkPlace/Employer_WorkPlace_ViewEmployees/Employer_WorkPlace_ViewEmployees.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_WorkPlace/ModelDataClass/All_Contracts.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_WorkPlace/ModelDataClass/Emp_Attendence.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_WorkPlace/ModelDataClass/cnrt_employees.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_WorkPlace/ModelDataClass/contracts.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

/*
const clockIMG = AssetImage("assets/images/workplace_clock.png");
const personIMG = AssetImage("assets/images/workplace_person.png");
*/

const clockIMG = AssetImage(JobSeeker_Icon_Clock);
const personIMG = AssetImage(Employer_Icon_WorkPlacePersonGrey);

const gClr = Color(0xffF4F4F4);

class Employer_WorkPlace extends StatefulWidget {
  const Employer_WorkPlace({super.key});

  @override
  State<Employer_WorkPlace> createState() => _Employer_WorkPlace();
}

class _Employer_WorkPlace extends State<Employer_WorkPlace>
{
  var contrtslist = [
    AllContracts(
      category: "Prime Contracts",
      cnrts: [
        Contracts(
            leadImg: Employer_Icon_WorkPlacePrimeContracts,
            title: "Contract No. ORDER_JULY_2022",
            validFrom: "01/07/2022",
            validTo: "31/07/2022",
            CNT_EMP: [
              contract_Employees(
                  image: Talent_Icon_profileDrawer,
                  name: "Sukhdeep Singh (CJA0200000001)",
                  designation: "web Developer",
                  phone: "9876564543",
                  email: "sukhdeep@gmail.com",
                  deputedDate: "Deputed Date: 12-04-22",
                  attendemce: <Emp_Attendence>[
                    Emp_Attendence(
                      month: "January’22",
                      no_of_days: "31",
                      leave_taken: "0",
                      leave_balance: "1",
                    ),
                    Emp_Attendence(
                      month: "February’22",
                      no_of_days: "31",
                      leave_taken: "0",
                      leave_balance: "1",
                    ),
                    Emp_Attendence(
                      month: "March’22",
                      no_of_days: "31",
                      leave_taken: "0",
                      leave_balance: "1",
                    ),
                    Emp_Attendence(
                      month: "April’22",
                      no_of_days: "31",
                      leave_taken: "0",
                      leave_balance: "1",
                    ),
                    Emp_Attendence(
                      month: "May’22",
                      no_of_days: "31",
                      leave_taken: "0",
                      leave_balance: "1",
                    ),
                    Emp_Attendence(
                      month: "June’22",
                      no_of_days: "31",
                      leave_taken: "0",
                      leave_balance: "1",
                    ),
                    Emp_Attendence(
                      month: "July’22",
                      no_of_days: "31",
                      leave_taken: "0",
                      leave_balance: "1",
                    ),
                  ]),
              contract_Employees(
                  image: Talent_Icon_profileDrawer,
                  name: "Amit Kumar (CJA0200000001)",
                  designation: "frontend Developer",
                  phone: "9876564543",
                  email: "sukhdeep@gmail.com",
                  deputedDate: "Deputed Date: 12-04-22"),
              contract_Employees(
                  image: Talent_Icon_profileDrawer,
                  name: "Sunil Yadav (CJA0200000001)",
                  designation: "backend Developer",
                  phone: "9876564543",
                  email: "sukhdeep@gmail.com",
                  deputedDate: "Deputed Date: 12-04-22"),
              contract_Employees(
                  image: Talent_Icon_profileDrawer,
                  name: "Rajesh Khana (CJA0200000001)",
                  designation: "software Developer",
                  phone: "9876564543",
                  email: "sukhdeep@gmail.com",
                  deputedDate: "Deputed Date: 12-04-22"),
            ])
      ],
    ),
    AllContracts(
      category: "Other Contracts",
      cnrts: [
        Contracts(
          leadImg: Talent_Icon_profileDrawer,
          title: "Contract No. ORDER_JULY_2022",
          name: "Kamla Devi",
          validFrom: "31/07/2022",
          validTo: "Perpetual",
        ),
        Contracts(
          leadImg: Talent_Icon_profileDrawer,
          title: "Contract No. ORDER_JULY_2022",
          name: "Kamla Devi",
          validFrom: "31/07/2022",
          validTo: "Perpetual",
        ),
      ],
    )
  ];

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar:CJAppBar(getEmployer_WorkPlace, appBarBlock: AppBarBlock(appBarAction: ()
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

  ListView MainfunctionUi()
  {
    return ListView.builder(
      itemCount: contrtslist.length,
      itemBuilder: (context, index)
      {
        final cnrt = contrtslist[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cnrt.category.toString(),
                style: TextStyle(
                  color: darkBlueColor,
                  fontSize: large_FontSize,
                ),
              ),
              Column(
                children: cnrt.cnrts!.map((cnt) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: wrk_emp_card(cnt, cnrt, cnrt.cnrts!.indexOf(cnt) + 1),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
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
  Card wrk_emp_card(Contracts cnt, AllContracts cnrt,ind) {
    return Card(
      shape: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: darkBlueColor,
          )),
      //color: gClr,
      color: tileColor(ind),

      margin: EdgeInsets.zero,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        child: ListTile(
         // tileColor: gClr,
          tileColor: tileColor(ind),

          leading: Image(
            image: AssetImage(cnt.leadImg.toString()),
          ),
          title: Padding(padding: EdgeInsets.only(left: 5),child:  Text(
            cnt.title.toString(),
            style: TextStyle(
              fontFamily: robotoFontFamily,
              color: darkBlueColor,
              fontWeight: bold_FontWeight,
              fontSize: small_FontSize,
            ),
          ),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (cnt.name != null)
                  ? Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ImageIcon(personIMG),
                  Text(
                    cnt.name!.toString(),
                    style: TextStyle(
                      fontFamily: robotoFontFamily,
                      fontSize: small_FontSize,
                    ),
                  ),
                ],
              )
                  : SizedBox(),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ImageIcon(clockIMG),
                  Text("Valid From ${cnt.validFrom.toString()}",
                      style: TextStyle(
                        fontFamily: robotoFontFamily,
                        fontSize: small_FontSize,
                      ))
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ImageIcon(clockIMG),
                  Text("Valid To ${cnt.validTo.toString()}",
                      style: TextStyle(
                        fontFamily: robotoFontFamily,
                        fontSize: small_FontSize,
                      ))
                ],
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
            itemBuilder: (context) =>
            (cnrt.category!.toLowerCase().contains("prime"))
                ? [
              menuitem(
                  1,
                  "View Employees",
                  Employer_WorkPlace_ViewEmployees(
                    wrk_emps: cnt.CNT_EMP,
                    title: cnt.title.toString(),
                  )),
              menuitem(
                  2,
                  "Mark Attendance",
                  Employer_WorkPlace_MarkAttendanceList(
                    wrk_emps: cnt.CNT_EMP,
                    title: cnt.title.toString(),
                  )),
              menuitem(3, "Upload Attendance", Employer_WorkPlace_UploadAttendance(
                title: cnt.title.toString(),))
            ]
                : [
              menuitem(1, "Make Payment", Text("payment")),
              menuitem(2, "View History", Text("history")),
            ],
            offset: Offset(0, 52),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<int> menuitem(int val, String label, Widget page) {
    return PopupMenuItem(
      height: 30,
      value: val,
      child: TextButton(
        child: Text(
          label,
          style: TextStyle(
            color: blackColor,
          ),
        ),
        onPressed: ()
        {
          Navigator.of(context).pop();
          TalentNavigation().pushTo(context, page);

        },
      ),
    );
  }


}
