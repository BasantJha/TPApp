import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/ModelClass/All_employers.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/ModelClass/employersM.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/Messages/Talent_TextMessages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


class Talent_Employer extends StatefulWidget
{
  const Talent_Employer({super.key});

  @override
  State<Talent_Employer> createState() => _Talent_Employer();
}

class _Talent_Employer extends State<Talent_Employer> {

  var talentEmployeeList = getTalentEmployeeList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //

  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(appBar:CJAppBarWithRightIcon(getTalent_EmployersTitle, context,appBarBlock: AppBarBlock(appBarAction: ()
    {
      print("show the action type");
      Navigator.pop(context);
    })) ,
      body: ListView(
        children: talentEmployeeList.map(emptile).toList(),
      ),

    );

  }

  Widget emptile(All_Emps all_emps)
  {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              all_emps.category.toString(),
              style: TextStyle(
                color: darkBlueColor,
                fontSize: 20,
              ),
            ),
          ),
          Column(
            children: all_emps.emplys!.map((emp)
            {

              return emp_tile(emp.initials!, emp.name!, emp.email!, emp.phone!,
                  all_emps.emplys!.indexOf(emp),all_emps.category.toString());

            }).toList(),
          )
        ],
      ),
    );
  }

  Color? tilecolor(int index) {
    return (index % 2 == 0) ? Colors.grey[300] : Colors.white;
  }

  Color? initialsclr(int index) {
    return (index == 0)
        ? Colors.orange
        : (index % 2 == 0)
        ? Colors.blue
        : (index % 3 == 0)
        ? Colors.pink
        : (index % 5 == 0)
        ? Colors.blue
        : Colors.green;
  }

  ListTile emp_tile(
      String initials, String name, String email, String phone, int index,String categoryName)
  {
    bool visibilityStatus=false;
    print("show the status $initials");
    if(categoryName=="Prime Employers")
      {
        setState(() {
          visibilityStatus=false;
        });
      }else
        {
          setState(() {
            visibilityStatus=true;
          });
        }
    return ListTile(
      tileColor: tilecolor(index),
      leading: CircleAvatar(
        backgroundColor: initialsclr(index),
        child: Text(
          initials,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      title: Text(name,style: TextStyle(color: darkBlueColor,fontWeight: semiBold_FontWeight,fontSize: 12),),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(visible: visibilityStatus,
            child:Text(email,style: TextStyle(color: blackColor,fontWeight: FontWeight.normal,fontSize: 10)) ,),
          Text(phone,style: TextStyle(color: blackColor,fontWeight: FontWeight.normal,fontSize: 10)),
        ],
      ),
      // trailing: IconButton(
      //   icon: Icon(Icons.more_vert),
      //   onPressed: () {},
      // ),
      trailing: PopupMenuButton(
        itemBuilder: (context) => [
          menuitem(1, "Edit Employer"),
          menuitem(2, "Raise Bill"),
          menuitem(3, "Payment History")
        ],
        offset: Offset(0, 52),
      ),
    );
  }

  PopupMenuItem<int> menuitem(int val, String label) {
    return PopupMenuItem(
      value: val,
      child: Text(label),
    );
  }
}
