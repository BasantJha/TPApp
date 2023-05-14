class EmployerLatestTransactionModelClass {
  bool? statusCode;
  String? message;
  List<Data>? data;

  EmployerLatestTransactionModelClass({this.statusCode, this.message, this.data});

  EmployerLatestTransactionModelClass.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  var customeraccountid;
  var customermobilenumber;
  var customeraccountname;
  var hsnSacNumber;
  var numberofemployees;
  var netamountreceived;
  var servicechargepercent;
  var servicechargeamount;
  var gstmode;
  var sgstpercent;
  var sgstamount;
  var cgstpercent;
  var cgstamount;
  var igstpercent;
  var igstamount;
  var netamount;
  var dateofinitiation;
  var dateofreceiving;
  var source;
  var isVerified;
  var verifiedon;
  var transactionid;
  var status;
  var invoiceno;
  var invoicedt;
  var invoicetype;
  var orderno;
  var orderdate;
  var referenceno;
  var serviceName;
  var totalgstpercent;
  var billingaddress;
  var acGstinNo;
  var statecode;
  var gstbaseamount;
  var packagename;
  var trantime;
  var tranmonth;
  var to_name;
  var paymentmethod;

  Data(
      {this.customeraccountid,
        this.customermobilenumber,
        this.customeraccountname,
        this.hsnSacNumber,
        this.numberofemployees,
        this.netamountreceived,
        this.servicechargepercent,
        this.servicechargeamount,
        this.gstmode,
        this.sgstpercent,
        this.sgstamount,
        this.cgstpercent,
        this.cgstamount,
        this.igstpercent,
        this.igstamount,
        this.netamount,
        this.dateofinitiation,
        this.dateofreceiving,
        this.source,
        this.isVerified,
        this.verifiedon,
        this.transactionid,
        this.status,
        this.invoiceno,
        this.invoicedt,
        this.invoicetype,
        this.orderno,
        this.orderdate,
        this.referenceno,
        this.serviceName,
        this.totalgstpercent,
        this.billingaddress,
        this.acGstinNo,
        this.statecode,
        this.gstbaseamount,
        this.packagename,
        this.trantime,
        this.tranmonth,this.to_name,
        this.paymentmethod});

  Data.fromJson(Map<String, dynamic> json) {
    customeraccountid = json['customeraccountid'];
    customermobilenumber = json['customermobilenumber'];
    customeraccountname = json['customeraccountname'];
    hsnSacNumber = json['hsn_sac_number'];
    numberofemployees = json['numberofemployees'];
    netamountreceived = json['netamountreceived'];
    servicechargepercent = json['servicechargepercent'];
    servicechargeamount = json['servicechargeamount'];
    gstmode = json['gstmode'];
    sgstpercent = json['sgstpercent'];
    sgstamount = json['sgstamount'];
    cgstpercent = json['cgstpercent'];
    cgstamount = json['cgstamount'];
    igstpercent = json['igstpercent'];
    igstamount = json['igstamount'];
    netamount = json['netamount'];
    dateofinitiation = json['dateofinitiation'];
    dateofreceiving = json['dateofreceiving'];
    source = json['source'];
    isVerified = json['is_verified'];
    verifiedon = json['verifiedon'];
    transactionid = json['transactionid'];
    status = json['status'];
    invoiceno = json['invoiceno'];
    invoicedt = json['invoicedt'];
    invoicetype = json['invoicetype'];
    orderno = json['orderno'];
    orderdate = json['orderdate'];
    referenceno = json['referenceno'];
    serviceName = json['service_name'];
    totalgstpercent = json['totalgstpercent'];
    billingaddress = json['billingaddress'];
    acGstinNo = json['ac_gstin_no'];
    statecode = json['statecode'];
    gstbaseamount = json['gstbaseamount'];
    packagename = json['packagename'];
    trantime = json['trantime'];
    tranmonth = json['tranmonth'];
    to_name = json['to_name'];
    paymentmethod = json['paymentmethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customeraccountid'] = this.customeraccountid;
    data['customermobilenumber'] = this.customermobilenumber;
    data['customeraccountname'] = this.customeraccountname;
    data['hsn_sac_number'] = this.hsnSacNumber;
    data['numberofemployees'] = this.numberofemployees;
    data['netamountreceived'] = this.netamountreceived;
    data['servicechargepercent'] = this.servicechargepercent;
    data['servicechargeamount'] = this.servicechargeamount;
    data['gstmode'] = this.gstmode;
    data['sgstpercent'] = this.sgstpercent;
    data['sgstamount'] = this.sgstamount;
    data['cgstpercent'] = this.cgstpercent;
    data['cgstamount'] = this.cgstamount;
    data['igstpercent'] = this.igstpercent;
    data['igstamount'] = this.igstamount;
    data['netamount'] = this.netamount;
    data['dateofinitiation'] = this.dateofinitiation;
    data['dateofreceiving'] = this.dateofreceiving;
    data['source'] = this.source;
    data['is_verified'] = this.isVerified;
    data['verifiedon'] = this.verifiedon;
    data['transactionid'] = this.transactionid;
    data['status'] = this.status;
    data['invoiceno'] = this.invoiceno;
    data['invoicedt'] = this.invoicedt;
    data['invoicetype'] = this.invoicetype;
    data['orderno'] = this.orderno;
    data['orderdate'] = this.orderdate;
    data['referenceno'] = this.referenceno;
    data['service_name'] = this.serviceName;
    data['totalgstpercent'] = this.totalgstpercent;
    data['billingaddress'] = this.billingaddress;
    data['ac_gstin_no'] = this.acGstinNo;
    data['statecode'] = this.statecode;
    data['gstbaseamount'] = this.gstbaseamount;
    data['packagename'] = this.packagename;
    data['trantime'] = this.trantime;
    data['tranmonth'] = this.tranmonth;
    data['to_name'] = this.to_name;
    data['paymentmethod'] = this.paymentmethod;
    return data;
  }
}
