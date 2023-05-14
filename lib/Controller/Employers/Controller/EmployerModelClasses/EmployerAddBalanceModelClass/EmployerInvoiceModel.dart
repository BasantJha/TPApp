

class EmployerInvoiceModel {
  /*int? customeraccountid;
  String? customermobilenumber;
  String? customeraccountname;
  int? numberofemployees;
  double? baseamount;
  double? netamountreceived;
  double? servicechargerate;
  double? servicechargeamount;
  String? gstmode;
  double? sgstrate;
  double? sgstamount;
  double? cgstrate;
  double? cgstamount;
  double? igstrate;
  double? igstamount;
  double? gstbaseamount;
  String? customercontactname;
  String? customeraddress;
  String? acGstnumber;
  String? statecode;*/
//
  int? customeraccountid;
  String? customermobilenumber;
  String? customeraccountname;
  int? numberofemployees;
  double? baseamount;
  double? netamountreceived;
  double? servicechargerate;
  double? servicechargeamount;
  String? gstmode;
  double? sgstrate;
  double? sgstamount;
  double? cgstrate;
  double? cgstamount;
  double? igstrate;
  double? igstamount;
  double? gstbaseamount;
  String? customercontactname;
  String? customeraddress;
  String? acGstnumber;
  String? statecode;

  EmployerInvoiceModel(
      {this.customeraccountid,
        this.customermobilenumber,
        this.customeraccountname,
        this.numberofemployees,
        this.baseamount,
        this.netamountreceived,
        this.servicechargerate,
        this.servicechargeamount,
        this.gstmode,
        this.sgstrate,
        this.sgstamount,
        this.cgstrate,
        this.cgstamount,
        this.igstrate,
        this.igstamount,
        this.gstbaseamount,
        this.customercontactname,
        this.customeraddress,
        this.acGstnumber,
        this.statecode});

  EmployerInvoiceModel.fromJson(Map<String, dynamic> json) {
    customeraccountid = json['customeraccountid'];
    customermobilenumber = json['customermobilenumber'];
    customeraccountname = json['customeraccountname'];
    numberofemployees = json['numberofemployees'];
    baseamount = json['baseamount'];
    netamountreceived = json['netamountreceived'];
    servicechargerate = json['servicechargerate'];
    servicechargeamount = json['servicechargeamount'];
    gstmode = json['gstmode'];
    sgstrate = json['sgstrate'];
    sgstamount = json['sgstamount'];
    cgstrate = json['cgstrate'];
    cgstamount = json['cgstamount'];
    igstrate = json['igstrate'];
    igstamount = json['igstamount'];
    gstbaseamount = json['gstbaseamount'];
    customercontactname = json['customercontactname'];
    customeraddress = json['customeraddress'];
    acGstnumber = json['ac_gstnumber'];
    statecode = json['statecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customeraccountid'] = this.customeraccountid;
    data['customermobilenumber'] = this.customermobilenumber;
    data['customeraccountname'] = this.customeraccountname;
    data['numberofemployees'] = this.numberofemployees;
    data['baseamount'] = this.baseamount;
    data['netamountreceived'] = this.netamountreceived;
    data['servicechargerate'] = this.servicechargerate;
    data['servicechargeamount'] = this.servicechargeamount;
    data['gstmode'] = this.gstmode;
    data['sgstrate'] = this.sgstrate;
    data['sgstamount'] = this.sgstamount;
    data['cgstrate'] = this.cgstrate;
    data['cgstamount'] = this.cgstamount;
    data['igstrate'] = this.igstrate;
    data['igstamount'] = this.igstamount;
    data['gstbaseamount'] = this.gstbaseamount;
    data['customercontactname'] = this.customercontactname;
    data['customeraddress'] = this.customeraddress;
    data['ac_gstnumber'] = this.acGstnumber;
    data['statecode'] = this.statecode;
    return data;
  }
}