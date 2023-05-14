

import 'package:flutter/cupertino.dart';

BottomNavigationBarItem TalentTab(String icon,String name)
{
  //return ImageIcon(AssetImage(iconName));

  return BottomNavigationBarItem(
    icon: ImageIcon(AssetImage(icon)),
    label: name,
  );
}