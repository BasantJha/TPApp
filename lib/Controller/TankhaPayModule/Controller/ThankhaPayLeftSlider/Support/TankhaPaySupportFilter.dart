

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../Constant/Constants.dart';

class TankhaPaySupportFilter extends StatefulWidget
{
  final ValueChanged<int> onChanged;
  int selectedStatusRadioButton;

  TankhaPaySupportFilter({Key? key,required this.selectedStatusRadioButton ,required this.onChanged}) : super(key: key);

  @override
  _TankhaPaySupportFilter createState() => _TankhaPaySupportFilter();
}

class _TankhaPaySupportFilter extends State<TankhaPaySupportFilter>
{
  String _value="";
  int filterRadioValue=0;

  TextStyle title_datePresets = TextStyle(fontSize: 15,color: Colors.black);

  @override
  Widget build(BuildContext context)
  {
    filterRadioValue=widget.selectedStatusRadioButton;
    print("show the default value $filterRadioValue");

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
                          child: Text("Filter by status",textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),),
                        ),
                      )),


                  MaterialButton(
                    onPressed:()
                    {
                      Navigator.of(context).pop();

                    },

                    child: Icon(Icons.close,color: Colors.grey,size: 30,),
                  ),


                ],
              )

          ),

          // List listFilterPresets=["All","Pending","Open","Accepted","Completed","Paid","Rejected"];

// All-0
          Container(
            padding: EdgeInsets.only(left:20,right: 20),
            child:  ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('All',style: title_datePresets,),
              trailing: new Radio(
                value: 0,
                groupValue: filterRadioValue,
                activeColor: primaryColor,
                onChanged: (value)
                {

                  setState(() {
                    filterRadioValue = value!;
                  });

                  print("show the selected value new type:: $value");

                  widget.onChanged(filterRadioValue);

                },),
            ),
          ),

//Open-1
          Container(
            padding: EdgeInsets.only(left:20,right: 20),
            child:  ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('Open',style: title_datePresets,),
              trailing: new Radio(
                value: 1,
                groupValue: filterRadioValue,
                activeColor: primaryColor,
                onChanged: (value)
                {

                  setState(() {
                    filterRadioValue = value!;
                  });

                  print("show the selected value new type:: $value");

                  widget.onChanged(filterRadioValue);

                },),
            ),
          ),

          //close

          Container(
            padding: EdgeInsets.only(left:20,right: 20),
            child:  ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('Closed',style: title_datePresets,),
              trailing: new Radio(
                value: 2,
                groupValue: filterRadioValue,
                activeColor: primaryColor,
                onChanged: (value)
                {

                  setState(() {
                    filterRadioValue = value!;
                  });

                  print("show the selected value new type:: $value");

                  widget.onChanged(filterRadioValue);

                },),
            ),
          ),



        ],
      ),
    );

  }
}



