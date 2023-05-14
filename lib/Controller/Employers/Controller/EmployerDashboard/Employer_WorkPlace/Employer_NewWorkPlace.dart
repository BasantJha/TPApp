import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


import '../../../../../Constant/ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import 'DummyDataModelClass/prime_contract_m.dart';

//const clockIMG = AssetImage("assets/images/workplace_clock.png");
//const personIMG = AssetImage("assets/images/workplace_person.png");

const clockIMG = AssetImage(JobSeeker_Icon_Clock);
const personIMG = AssetImage(Employer_Icon_WorkPlacePersonGrey);

const gClr = Color(0xffF4F4F4);

List<Prime_contracts_Model> prime = [
  Prime_contracts_Model(
    title: "Contract No. ORDER_JULY_2022",
    validFrom: "01/07/2022",
    validTo: "31/07/2022",
    employeeList: EmployeeList(
      active: "450",
      inactive: "50",
      total: "500",
    ),
    attendaceReport: AttendaceReport(
      date: "today",
      present: "400",
      absent: "100",
      total: "500",
    ),
    salaryDue: SalaryDue(
      month: "Oct'22",
      employees: "500",
      amount: "50,000",
    ),
  ),
  Prime_contracts_Model(
    title: "Contract No. ORDER_JUNE_2022",
    validFrom: "01/06/2022",
    validTo: "31/06/2022",
    employeeList: EmployeeList(
      active: "400",
      inactive: "300",
      total: "700",
    ),
    attendaceReport: AttendaceReport(
      date: "today",
      present: "500",
      absent: "100",
      total: "600",
    ),
    salaryDue: SalaryDue(
      month: "Aug'22",
      employees: "500",
      amount: "1,00,000",
    ),
  ),
];

class Employer_NewWorkPlace extends StatefulWidget {
  const Employer_NewWorkPlace({super.key});

  @override
  State<Employer_NewWorkPlace> createState() => _Employer_NewWorkPlace();
}

class _Employer_NewWorkPlace extends State<Employer_NewWorkPlace> {
  bool isborder = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 65,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 12, 0, 12),
            child: ElevatedButton(
              onPressed: () {
                // Navigator.pushNamedAndRemoveUntil(
                //     context, '/home', (route) => true);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: darkGreyColor,
                  minimumSize: Size.zero,
                  padding: EdgeInsets.all(-12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                  maximumSize: Size.zero),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                size: 25,
                color: Colors.black,
              ),
            ),
          ),
          title: Text(
            "WorkPlace 2",
            style: TextStyle(
              color: Colors.black,
              fontSize: appBarTitleFontWeight,
              fontFamily: viewHeadingFontfamily,
              fontWeight: FontWeight.bold,
            ),
          ),
          // centerTitle: true,
          bottom: PreferredSize(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: darkGreyColor,
                      )),
                  child: TabBar(
                    isScrollable: true,
                    labelStyle: TextStyle(
                      fontFamily: viewHeadingFontfamily,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Color(0xff434343),
                    indicator: BoxDecoration(
                      color: /*ElevatedButtonBgColor*/darkBlueColor,
                    ),
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: workplace_tab("Prime Contracts"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: workplace_tab("My Beneficiaries"),
                      )
                    ],
                  ),
                ),
              ),
              preferredSize: Size.fromHeight(80.0)),
        ),

        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView.builder(
                // scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                itemCount: prime.length,
                itemBuilder: (context, index)
                {
                  Prime_contracts_Model pr = prime[index];
                  return PrimeCnrcts(
                      pr.title.toString(),
                      pr.validFrom.toString(),
                      pr.validTo.toString(),
                      pr.employeeList!.active.toString(),
                      pr.employeeList!.inactive.toString(),
                      pr.employeeList!.total.toString(),
                      pr.attendaceReport!.present.toString(),
                      pr.attendaceReport!.absent.toString(),
                      pr.attendaceReport!.total.toString(),
                      pr.attendaceReport!.date.toString(),
                      pr.salaryDue!.month.toString(),
                      pr.salaryDue!.employees.toString(),
                      pr.salaryDue!.amount.toString());
                },
              ),
            ),
            Text("hello benificiery"),
          ],
        ),
      ),
    );
  }

  Tab workplace_tab(String title) {
    return Tab(
      height: 40,
      text: title,
    );
  }

  PopupMenuItem<int> menuitem(int val, String label) {
    return PopupMenuItem(
      height: 0,
      value: val,
      child: Container(
        height: 30,
        child: TextButton(
          child: Text(
            label,
            style: TextStyle(
              color: blackColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => page,
            //     ));
          },
        ),
      ),
    );
  }

  Padding Emplist(String active, String inactive, String total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10)),
        color: Color(0xffE4EEF4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            // shape: RoundedRectangleBorder(
            //     side: BorderSide(color: Colors.black),
            //     borderRadius: BorderRadius.circular(10)),
            title: Text(
              'Employees List',
              style: TextStyle(
                  color: Color(0xff24748E),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Active',
                        style: TextStyle(
                          color: Color(0xff578D40),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        active,
                        style: TextStyle(
                          color: Color(0xff24748E),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Inactive',
                        style: TextStyle(
                          color: Color(0xff578D40),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        inactive,
                        style: TextStyle(
                          color: Color(0xff24748E),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        total,
                        style: TextStyle(
                          color: Color(0xff24748E),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding AttendenceReport(
      String date, String present, String absent, String total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10)),
        color: Color(0xffE4EEF4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            // shape: RoundedRectangleBorder(
            //     side: BorderSide(color: Colors.black),
            //     borderRadius: BorderRadius.circular(10)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Attendence Report',
                  style: TextStyle(
                      color: Color(0xff24748E),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  date,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Present',
                        style: TextStyle(
                          color: Color(0xff578D40),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        present,
                        style: TextStyle(
                          color: Color(0xff24748E),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Absent',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        absent,
                        style: TextStyle(
                          color: Color(0xff24748E),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        total,
                        style: TextStyle(
                          color: Color(0xff24748E),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding SalaryDue(String month, String employees, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10)),
        color: Color(0xffE4EEF4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            // shape: RoundedRectangleBorder(
            //     side: BorderSide(color: Colors.black),
            //     borderRadius: BorderRadius.circular(10)),
            title: Text(
              "Salary Due ($month)",
              style: TextStyle(
                  color: Color(0xff24748E),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Employees',
                        style: TextStyle(
                          color: Color(0xff578D40),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        employees,
                        style: TextStyle(
                          color: Color(0xff24748E),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        amount,
                        style: TextStyle(
                          color: Color(0xff24748E),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding PrimeCnrcts(
      String title,
      String validF,
      String validT,
      String empl_active,
      String empl_inactive,
      String empl_total,
      String atr_present,
      String atr_absent,
      String atr_total,
      String atr_date,
      String sld_month,
      String sld_employees,
      String sld_amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        //height: 100,
        // decoration: BoxDecoration(
        //   border: Border(left: BorderSide(color: Colors.grey, width: 2)),
        // ),
        child: Card(
          shape: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 4,
                color: (isborder) ? Colors.white : darkBlueColor,
              )),
          // color: tileColor(ind),
          color: whiteColor,
          margin: EdgeInsets.zero,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: ExpansionTile(
              trailing: PopupMenuButton(
                shape: Border(
                    left: BorderSide(
                      width: 2,
                      color: darkBlueColor,
                    )),
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                iconSize: 30,
                splashRadius: 5,
                padding: EdgeInsets.zero,
                // itemBuilder: (context) => [],
                itemBuilder: (context) => [
                  menuitem(
                    1,
                    "View Employees",
                  ),
                  menuitem(
                    2,
                    "Mark Attendance",
                  ),
                  menuitem(
                    3,
                    "Upload Attendance",
                  ),
                  menuitem(
                    3,
                    "Salary Disbursment Status",
                  ),
                  menuitem(
                    3,
                    "Report",
                  )
                ],
                offset: Offset(0, 65),
              ),
              leading: Image(
                image: AssetImage(Employer_Icon_WorkPlacePrimeContracts),
              ),
              title: Text(
                title,
                style: TextStyle(
                  fontFamily: robotoFontFamily,
                  color: darkBlueColor,
                  fontWeight: bold_FontWeight,
                  fontSize: medium_FontSize,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      ImageIcon(
                        clockIMG,
                        color: Colors.black,
                      ),
                      Text("Valid From $validF",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: robotoFontFamily,
                            fontSize: small_FontSize,
                          ))
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      ImageIcon(
                        clockIMG,
                        color: Colors.black,
                      ),
                      Text("Valid To $validT",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: robotoFontFamily,
                            fontSize: small_FontSize,
                          ))
                    ],
                  ),
                ],
              ),
              children: [
                Divider(
                  height: 4,
                  thickness: 4,
                  color: darkBlueColor,
                ),
                Emplist(empl_active, empl_inactive, empl_total),
                AttendenceReport(atr_date, atr_present, atr_absent, atr_total),
                SalaryDue(sld_month, sld_employees, sld_amount),
              ],
              onExpansionChanged: (value) {
                setState(() {
                  isborder = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
