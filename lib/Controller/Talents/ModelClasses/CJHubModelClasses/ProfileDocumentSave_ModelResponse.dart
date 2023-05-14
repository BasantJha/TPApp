class ProfileDocumentSave_ModelResponse
{
  bool? statusCode;
  String? message;

  ProfileDocumentSave_ModelResponse({this.statusCode, this.message});

  ProfileDocumentSave_ModelResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}