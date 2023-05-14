import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../Constant/ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';

class Employer_Contact_Card extends StatefulWidget {
  const Employer_Contact_Card({super.key, required this.supportNo});
  final String supportNo;

  @override
  State<Employer_Contact_Card> createState() => _Employer_Contact_Card();
}

class _Employer_Contact_Card extends State<Employer_Contact_Card> {
  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.only(top:10),
      child: ListTile(
        /*title: Transform.scale(
          scale: 0.45,
          child: Image.asset(Employer_Icon_TankhaPayDrawerBanner,
          ),
        ),*/
        title: Text("For any question or queries, you\nmay contact us at",textAlign: TextAlign.center,style: TextStyle(color: darkGreyColor,fontSize: 12),),

        subtitle: InkWell(
          onTap: () async {
            final call = Uri.parse("tel:+91 ${widget.supportNo}");

            if (await canLaunchUrl(call)) {
              launchUrl(call);
            } else {
              throw "could not launch $call";
            }

          },
          child: Container(padding: EdgeInsets.only(top: 10),child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.wifi_calling_3_sharp,color: darkBlueColor,),SizedBox(width: 10,),Text(
            "${widget.supportNo}",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.normal,
                color: blackColor),
          )],),),
        ),
      ),
    );
  }
}
//