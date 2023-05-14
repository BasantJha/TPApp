import 'package:circles_background/circles_background/circles_background.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../Constant/ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../../EmployerModelClasses/EmployerAddBalanceModelClass/EmployerOrderIdForInvoiceModel.dart';
import '../../EmployerModelClasses/EmployerPaymentModelClass/PaymentInvoiceModelClass.dart';
import '../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'Employer_NewPaymentGateway.dart';



class Employer_NewPaymentInvoice extends StatefulWidget
{
  const Employer_NewPaymentInvoice({Key? key, this.InvoiceModel, this.ttl, this.RedirectToPage, this.liveModel}) : super(key: key);

  final PaymentInvoiceModelClass? InvoiceModel;
  final String? ttl;
  final String? RedirectToPage;
  final Employer_VerifyMobileNoModelClass? liveModel;

  @override
  State<Employer_NewPaymentInvoice> createState() => _Employer_NewPaymentInvoice();
}

//
// ignore: camel_case_types
class _Employer_NewPaymentInvoice extends State<Employer_NewPaymentInvoice> {

  var netAmount;
  var sgRate;
  var sgAmount;
  var sgstRate;
  var sgstAmount;
  var cgstRate;
  var cgstAmount;
  var igstRate;
  var igstAmount;
  var gstbaseamount;
  var customeraccountname;
  var customercontactname;
  var gstmode;
  var statecode;
  var ac_gstnumber;
  var customeraddress;

  var custaccountid;
  var no_of_emp;
  var gst_mode;
  var net_value;
  var source = "Web";
  var createdby = "1";
  var created_ip = ":::1";
  var invoice_type = "";
  var service_name = "";
  var package_name = "";
  var amountInWords = "";
  var customerStateName="";
  var jurisdiction="";

  var employerName="";
  var employerAddress="";
  var employerCINNo="";
  var employerPANNo="";
  var employerStateName="";
  var employerGSTIN="";

  var piNumber="";
  var piDate="";


  Employer_VerifyMobileNoModelClass? liveModelObj;

  double leftRightServiceChargepadding=30;


  //Map for Final Paytm Screen
  var sendData = Map();

  @override
  void initState() {

    netAmount = widget.InvoiceModel?.netamountreceived;
    sgRate = widget.InvoiceModel?.servicechargerate;
    sgAmount = widget.InvoiceModel?.servicechargeamount;
    sgstRate = widget.InvoiceModel?.sgstrate;
    sgstAmount = widget.InvoiceModel?.sgstamount;
    cgstRate = widget.InvoiceModel?.cgstrate;
    cgstAmount = widget.InvoiceModel?.cgstamount;
    igstRate = widget.InvoiceModel?.igstrate;
    igstAmount = widget.InvoiceModel?.igstamount;
    gstbaseamount = widget.InvoiceModel?.gstbaseamount;
    customeraccountname = widget.InvoiceModel?.customeraccountname;
    customercontactname = widget.InvoiceModel?.customercontactname;

     customerStateName = widget.InvoiceModel?.accountstatename;

    gstmode = widget.InvoiceModel?.gstmode;
    statecode = widget.InvoiceModel?.statecode;
    ac_gstnumber = widget.InvoiceModel?.acGstnumber;
    customeraddress = widget.InvoiceModel?.customeraddress;

    // assigning values for generating the order id afte invoice
    custaccountid = widget.InvoiceModel?.customeraccountid.toString();
    no_of_emp = widget.InvoiceModel?.numberofemployees.toString();
    gst_mode = widget.InvoiceModel?.gstmode;
    net_value = widget.InvoiceModel?.baseamount.toString();
    liveModelObj=widget.liveModel;
    package_name=widget.ttl!;

    amountInWords=widget.InvoiceModel?.amountinwords;
    jurisdiction=widget.InvoiceModel?.jurisdiction;

     employerName=widget.InvoiceModel?.employername;
     employerAddress=widget.InvoiceModel?.employeraddress;
     employerCINNo=widget.InvoiceModel?.employercinno;
     employerPANNo=widget.InvoiceModel?.employerpanno;
     employerStateName=widget.InvoiceModel?.employerstatename;
     employerGSTIN=widget.InvoiceModel?.employergstno;

     piNumber=widget.InvoiceModel?.pinumber;
     piDate=widget.InvoiceModel?.pidate;

  }
  Text billD(String text) => Text(
    text,
    style: TextStyle(
      color: Colors.grey[700],
      fontSize: medium_FontSize,
    ),
  );

  Text billDS(String text) => Text(
    text,
    style: TextStyle(
      color: Colors.grey[700],
      fontSize: small_FontSize,
    ),
  );
  Text textAddress(String text) => Text(
    text,
    style: TextStyle(
      color: blackColor,
      fontSize: 11,
    ),
  );
  Text textAddressBold(String text) => Text(
    text,
    style: TextStyle(
      color: blackColor,fontWeight: semiBold_FontWeight,
      fontSize: 11,
    ),
  );

  @override
  Widget build(BuildContext context)
  {
    return  SafeArea(
        child: Scaffold(
          //drawer: EmployerNavigation_Drawer(liveModelObj: widget.liveModelObj,),
          backgroundColor: Colors.white,
          appBar:  CJAppBarBgBlue("", appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show the action 1type");
            Navigator.pop(context);
          })),

          body: getResponsiveUI(),
        )
    );
  }
  Responsive getResponsiveUI()
  {
    return Responsive(
      mobile: MainfunctionUi(),
      tablet: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUi(),
        ),
      ),
      desktop: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUi(),
        ),
      ),
    );
  }

  CirclesBackground MainfunctionUi()
  {
    return CirclesBackground(
      circles:getCircleInfoForHome,
      child: SafeArea(child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            child: Column(
              children: [
//
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  title: Text("Performa Invoice",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:  whiteColor,
                        fontFamily: robotoFontFamily,
                        fontSize: 20.0),
                  ),

                ),
                SizedBox(height: 25,),



                Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      Container(

                          child: SizedBox(
                            // height: 530,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [


                                /*---------new code start----------*/
//
                                SizedBox(height: 15,),
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // SizedBox(
                                      //   width: 25,
                                      // ),//
                                      Expanded(flex: 1,child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          textAddressBold("PI No: $piNumber"),
                                          SizedBox(height: 20,),

                                          textAddressBold("$employerName"),
                                          textAddress("$employerAddress"),
                                          textAddress("State Name: $employerStateName"),
                                          textAddress("GSTIN/UIN: $employerGSTIN"),
                                          textAddress("CIN: $employerCINNo"),
                                          textAddress("PAN: $employerPANNo"),

                                        ],
                                      )),
                                      SizedBox(width: 10,),
                                      Expanded(flex: 1,child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          textAddressBold("Date: $piDate"),
                                          SizedBox(height: 20,),

                                          textAddress("Bill to"),
                                          textAddressBold("$customercontactname"),
                                          textAddress("$customeraddress"),
                                          textAddress("State Code: $statecode"),
                                          textAddress("GSTIN: $ac_gstnumber")
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
////
//
//
                                /*-----------new code end-----------*/

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Colors.grey[300],
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      title: Text(
                                        "Service Charge",
                                        style: TextStyle(
                                            fontWeight: bold_FontWeight,
                                            fontSize: medium_FontSize),
                                      ),

                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "₹ ${net_value}",
                                            style: TextStyle(
                                              fontWeight: bold_FontWeight,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),


                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: leftRightServiceChargepadding),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // SizedBox(
                                      //   width: 25,
                                      // ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          /* Text(
                                    "Sub Total:",
                                    style: TextStyle(
                                        fontWeight: bold_FontWeight,
                                        fontSize: small_FontSize),
                                  ),*/
                                          Text(
                                            "Service Charge @ ${sgRate}",
                                            style:
                                            TextStyle(fontSize: smallLess_FontSize),
                                          ),
                                          (gstmode != "Interstate")
                                              ? Column(
                                            children: [
                                              Text(
                                                  "CGST @ ${cgstRate}",
                                                  style: TextStyle(
                                                      fontSize:
                                                      smallLess_FontSize)),
                                              Text(
                                                  "SGST @ ${sgstRate}",
                                                  style: TextStyle(
                                                      fontSize:
                                                      smallLess_FontSize)),
                                            ],
                                          )
                                              : Text(
                                              "IGST @ ${igstRate}",
                                              style: TextStyle(
                                                  fontSize: smallLess_FontSize)),


                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          /*  Text("₹ ${net_value}",
                                      style: TextStyle(
                                          fontWeight: bold_FontWeight,
                                          fontSize: small_FontSize)),*/
                                          Text(
                                            "₹ $sgAmount",
                                            style: TextStyle(
                                              fontSize: smallLess_FontSize,
                                            ),
                                          ),
                                          (gstmode != "Interstate")
                                              ? Column(
                                            children: [
                                              Text(
                                                "₹ $cgstAmount",
                                                style: TextStyle(
                                                    fontSize: smallLess_FontSize),
                                              ),
                                              Text(
                                                "₹ $sgstAmount",
                                                style: TextStyle(
                                                    fontSize: smallLess_FontSize),
                                              ),
                                            ],
                                          )
                                              : Text(
                                            "₹ $igstAmount",
                                            style: TextStyle(
                                                fontSize: smallLess_FontSize),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(padding: EdgeInsets.only(left: leftRightServiceChargepadding,right: leftRightServiceChargepadding),child:Container(height: 1,color: darkGreyColor) ,),
                                SizedBox(height: 10,),

                                /*---------show total amount-----------*/
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: leftRightServiceChargepadding),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // SizedBox(
                                      //   width: 25,
                                      // ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text("Total Amount",
                                              style: TextStyle(
                                                  fontWeight: bold_FontWeight,
                                                  fontSize: medium_FontSize)),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [

                                          Text("₹ $netAmount",
                                              style: TextStyle(
                                                  fontWeight: bold_FontWeight,
                                                  fontSize: medium_FontSize)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 15,),

                                /*------amount in words start-----------*/
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: leftRightServiceChargepadding-15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // SizedBox(
                                      //   width: 25,
                                      // ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text("Total Amount (in Words)",
                                              style: TextStyle(
                                                  fontWeight: normal_FontWeight,
                                                  fontSize: small_FontSize)),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [

                                          Text("",
                                              style: TextStyle(
                                                  fontWeight: bold_FontWeight,
                                                  fontSize: small_FontSize)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 3,),

                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: leftRightServiceChargepadding-15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // SizedBox(
                                      //   width: 25,
                                      // ),

                                      /*----------21-3-2023 start-------------*/
                                      Flexible(child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text(amountInWords,
                                              style: TextStyle(
                                                  fontWeight: semiBold_FontWeight,
                                                  fontSize: small_FontSize)),

                                        ],
                                      )),
                                      /*Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [

                                          Text("",
                                              style: TextStyle(
                                                  fontWeight: bold_FontWeight,
                                                  fontSize: medium_FontSize)),
                                        ],
                                      ),*/

                                      /*----------21-3-2023 end-------------*/

                                    ],
                                  ),
                                ),

                                /*------amount in words end-----------*/

                                SizedBox(height: 10,),
                                Padding(padding: EdgeInsets.only(left: leftRightServiceChargepadding-15,right: leftRightServiceChargepadding-15),child:Container(height: 1,color: darkGreyColor) ,),
                                SizedBox(height: 20,),

                                Text(
                                  jurisdiction,
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: small_FontSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 10,),

                                /*---------pay now start------------*/
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: lightBlueColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)),
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width, 55)),
                                    onPressed: () async
                                    {
                                      await getOrderData(context);
                                      Navigator.pop(context);

                                      TalentNavigation().pushTo(
                                          context,
                                          Employer_NewPaymentGateway(
                                            data: sendData,
                                            userArriveFrom: widget.RedirectToPage!,liveModelObj: liveModelObj,
                                          ));

                                      // Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Pay Now",
                                      style: TextStyle(
                                        fontSize: large_FontSize,
                                        fontWeight: bold_FontWeight,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                )


              ],
            ),
          ))),

    );

  }


  getOrderData(BuildContext context)
  {
    var MapForGeneratingOrder = getMapForOrderId(
        custaccountid.toString(),
        no_of_emp.toString(),
        netAmount.toString(),
        sgRate.toString(),
        sgAmount.toString(),
        gst_mode.toString(),
        sgstRate.toString(),
        sgstAmount.toString(),
        cgstRate.toString(),
        cgstAmount.toString(),
        igstRate.toString(),
        igstAmount.toString(),
        net_value.toString(),
        source.toString(),
        createdby.toString(),
        created_ip.toString(),
        invoice_type.toString(),
        service_name.toString(),
        package_name.toString());
    serviceRequestForOrderId(MapForGeneratingOrder, context);
  }

  serviceRequestForOrderId(Map mapObj, BuildContext context) {
    print(
        "inside order id function________________________________" + '$mapObj');

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(
        mapObj, JG_ApiMethod_GetOrderForInvoice,
        cjEmployerResponseBlock: CJEmployerResponseBlock(
            employerSuccessBlock: <T>(commonResponse, modelResponse) {
              print("print Details model response $modelResponse");
              EasyLoading.dismiss();

              print("Sucess 2_________________________________________");
              EmployerOrderIdForInvoiceModel getOrderNumberForInvoice =
              modelResponse as EmployerOrderIdForInvoiceModel;
              print(
                  "OrderInvoice details _________________________________________" +
                      '$getOrderNumberForInvoice');
              sendData['orderId'] = getOrderNumberForInvoice.invoiceno.toString();
              sendData['amt'] =
                  getOrderNumberForInvoice.netamountreceived.toString();
              sendData['customerAccountId'] =
                  getOrderNumberForInvoice.customeraccountid.toString();
              sendData['currency'] = 'INR';
              sendData['requestType'] = 'Payment';
            }, employerFailureBlock: <T>(commonResponse, failure) {
          EasyLoading.dismiss();

          CJTalentCommonModelClass paymentModelClass =
          commonResponse as CJTalentCommonModelClass;
          if (paymentModelClass?.message == null ||
              paymentModelClass?.message == "") {
            CJSnackBar(context, "server 1 error!");
          } else {
            CJSnackBar(context, paymentModelClass!.message!);
          }
        }));
  }



}







//old code 22-2-2023 start


/*
class Employer_NewPaymentInvoice
{
  //variables for invoice screen
  var netAmount;
  var sgRate;
  var sgAmount;
  var sgstRate;
  var sgstAmount;
  var cgstRate;
  var cgstAmount;
  var igstRate;
  var igstAmount;
  var gstbaseamount;
  var customeraccountname;
  var customercontactname;
  var gstmode;
  var statecode;
  var ac_gstnumber;
  var customeraddress;

  var custaccountid;
  var no_of_emp;
  var gst_mode;
  var net_value;
  var source = "Web";
  var createdby = "1";
  var created_ip = ":::1";
  var invoice_type = "";
  var service_name = "";
  var package_name = "";
  var amountInWords = "";

  Employer_VerifyMobileNoModelClass? liveModelObj;


  //Map for Final Paytm Screen
  var sendData = Map();

  Text billD(String text) => Text(
    text,
    style: TextStyle(
      color: Colors.grey[700],
      fontSize: medium_FontSize,
    ),
  );

  Text billDS(String text) => Text(
    text,
    style: TextStyle(
      color: Colors.grey[700],
      fontSize: small_FontSize,
    ),
  );
  Text textAddress(String text) => Text(
    text,
    style: TextStyle(
      color: blackColor,
      fontSize: 11,
    ),
  );
  Text textAddressBold(String text) => Text(
    text,
    style: TextStyle(
      color: blackColor,fontWeight: semiBold_FontWeight,
      fontSize: 11,
    ),
  );

  //getting order value for final payment after invoice


  Future<Future> showBottomSheetMethod(
      BuildContext context,
      PaymentInvoiceModelClass InvoiceModel,
      String ttl,
      String RedirectToPage,Employer_VerifyMobileNoModelClass liveModel)
  async {
    netAmount = InvoiceModel.netamountreceived;
    sgRate = InvoiceModel.servicechargerate;
    sgAmount = InvoiceModel.servicechargeamount;
    sgstRate = InvoiceModel.sgstrate;
    sgstAmount = InvoiceModel.sgstamount;
    cgstRate = InvoiceModel.cgstrate;
    cgstAmount = InvoiceModel.cgstamount;
    igstRate = InvoiceModel.igstrate;
    igstAmount = InvoiceModel.igstamount;
    gstbaseamount = InvoiceModel.gstbaseamount;
    customeraccountname = InvoiceModel.customeraccountname;
    customercontactname = InvoiceModel.customercontactname;

   var customerStateName = InvoiceModel.accountstatename;

    gstmode = InvoiceModel.gstmode;
    statecode = InvoiceModel.statecode;
    ac_gstnumber = InvoiceModel.acGstnumber;
    customeraddress = InvoiceModel.customeraddress;

    // assigning values for generating the order id afte invoice
    custaccountid = InvoiceModel.customeraccountid.toString();
    no_of_emp = InvoiceModel.numberofemployees.toString();
    gst_mode = InvoiceModel.gstmode;
    net_value = InvoiceModel.baseamount.toString();
    liveModelObj=liveModel;
    package_name=ttl;



    double leftRightServiceChargepadding=30;
    amountInWords=InvoiceModel.amountinwords;

    var jurisdiction=InvoiceModel.jurisdiction;


    var employerName=InvoiceModel.employername;
    var employerAddress=InvoiceModel.employeraddress;
    var employerCINNo=InvoiceModel.employercinno;
    var employerPANNo=InvoiceModel.employerpanno;
    var employerStateName=InvoiceModel.employerstatename;
    var employerGSTIN=InvoiceModel.employergstno;

    var piNumber=InvoiceModel.pinumber;
    var piDate=InvoiceModel.pidate;


    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                color: Colors.transparent,
                // padding: EdgeInsets.only(top: topSpace),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: mainUILeftRightPadding,
                          bottom: mainUILeftRightPadding),
                      child: FloatingActionButton(
                        onPressed: () => Navigator.pop(context),
                        backgroundColor: Colors.white,
                        child: Image(
                            image: AssetImage(TankhaPay_Icon_CloseCrossIcon)),
                      ),
                    ),
                  ],
                ),
              ),
              */
/*-----use below--*//*

              Container(
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      )),
                  child: SizedBox(
                    // height: 530,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        */
/*Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                          child: Image(
                            image: AssetImage(Employer_Icon_TankhaPayInvoiceBanner),
                          ),
                        ),*//*

                        Wrap(
                          direction: Axis.vertical,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [

                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Performa Invoice",
                              style: TextStyle(
                                color: darkBlueColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                           */
/* SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Akal Information Systems Ltd.",
                              style: TextStyle(
                                color: blackColor,
                                fontSize: large_FontSize,
                                fontWeight: FontWeight.w500,
                              ),
                            )*//*

                          ],
                        ),



                        */
/*---------new code start----------*//*

//
                      SizedBox(height: 15,),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // SizedBox(
                              //   width: 25,
                              // ),//
                              Expanded(flex: 1,child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textAddressBold("PI No: $piNumber"),
                                  SizedBox(height: 20,),

                                  textAddressBold("$employerName"),
                                  textAddress("$employerAddress"),
                                  textAddress("State Name: $employerStateName"),
                                  textAddress("GSTIN/UIN: $employerGSTIN"),
                                  textAddress("CIN: $employerCINNo"),
                                  textAddress("PAN: $employerPANNo"),

                                ],
                              )),
                              SizedBox(width: 10,),
                              Expanded(flex: 1,child:Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  textAddressBold("Date: $piDate"),
                                  SizedBox(height: 20,),

                                  textAddress("Bill to"),
                                  textAddressBold("$customercontactname"),
                                  textAddress("$customeraddress"),
                                  textAddress("State Name: $customerStateName"),
                                  textAddress("GSTIN: $ac_gstnumber")
                                ],
                              )),
                            ],
                          ),
                        ),
////
//
//
                        */
/*-----------new code end-----------*//*


                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.grey[300],
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              title: Text(
                                "Service Charge",
                                style: TextStyle(
                                    fontWeight: bold_FontWeight,
                                    fontSize: medium_FontSize),
                              ),

                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "₹ ${net_value}",
                                    style: TextStyle(
                                      fontWeight: bold_FontWeight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),


                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: leftRightServiceChargepadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // SizedBox(
                              //   width: 25,
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 */
/* Text(
                                    "Sub Total:",
                                    style: TextStyle(
                                        fontWeight: bold_FontWeight,
                                        fontSize: small_FontSize),
                                  ),*//*

                                  Text(
                                    "Service Charge @ ${sgRate}",
                                    style:
                                    TextStyle(fontSize: smallLess_FontSize),
                                  ),
                                  (gstmode != "Interstate")
                                      ? Column(
                                    children: [
                                      Text(
                                          "CGST @ ${cgstRate}",
                                          style: TextStyle(
                                              fontSize:
                                              smallLess_FontSize)),
                                      Text(
                                          "SGST @ ${sgstRate}",
                                          style: TextStyle(
                                              fontSize:
                                              smallLess_FontSize)),
                                    ],
                                  )
                                      : Text(
                                      "IGST @ ${igstRate}",
                                      style: TextStyle(
                                          fontSize: smallLess_FontSize)),


                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                */
/*  Text("₹ ${net_value}",
                                      style: TextStyle(
                                          fontWeight: bold_FontWeight,
                                          fontSize: small_FontSize)),*//*

                                  Text(
                                    "₹ $sgAmount",
                                    style: TextStyle(
                                      fontSize: smallLess_FontSize,
                                    ),
                                  ),
                                  (gstmode != "Interstate")
                                      ? Column(
                                    children: [
                                      Text(
                                        "₹ $cgstAmount",
                                        style: TextStyle(
                                            fontSize: smallLess_FontSize),
                                      ),
                                      Text(
                                        "₹ $sgstAmount",
                                        style: TextStyle(
                                            fontSize: smallLess_FontSize),
                                      ),
                                    ],
                                  )
                                      : Text(
                                    "₹ $igstAmount",
                                    style: TextStyle(
                                        fontSize: smallLess_FontSize),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(padding: EdgeInsets.only(left: leftRightServiceChargepadding,right: leftRightServiceChargepadding),child:Container(height: 1,color: darkGreyColor) ,),
                        SizedBox(height: 10,),

                        */
/*---------show total amount-----------*//*

                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: leftRightServiceChargepadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // SizedBox(
                              //   width: 25,
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text("Total Amount",
                                      style: TextStyle(
                                          fontWeight: bold_FontWeight,
                                          fontSize: medium_FontSize)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [

                                  Text("₹ $netAmount",
                                      style: TextStyle(
                                          fontWeight: bold_FontWeight,
                                          fontSize: medium_FontSize)),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 15,),

                        */
/*------amount in words start-----------*//*

                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: leftRightServiceChargepadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // SizedBox(
                              //   width: 25,
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text("Total Amount (in Words)",
                                      style: TextStyle(
                                          fontWeight: normal_FontWeight,
                                          fontSize: small_FontSize)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [

                                  Text("",
                                      style: TextStyle(
                                          fontWeight: bold_FontWeight,
                                          fontSize: small_FontSize)),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: leftRightServiceChargepadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // SizedBox(
                              //   width: 25,
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(amountInWords,
                                      style: TextStyle(
                                          fontWeight: semiBold_FontWeight,
                                          fontSize: small_FontSize)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [

                                  Text("",
                                      style: TextStyle(
                                          fontWeight: bold_FontWeight,
                                          fontSize: medium_FontSize)),
                                ],
                              ),
                            ],
                          ),
                        ),

                        */
/*------amount in words end-----------*//*


                        SizedBox(height: 10,),
                        Padding(padding: EdgeInsets.only(left: leftRightServiceChargepadding,right: leftRightServiceChargepadding),child:Container(height: 1,color: darkGreyColor) ,),
                        SizedBox(height: 20,),

                        Text(
                          jurisdiction,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: small_FontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10,),

                        */
/*---------pay now start------------*//*

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: lightBlueColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width, 55)),
                            onPressed: () async {
                              await getOrderData(context);
                              Navigator.pop(context);

                              TalentNavigation().pushTo(
                                  context,
                                  Employer_NewPaymentGateway(
                                    data: sendData,
                                    userArriveFrom: RedirectToPage,liveModelObj: liveModelObj,
                                  ));

                              // Navigator.pop(context);
                            },
                            child: Text(
                              "Pay Now",
                              style: TextStyle(
                                fontSize: large_FontSize,
                                fontWeight: bold_FontWeight,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }


  getOrderData(BuildContext context)
  {
    var MapForGeneratingOrder = getMapForOrderId(
        custaccountid.toString(),
        no_of_emp.toString(),
        netAmount.toString(),
        sgRate.toString(),
        sgAmount.toString(),
        gst_mode.toString(),
        sgstRate.toString(),
        sgstAmount.toString(),
        cgstRate.toString(),
        cgstAmount.toString(),
        igstRate.toString(),
        igstAmount.toString(),
        net_value.toString(),
        source.toString(),
        createdby.toString(),
        created_ip.toString(),
        invoice_type.toString(),
        service_name.toString(),
        package_name.toString());
    serviceRequestForOrderId(MapForGeneratingOrder, context);
  }

  serviceRequestForOrderId(Map mapObj, BuildContext context) {
    print(
        "inside order id function________________________________" + '$mapObj');

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(
        mapObj, JG_ApiMethod_GetOrderForInvoice,
        cjEmployerResponseBlock: CJEmployerResponseBlock(
            employerSuccessBlock: <T>(commonResponse, modelResponse) {
              print("print Details model response $modelResponse");
              EasyLoading.dismiss();

              print("Sucess 2_________________________________________");
              EmployerOrderIdForInvoiceModel getOrderNumberForInvoice =
              modelResponse as EmployerOrderIdForInvoiceModel;
              print(
                  "OrderInvoice details _________________________________________" +
                      '$getOrderNumberForInvoice');
              sendData['orderId'] = getOrderNumberForInvoice.invoiceno.toString();
              sendData['amt'] =
                  getOrderNumberForInvoice.netamountreceived.toString();
              sendData['customerAccountId'] =
                  getOrderNumberForInvoice.customeraccountid.toString();
              sendData['currency'] = 'INR';
              sendData['requestType'] = 'Payment';
            }, employerFailureBlock: <T>(commonResponse, failure) {
          EasyLoading.dismiss();

          CJTalentCommonModelClass paymentModelClass =
          commonResponse as CJTalentCommonModelClass;
          if (paymentModelClass?.message == null ||
              paymentModelClass?.message == "") {
            CJSnackBar(context, "server 1 error!");
          } else {
            CJSnackBar(context, paymentModelClass!.message!);
          }
        }));
  }

}
*/


