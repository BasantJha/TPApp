


import '../../Controller/Talents/ModelClasses/CJHubModelClasses/SalaryStatus_ModelResponse.dart';
import 'Method.dart';

class SalaryYearMonth_List
{

  static List<String> loadLiveData(SalaryStatus_ModelResponse checkSalaryStatusModelData)
  {

    List<String> heads_stringList = [];

    int mpr_year_Int = int.parse(checkSalaryStatusModelData.data?.mprYear);
    int mpr_month_Int = int.parse(checkSalaryStatusModelData.data?.mprMonth);
    int currentYear = int.parse(Method.getCurrentYear());


    int totalItemDisplayIn_Dropdown=0;
    /*--------------8-11-2021 start-----------------*/
    String getSalaryMonth_Str=checkSalaryStatusModelData.data?.salaryMonths;

    int getSalaryMonth_Int=int.parse(getSalaryMonth_Str);


    if (getSalaryMonth_Int==0)
    {
      /*-----------29-11-2022 start------------*/
      //totalItemDisplayIn_Dropdown=3;

      totalItemDisplayIn_Dropdown=0;
      return heads_stringList;

      /*-----------29-11-2022 end------------*/

    }
    else
    {
      totalItemDisplayIn_Dropdown=getSalaryMonth_Int;
    }

    /*--------------8-11-2021 end-----------------*/

    if (mpr_year_Int >= 2021)
    {
      int i = 0;

      if (mpr_year_Int == 2021)
      {
        while (mpr_month_Int >= 4) {
          String monthName_Str = FindMonthName_ByNumber(
              mpr_month_Int.toString());
          String completeName = monthName_Str + " " +
              checkSalaryStatusModelData.data?.mprYear;
          heads_stringList.add(completeName);


          if (heads_stringList.length == totalItemDisplayIn_Dropdown) {
            break;
          }
          --mpr_month_Int;
        }
      }
      else
      {
        /*--------2-6-2021 use for all yearstart-------*/
        /*if (mpr_year_Int == currentYear)
        {*/
          if (mpr_year_Int > 2021)
          {
            while (mpr_month_Int >= 1)
            {
              String monthName_Str = FindMonthName_ByNumber(
                  mpr_month_Int.toString());
              String completeName = monthName_Str + " " +
                  checkSalaryStatusModelData.data?.mprYear;
              heads_stringList.add(completeName);

              if (heads_stringList.length == totalItemDisplayIn_Dropdown)
              {
                break;
              }
              --mpr_month_Int;
            }

            /*---------------18-4-2022 start new code implement for totalItemDisplayIn_Dropdown-----------------------*/

            if (heads_stringList.length != totalItemDisplayIn_Dropdown)
            {
              // //print('logic split here');

              --mpr_year_Int;
              mpr_month_Int = 12;


              while (mpr_month_Int >= 1) {
                String monthName_Str = FindMonthName_ByNumber(
                    mpr_month_Int.toString());
                String completeName = monthName_Str + " " +
                    mpr_year_Int.toString();
                heads_stringList.add(completeName);

                if (heads_stringList.length == totalItemDisplayIn_Dropdown) {
                  break;
                }
                --mpr_month_Int;
              }

            }
            /*---------------18-4-2022 end-----------------------*/




            /*if (heads_stringList.length == 1)
            {
              --mpr_year_Int;
              mpr_month_Int = 12;

              while (mpr_month_Int >= 1) {
                String monthName_Str = FindMonthName_ByNumber(
                    mpr_month_Int.toString());
                String completeName = monthName_Str + " " +
                    mpr_year_Int.toString();
                heads_stringList.add(completeName);

                if (heads_stringList.length == totalItemDisplayIn_Dropdown) {
                  break;
                }
                --mpr_month_Int;
              }
            }


            if (heads_stringList.length == 2)
            {
              --mpr_year_Int;
              mpr_month_Int = 12;


              while (mpr_month_Int >= 1) {
                String monthName_Str = FindMonthName_ByNumber(
                    mpr_month_Int.toString());
                String completeName = monthName_Str + " " +
                    mpr_year_Int.toString();
                heads_stringList.add(completeName);

                if (heads_stringList.length == totalItemDisplayIn_Dropdown) {
                  break;
                }
                --mpr_month_Int;
              }
            }*/



          }
        //}
        /*--------2-6-2021 end-------*/

      }
    }

    return heads_stringList;
  }

  static String FindMonthName_ByNumber (String monthName)
  {

    String monthNum = "";

    if (monthName=="1") {
      monthNum = "January";

    } else if (monthName=="2") {
      monthNum = "February";

    } else if (monthName=="3") {
      monthNum = "March";

    } else if (monthName=="4") {
      monthNum = "April";

    } else if (monthName=="5") {
      monthNum = "May";

    } else if (monthName=="6") {
      monthNum = "June";

    } else if (monthName=="7") {
      monthNum = "July";

    } else if (monthName=="8") {
      monthNum = "August";

    } else if (monthName=="9") {
      monthNum = "September";

    } else if (monthName=="10") {
      monthNum = "October";

    } else if (monthName=="11") {
      monthNum = "November";

    } else if (monthName=="12") {
      monthNum = "December";

    } else {

    }
    return monthNum;
  }

  static String FindMonthNumber_ByMonthName (String monthName){

    String monthNum = "";

    if (monthName=="January") {
      monthNum = "1";

    } else if (monthName=="February") {
      monthNum = "2";

    } else if (monthName=="March") {
      monthNum = "3";

    } else if (monthName=="April") {
      monthNum = "4";

    } else if (monthName=="May") {
      monthNum = "5";

    } else if (monthName=="June") {
      monthNum = "6";

    } else if (monthName=="July") {
      monthNum = "7";

    } else if (monthName=="August") {
      monthNum = "8";

    } else if (monthName=="September") {
      monthNum = "9";

    } else if (monthName=="October") {
      monthNum = "10";

    } else if (monthName=="November") {
      monthNum = "11";

    } else if (monthName=="December") {
      monthNum = "12";

    } else {

    }
    return monthNum;
  }
}