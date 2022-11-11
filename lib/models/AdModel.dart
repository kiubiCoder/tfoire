import 'dart:convert';

List<AdModel> agendaFromJason(String str) =>
    List<AdModel>.from(json.decode(str).map((x)=>AdModel.fromJson(x)));

//conversion du model en json
String agendaToJason(List<AdModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdModel {
  int? id;
  String? adLink;
  String? title;

  AdModel({this.id, this.adLink, this.title});

  AdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adLink = json['adLink'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['adLink'] = this.adLink;
    data['title'] = this.title;
    return data;
  }
}
