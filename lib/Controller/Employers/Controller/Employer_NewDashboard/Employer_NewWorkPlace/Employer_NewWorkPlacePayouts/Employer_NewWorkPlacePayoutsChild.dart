

import 'package:flutter/cupertino.dart';

import '../../../../../../Constant/ConstantIcon.dart';
import '../../../../../../Constant/Constants.dart';
import '../Employer_NewWorkPlaceEmployees/Employer_NewWorkPlaceEmployeeChild.dart';

var getWorkPlacePayoutList=[
  {
    "CalenderImage": Employer_Icon_BlueCalendarIcon,
    "rupayicon": rupees_Gray_Icon,
    "Month": "OCT",
    "Amount": "50,000",
    "Workers": "4",
    "PayoutDate": "7'Sep",
    "Status": "Pending",
  },
  {
    "CalenderImage": Employer_Icon_BlueCalendarIcon,
    "rupayicon": rupees_Gray_Icon,
    "Month": "Sep",
    "Amount": "50,000",
    "Workers": "4",
    "PayoutDate": "7'Sep",
    "Status": "Completed",
  },
  {
    "CalenderImage": Employer_Icon_BlueCalendarIcon,
    "rupayicon": rupees_Gray_Icon,
    "Month": "Sep",
    "Amount": "50,000",
    "Workers": "4",
    "PayoutDate": "7'Sep",
    "Status": "Partial",
  }

];

var getWorkPlacePayoutListStatus=[
  {
    "Image": Employer_Icon_SelectEmployeeListIcon,
    "name": "Shukhdeep Singh",
    "paydays": "20",
    "amount": "15,000",
    "salaryStatus": "Approved",
  },
  {
    "Image": Employer_Icon_SelectEmployeeListIcon,
    "name": "Mandeep Kumar",
    "paydays": "20",
    "amount": "15,000",
    "salaryStatus": " Hold",
  }
];

Row payoutList(label,Value)
{
  return Row(
    children: [
      Text(
        label,
        style: textStyle_GREY(),
      ),
      SizedBox(
        width: 2,
      ),
      Text(
        Value,
        style: textStyle_BLACK(),
      ),
    ],
  );
}
Row payoutListOrange(label,Value)
{
  return Row(
    children: [
      Text(
        label,
        style: textStyle_GREY(),
      ),
      SizedBox(
        width: 2,
      ),
      Text(
        Value,
        style: textStyle_Orange(),
      ),
    ],
  );
}


var getContainerBoxDecoration=BoxDecoration(
    color: whiteColor,
    border: Border(
        top: BorderSide(color: lightGreyColor, width: 2),
        left: BorderSide(color: lightGreyColor, width: 2),
        right: BorderSide(color: lightGreyColor, width: 2),
        bottom: BorderSide(
          width: 3,
          color: darkBlueColor,
        )));
