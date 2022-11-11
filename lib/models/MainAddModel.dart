//Convertion du json en model
import 'dart:convert';

List<MainAddModel> mainAdFromJason(String str) =>
    List<MainAddModel>.from(json.decode(str).map((x)=>MainAddModel.fromJson(x)));

//conversion du model en json
String mainAdToJason(List<MainAddModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MainAddModel {
  int? id;
  String? adLink;
  String? libelle;

  MainAddModel(
      {
        this.id,
        this.adLink,
        this.libelle
      });

  MainAddModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adLink = json['adLink'];
    libelle = json['libelle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['adLink'] = this.adLink;
    data['libelle'] = this.libelle;
    return data;
  }
}