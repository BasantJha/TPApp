//import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName, String caseType) async
{


  /*-----------24-12-2021 start-------------*/

  String path="";

    //use for android
    path = (await getExternalStorageDirectory())!.path;

    //print('show path name $path');

    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);

    if(caseType=="Open") {
      /*-----------28-2-2023 start-------------*/
      //OpenFile.open('$path/$fileName');
      /*-----------28-2-2023 end-------------*/

    }else
    {
      //ok
    }


  /*-----------24-12-2021 end-------------*/
  /* //print('show path name $path');

    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);

    if(caseType=="Open") {
      OpenFile.open('$path/$fileName');
    }else
    {
      //ok
    }*/
}