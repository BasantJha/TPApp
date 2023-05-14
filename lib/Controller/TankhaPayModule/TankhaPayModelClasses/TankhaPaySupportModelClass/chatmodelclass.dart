class ChatModel {
  String? message;
  String? user;
  String? img;

  ChatModel({this.message, this.user, this.img});

  ChatModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user'] = this.user;
    data['img'] = this.img;
    return data;
  }
}
