class DriverAttributes {
  String? attributeName;
  String? attributeType;

  DriverAttributes({this.attributeName, this.attributeType});

  DriverAttributes.fromJson(Map<String, dynamic> json) {
    attributeName = json['attributeName'];
    attributeType = json['attributeType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attributeName'] = attributeName;
    data['attributeType'] = attributeType;
    return data;
  }
}
