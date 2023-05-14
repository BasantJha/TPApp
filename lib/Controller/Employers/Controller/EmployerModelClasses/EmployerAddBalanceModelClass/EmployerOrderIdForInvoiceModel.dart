
class EmployerOrderIdForInvoiceModel
{

var customeraccountid;
var netamountreceived;
var invoiceno;

EmployerOrderIdForInvoiceModel({
  this.customeraccountid,
  this.netamountreceived,
  this.invoiceno,
});

EmployerOrderIdForInvoiceModel.fromJson(Map<String, dynamic> json) {
customeraccountid = json['customeraccountid'];
netamountreceived = json['netamountreceived'];
invoiceno = json['invoiceno'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['customeraccountid'] = this.customeraccountid;
  data['netamountreceived'] = this.netamountreceived;
  data['invoiceno'] = this.invoiceno;
  return data;
}

}
