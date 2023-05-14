
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/CustomView/RichText/RichTextClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation_Drawer extends StatelessWidget
{
  const Navigation_Drawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    context=context;

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              icon: Icon(Icons.close),
              onPressed: ()
              {
                Navigator.pop(context);
              },
              iconSize: 30,
            ),
            buildHeader(context),
            SizedBox(
              height: 5,
            ),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context)
{
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: darkGreyColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(Talent_Icon_profileDrawer),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: ImageIcon(AssetImage(Talent_Icon_cameraDrawer),
                      color: darkGreyColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Kamla Devi",
                  style: TextStyle(
                    fontFamily: viewHeadingFontfamily,
                  ),
                ),
                SizedBox(width: 5),
                ImageIcon(
                  AssetImage(Verification_Icon),
                  color: Colors.blue,
                )
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "House Help",
                  style: TextStyle(
                    fontFamily: viewHeadingFontfamily,
                  ),
                ),
                SizedBox(height: 2,),
                getRichTextForTalentProfileSlide("Cj code: ", "688578"),
                SizedBox(height: 2,),
                getRichTextForTalentProfileSlide("Mob: ", "9875836528"),
                SizedBox(height: 2,),
                getRichTextForTalentProfileSlide("Email: ", "kamla@gmail.com"),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Image.asset(Talent_Icon_qrCodeDrawer),
          SizedBox(
            height: 10,
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Share QR code",
                  style: TextStyle(
                    fontFamily: viewHeadingFontfamily,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.share),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    ),
  );
}



Widget buildMenuItems(BuildContext context)
{
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: darkGreyColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          menuItems(Talent_Name_SettingDrawer, Talent_Icon_SettingDrawer,context),
          getPadding(),
        /*  menuItems(Talent_Name_ChatDrawer, Talent_Icon_ChatDrawer,context),
          getPadding(),*/
          menuItems(Talent_Name_ReferFriendDrawer, Talent_Icon_ReferFriendDrawer,context),
          getPadding(),
          menuItems(Talent_Name_TermsOfUseDrawer, Talent_Icon_TermsOfUseDrawer,context),
          getPadding(),
          menuItems(Talent_Name_PrivacyPolicyDrawer, Talent_Icon_PrivacyPolicyDrawer,context),
          getPadding(),
          menuItems(Talent_Name_VersionDrawer, Talent_Icon_VersionDrawer,context),
          getPadding(),
          menuItems(Talent_Name_LogoutDrawer, Talent_Icon_VersionDrawer,context)
        ],
      ),
    ),
  );
}

Padding getPadding()
{
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 13),
    child: Divider(
      height: 1,
      thickness: 1,
    ),
  );
}



GestureDetector menuItems(String title,String image,BuildContext context/*,Widget showView*/)
{
  return GestureDetector(child:ListTile(
    //visualDensity: VisualDensity(horizontal: 0, vertical: -0),
    leading: ImageIcon(
      AssetImage(image),
      color: menuTextColor,
    ),
    title: Text(
      title,
      style: TextStyle(
        color: menuTextColor,
        fontFamily: robotoFontFamily,fontSize: 14
      ),
    ),
  ) ,onTap: ()
  {
    /* Navigator.push(context,
          MaterialPageRoute(builder: (context) => showView));*/
  },);

}