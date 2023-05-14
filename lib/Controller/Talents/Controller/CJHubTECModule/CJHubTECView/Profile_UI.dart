import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile_UI
{
  // ignore: non_constant_identifier_names
  static Container create_KeyContainer(String imgName,String key)
  {
    return  Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20,10,20,0),
        child: Row(
          children: [
            new Image.asset(
              imgName,
              height: 15.0,
              width: 15.0,
            ),
            // Icon(Icons.person_outline,color: Colors.black,size: 15,),
            SizedBox(
              width: 5.0,
            ),
            Text(key,style: TextStyle(fontFamily:'Vonique',fontSize: 13,color: Color(0xff00BFFF) )),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static Container create_ValueContainer(String value)
  {
    return  Container(
      child: Padding(
        padding: const EdgeInsets.only(left:40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            SizedBox(
              height: 1.0,
            ),
            new Text(value,
                style: TextStyle(fontSize: 14,color: Colors.black)),
          ],
        ),
      ),
    );
  }

}