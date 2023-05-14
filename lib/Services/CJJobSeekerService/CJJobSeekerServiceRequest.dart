import 'dart:convert';

import 'package:contractjobs/Controller/JobSeekers/ModelClasses/CJCommonResponse.dart';
import 'package:contractjobs/Controller/LoginView/ModelClasses/IntroModelClass.dart';
import 'package:contractjobs/Services/AESAlgo/encrypt.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceURL.dart';
import 'package:http/http.dart'as http;

class CJJobSeekerResponseBlock
{
  final void Function<T>(T successBlock) jobSeekerSuccessBlock;
  final void Function<T>(T failureblock) jobSeekerFailureBlock;

  CJJobSeekerResponseBlock({required this.jobSeekerSuccessBlock,required this.jobSeekerFailureBlock});
}
class CJJobSeekerServiceRequest
{
  postDataServiceRequest(Map bodyMap,String serviceType,{required CJJobSeekerResponseBlock cjJobSeekerResponseBlock})
  async {
    //EasyLoading.show(status: Message.get_LoaderMessage);

    //print("show map object data $bodyMap");
    try {
      final response = await http.post(
        Uri.parse(serviceType),
        headers: <String, String>{
          'Content-Type': kJS_ContentType,
        },
        body:bodyMap,
      );
      print(response.statusCode);
      print("show the first api response ${response.body}");
      if (response.statusCode == 200)
      {

        CJCommonResponse commonResponse=CJCommonResponse.fromJson(jsonDecode(response.body));
        var decryptedData=getDecryptedData(commonResponse.data.toString());
        print("show the model screenDetails $decryptedData");

        var jsonDec=jsonDecode(decryptedData);

        var modelClass;
        if(serviceType==JS_ApiMethod_Intro)
        {
          var screenDetails=Map();
          screenDetails["introDetails"]=jsonDec;
          modelClass=IntroModelClass.fromJson(jsonDecode(json.encode(screenDetails)));
        }

        if(commonResponse.status==true)
        {
          cjJobSeekerResponseBlock.jobSeekerSuccessBlock(modelClass);
        }else
        {
          cjJobSeekerResponseBlock.jobSeekerFailureBlock(modelClass);
        }



       // EasyLoading.dismiss();


      } else {

       // EasyLoading.dismiss();

        throw Exception('Failed to create get product.');
      }
    }catch(e){
      print(e);
    }
  }
  getDataServiceRequest(Map mapObj,String serviceType,{required CJJobSeekerResponseBlock cjJobSeekerResponseBlock})
  {

  }
}