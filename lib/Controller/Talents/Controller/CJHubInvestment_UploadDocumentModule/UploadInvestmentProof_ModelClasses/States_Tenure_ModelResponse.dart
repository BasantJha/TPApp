

class States_Tenure_ModelResponse
{
  bool? statusCode;
  var message;
  Data? data;

  static List<Tenure> loadTenureDefaultData = [
    Tenure(
      id: "1",
      tenure: "Month Tenure",

    )
  ];

  static List<States> loadStatesDefaultData = [
    States(
      id: "1",
      stateName: "Utter Pradesh",

    )
  ];
  States_Tenure_ModelResponse({this.statusCode, this.message, this.data});

  States_Tenure_ModelResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<States>? states;
  List<Tenure>? tenure;
  List<Hra>? hra;

  Data({this.states, this.tenure, this.hra});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states!.add(new States.fromJson(v));
      });
    }
    if (json['tenure'] != null) {
      tenure = <Tenure>[];
      json['tenure'].forEach((v) {
        tenure!.add(new Tenure.fromJson(v));
      });
    }
    if (json['hra'] != null) {
      hra = <Hra>[];
      json['hra'].forEach((v) {
        hra!.add(new Hra.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.states != null) {
      data['states'] = this.states!.map((v) => v.toJson()).toList();
    }
    if (this.tenure != null) {
      data['tenure'] = this.tenure!.map((v) => v.toJson()).toList();
    }
    if (this.hra != null) {
      data['hra'] = this.hra!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class States {
  var id;
  var stateName;

  States({this.id, this.stateName});

  States.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_name'] = this.stateName;
    return data;
  }
}

class Tenure {
  var id;
  var tenure;

  Tenure({this.id, this.tenure});

  Tenure.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenure = json['tenure'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tenure'] = this.tenure;
    return data;
  }
}

class Hra {
  var empCode;
  var fromDate;
  var toDate;
  var receiptNo;
  var receiptDate;
  var rentAmount;
  var landlordName;
  var landlordAddress;
  var landlordCity;
  var landlordState;
  var landlordStateName;
  var landlordPan;
  var monthlyTenure;
  var monthlyTenureName;
  var headId;
  var approvalStatus;
  var documentPath;
  var documentName;
  var originalDocumentName;

  Hra(
      {this.empCode,
        this.fromDate,
        this.toDate,
        this.receiptNo,
        this.receiptDate,
        this.rentAmount,
        this.landlordName,
        this.landlordAddress,
        this.landlordCity,
        this.landlordState,
        this.landlordStateName,
        this.landlordPan,
        this.monthlyTenure,
        this.monthlyTenureName,
        this.headId,
        this.approvalStatus,
        this.documentPath,
        this.documentName,
        this.originalDocumentName});

  Hra.fromJson(Map<String, dynamic> json) {
    empCode = json['emp_code'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    receiptNo = json['receipt_no'];
    receiptDate = json['receipt_date'];
    rentAmount = json['rent_amount'];
    landlordName = json['landlord_name'];
    landlordAddress = json['landlord_address'];
    landlordCity = json['landlord_city'];
    landlordState = json['landlord_state'];
    landlordStateName = json['landlord_state_name'];
    landlordPan = json['landlord_pan'];
    monthlyTenure = json['monthly_tenure'];
    monthlyTenureName = json['monthly_tenure_name'];
    headId = json['head_id'];
    approvalStatus = json['approval_status'];
    documentPath = json['document_path'];
    documentName = json['document_name'];
    originalDocumentName = json['original_document_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_code'] = this.empCode;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['receipt_no'] = this.receiptNo;
    data['receipt_date'] = this.receiptDate;
    data['rent_amount'] = this.rentAmount;
    data['landlord_name'] = this.landlordName;
    data['landlord_address'] = this.landlordAddress;
    data['landlord_city'] = this.landlordCity;
    data['landlord_state'] = this.landlordState;
    data['landlord_state_name'] = this.landlordStateName;
    data['landlord_pan'] = this.landlordPan;
    data['monthly_tenure'] = this.monthlyTenure;
    data['monthly_tenure_name'] = this.monthlyTenureName;
    data['head_id'] = this.headId;
    data['approval_status'] = this.approvalStatus;
    data['document_path'] = this.documentPath;
    data['document_name'] = this.documentName;
    data['original_document_name'] = this.originalDocumentName;
    return data;
  }
}

