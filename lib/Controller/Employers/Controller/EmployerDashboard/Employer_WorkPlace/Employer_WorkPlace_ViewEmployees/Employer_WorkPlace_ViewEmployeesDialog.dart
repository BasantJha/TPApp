import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../Constant/Constants.dart';
import 'Employer_WorkPlace_ViewEmployees.dart';



void showFancyCustomDialog(BuildContext context, dynamic emp)
{
  Dialog fancyDialog = Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      height: 100.0 + (emp.attendemce.length * 45),
      width: 300.0,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            // height: 100,
            // alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Image(
                      image: personImageCircular,
                      width: 15,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      emp.name.toString(),
                      style: TextStyle(
                        fontFamily: robotoFontFamily,
                        color: darkBlueColor,
                        fontWeight: bold_FontWeight,
                        fontSize: smallLess_FontSize,
                      ),
                    )
                  ],
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Image(
                      image: personImageSimple,
                      width: 15,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(emp.designation.toString(),
                        style: TextStyle(
                          fontFamily: robotoFontFamily,
                          fontSize: small_FontSize,
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                DataTable(
                  dataTextStyle: TextStyle(
                    color: blackColor,
                    fontSize: smallLess_FontSize,
                  ),
                  headingTextStyle: TextStyle(
                    color: blackColor,
                    fontSize: smallLess_FontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  columnSpacing: 13,
                  horizontalMargin: 5,
                  dataRowHeight: 40,
                  columns: [
                    tableCol("Month"),
                    tableCol('No.of Days'),
                    tableCol('Leave Taken'),
                    tableCol('Leave Balance')
                  ],
                  rows: emp.attendemce!.map<DataRow>((e) {
                    return DataRow(cells: [
                      dtcellM(e.month.toString()),
                      dtcell(e.no_of_days.toString()),
                      dtcell(e.leave_taken.toString()),
                      dtcell(e.leave_balance.toString()),
                    ]);
                  }).toList(),
                )
              ],
            ),
          ),
          Align(
            // These values are based on trial & error method
            alignment: Alignment(1.05, -1.05),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  showDialog(
      context: context, builder: (BuildContext context) => fancyDialog);
}
DataCell dtcell(String val) => DataCell(
  Center(
    child: Text(
      val,
      textAlign: TextAlign.center,
    ),
  ),
);
DataCell dtcellM(String val) => DataCell(
  Text(
    val,
  ),
);

DataColumn tableCol(String title) {
  return DataColumn(
      label: Expanded(child: Text(
        title,
        textAlign: TextAlign.center,
      ),));
}