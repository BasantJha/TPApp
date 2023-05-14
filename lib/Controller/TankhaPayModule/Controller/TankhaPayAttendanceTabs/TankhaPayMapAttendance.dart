
import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../../../../Constant/ConstantIcon.dart';
import '../../../../Constant/Constants.dart';
import '../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceURL.dart';
import '../../../../Services/Messages/Message.dart';
import '../../../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../TankhaPayModelClasses/TankhaPayAttendanceTabsModelClass/TankhaPayEmloyeeCheckInModelClass.dart';
import '../../TankhaPayModelClasses/TankhaPayAttendanceTabsModelClass/TankhaPayGetTodayAttendance.dart';


class TankhaPayMapAttendance extends StatefulWidget
{
  const TankhaPayMapAttendance({Key? key, this.liveModelObject}) : super(key: key);
  final VerifyOTP_ModelResponse? liveModelObject;

  @override
  State<TankhaPayMapAttendance> createState() => _TankhaPayMapAttendance();
}

class _TankhaPayMapAttendance extends State<TankhaPayMapAttendance>

{
  static const CameraPosition initialPosition = CameraPosition(target: LatLng(28.5584, 77.2029), zoom: 14);
  final Completer<GoogleMapController> _controller = Completer();
  String apiKey = "AIzaSyC2Ar8iSYBIc_e6P3qORxNNyV0L97mjQ4Y";
  String _currentAddress = " ";
  final Set<Marker> markers = new Set();
  var lattitudetoPass;
  var longitudetoPass;

  bool showUI = false;
  bool showMarkButton = true,attendanceLockStatus=false;

  @override
  void initState()
  {
    super.initState();
    setMarkerForCurrentLocation();
    crateBodyWebApi_GetEmployeeTodayAttendanceStatus();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(

        body: Column(children:
        [
          Container(height: 300,child: loadGoogleMap(),),
          Container(
            color: Colors.grey[100],
            padding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageIcon(
                  AssetImage(TankhaPay_Icon_LocationMarkerIcon),
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(_currentAddress,
                      style: TextStyle(
                          fontFamily: robotoFontFamily,
                          fontSize: medium_FontSize
                      ),
                    )
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child:attendanceLockStatus==true?Container():showMarkButton == true?
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 50),
                    backgroundColor: Colors.blue,
                    //darkBlueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10)), //////// HERE
                  ),
                  onPressed: () {
                    createBodyWebApi_EmployeeCheckIn();
                  },
                  child: Text("Mark Attendance")) : Text("Today's Attendance Marked",style: TextStyle(fontWeight: bold_FontWeight),)
          )

        ],)

    );
  }


  GoogleMap loadGoogleMap()
  {
    return GoogleMap(
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      zoomControlsEnabled: true,
      initialCameraPosition: initialPosition,
      mapType: MapType.normal,
      markers: markers,
      onMapCreated: (GoogleMapController controller)
      {
        _controller.complete(controller);
      },
    );
  }

  Future<Position> permissionhandling() async
  {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async
    {
      await Geolocator.requestPermission();
    });
    return await Geolocator.getCurrentPosition();
  }

  setMarkerForCurrentLocation()
  {
    permissionhandling().then((value) async
    {

      print("Longitude ${value.longitude} Latitude ${value.latitude}");
      setState(() {
        lattitudetoPass = value.latitude.toString();
        longitudetoPass = value.longitude.toString();
      });
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 15,
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
      _getAddressFromLatLng(value.latitude, value.longitude);
    });
  }

  Future<void> _getAddressFromLatLng(double latitude,double longitude) async
  {
    print("Inside getAddress");
    await placemarkFromCoordinates(
        latitude, longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
      markers.add(
        Marker(
          markerId: MarkerId("78"),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(title: _currentAddress),
        ),
      );
      print("Address : $_currentAddress");
    }).catchError((e) {
      print("Inside Error");
      debugPrint(e);
    });
  }


  createBodyWebApi_EmployeeCheckIn()
  {
    //var emp_code = "mtzhs2E/ZYeW6s0JwDtqOIwFUU4BtK3fQ/b2kQaeuJFU7xbCZy3XOa9RAOe349ys";
    var check_in_latitude = lattitudetoPass;
    var check_in_longitude = longitudetoPass;
   // var created_by = "123";
    var created_ip = "13.76.188.146";
    //var customerAccountId = "DYasumL/NHqiIfJ7gY43RA==";

    var mapObj = checkIn_MarkAttendance_RequestBody(widget.liveModelObject!,check_in_latitude,check_in_longitude,created_ip);
    print("Map Data Passed $mapObj");
    serviceRequest_EmployeeCheckIn(mapObj);
  }


  serviceRequest_EmployeeCheckIn(Map mapObj)
  {
    print("show 1the request12");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.TankhaPay_ApiMethod_Employee_checkIn,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          var get_Today_Attendance =success as CJTalentCommonModelClass;
          //var data = get_Today_Attendance.commonData;

          if(get_Today_Attendance.statusCode == true){
            CJSnackBar(context, get_Today_Attendance.message.toString());
            setState(() {
              showMarkButton = false;
            });
          }

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();
          CJTalentCommonModelClass commonObject= failure as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }
        }, talentHandleExceptionBlock: <T>(handleException)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonObject= handleException as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }

        }));
  }


  crateBodyWebApi_GetEmployeeTodayAttendanceStatus()
  {
    var mapObj = get_TodayAttendance_RequestBody(widget.liveModelObject!);
    serviceRequestForGetTodayAttendance(mapObj);
  }

  serviceRequestForGetTodayAttendance(mapObj)
  {
    print("show 1the request12");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.TankhaPay_ApiMethod_get_TodayAttendance,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();

         var get_Today_Attendance =success as TankhaPayGetTodayAttendance;

          var data = get_Today_Attendance.commonData;
          //print("Massege in request save Attendance: ${data?}");
          if(get_Today_Attendance.statusCode == true){
            setState(() {
              showMarkButton = false;
            });
          }
          else{
            CJSnackBar(context,get_Today_Attendance.message! );
          }

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();
          CJTalentCommonModelClass commonObject= failure as CJTalentCommonModelClass;

          if(commonObject.attendanceStatus == "Locked"){
            setState(() {

              attendanceLockStatus=true;
            });
          }
//
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }
          else
          {
            CJSnackBar(context,commonObject!.message as String);
          }
        }, talentHandleExceptionBlock: <T>(handleException)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonObject= handleException as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }

        }));
  }

}







