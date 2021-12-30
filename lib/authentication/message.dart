class Message {
  List<String>? phone;
  List<String>? email;

  Message({this.phone, this.email});

  Message.fromJson(Map<String, dynamic> json) {
    phone = json['phone'].cast<String>();
    email = json['email'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}
