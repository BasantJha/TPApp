import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../Constant/CJAppFlowConstants.dart';

class Employer_PayoutFilter extends StatefulWidget
{

  const Employer_PayoutFilter({Key? key,this.selectedDatePresetRadioButton ,this.onChanged}) : super(key: key);

  final ValueChanged<int>? onChanged;
  final int? selectedDatePresetRadioButton;

  @override
  State<Employer_PayoutFilter> createState() => _Employer_PayoutFilter();

}

class _Employer_PayoutFilter extends State<Employer_PayoutFilter>
{
  String? _value;
  int dateRadioValue = 0;


  TextStyle titleTextStyle = TextStyle(fontSize: 15,color: blackColor,fontFamily: robotoFontFamily);

  @override
  Widget build(BuildContext context)
  {

    dateRadioValue=widget.selectedDatePresetRadioButton!;


    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          Container(
              padding: EdgeInsets.only(left:10,top: 10),
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.72,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Filter By Status",textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),),
                        ),
                      )
                  ),


                  MaterialButton
                    (
                    onPressed:()
                    {
                      Navigator.of(context).pop();
                    },

                    child: Icon(Icons.close,color: Colors.grey,size: 30,),
                  ),


                ],
              )

          ),


         /*----All---*/
          Container(
            padding: EdgeInsets.only(left:20,right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text(filterTitle_All,style: titleTextStyle,),
              trailing: new Radio(
                value: filterStatus_All,
                groupValue: dateRadioValue,
                activeColor: primaryColor,
                onChanged: (value) {
                  setState(() {
                    dateRadioValue = value!;
                  });
                  print("show the selected value today:: $value");
                  widget.onChanged!(value!);
                },
              ),
            ),
          ),

          /*----Auto---*/
          Container(
            padding: EdgeInsets.only(left:20,right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text(filterTitle_Auto,style: titleTextStyle,),
              trailing: new Radio(
                value: filterStatus_Auto,
                groupValue: dateRadioValue,
                activeColor: primaryColor,
                onChanged: (value)
                {
                  setState(()
                  {
                    dateRadioValue = value!;
                  });
                  print("show the selected value yesterday:: $value");
                  widget.onChanged!(value!);
                },
              ),
            ),
          ),

          /*----Completed---*/
          Container(
            padding: EdgeInsets.only(left:20,right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text(filterTitle_Completed,style: titleTextStyle,),
              trailing: new Radio(
                value: filterStatus_Completed,
                groupValue: dateRadioValue,
                activeColor: primaryColor,
                onChanged: (value)
                {
                  setState(()
                  {
                    dateRadioValue = value!;
                  });
                  print("show the selected value yesterday:: $value");
                  widget.onChanged!(value!);
                },
              ),
            ),
          ),

          /*----PartiallyCompleted---*/
          Container(
            padding: EdgeInsets.only(left:20,right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text(filterTitle_PartiallyCompleted,style: titleTextStyle,),
              trailing: new Radio(
                value: filterStatus_PartiallyCompleted,
                groupValue: dateRadioValue,
                activeColor: primaryColor,
                onChanged: (value)
                {
                  setState(()
                  {
                    dateRadioValue = value!;
                  });
                  print("show the selected value yesterday:: $value");
                  widget.onChanged!(value!);
                },
              ),
            ),
          ),

          /*----Pending---*/
          Container(
            padding: EdgeInsets.only(left:20,right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text(filterTitle_Pending,style: titleTextStyle,),
              trailing: new Radio(
                value: filterStatus_Pending,
                groupValue: dateRadioValue,
                activeColor: primaryColor,
                onChanged: (value)
                {
                  setState(()
                  {
                    dateRadioValue = value!;
                  });
                  print("show the selected value yesterday:: $value");
                  widget.onChanged!(value!);
                },
              ),
            ),
          ),

          /*----PartiallyPending---*/
          Container(
            padding: EdgeInsets.only(left:20,right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text(filterTitle_PartiallyPending,style: titleTextStyle,),
              trailing: new Radio(
                value: filterStatus_PartiallyPending,
                groupValue: dateRadioValue,
                activeColor: primaryColor,
                onChanged: (value)
                {
                  setState(()
                  {
                    dateRadioValue = value!;
                  });
                  print("show the selected value yesterday:: $value");
                  widget.onChanged!(value!);
                },
              ),
            ),
          ),


        ],
      ),
    );

  }

}
