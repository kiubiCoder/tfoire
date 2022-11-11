import 'dart:convert';

List<ExposantModel>exposantFromJason(String str) =>
    List<ExposantModel>.from(json.decode(str).map((x)=>ExposantModel.fromJson(x)));

//conversion du model en json
String exposantToJason(List<ExposantModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExposantModel {
  int? id;
  String? nom;
  String? pavillon;
  String? categorie;
  String? tel;
  String? presentation;
  String? brendImgLink;

  ExposantModel(
      {this.id,
        this.nom,
        this.pavillon,
        this.categorie,
        this.tel,
        this.presentation,
        this.brendImgLink,
      });

  ExposantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    pavillon = json['pavillon'];
    categorie = json['categorie'];
    tel = json['tel'];
    presentation = json['presentation'];
    brendImgLink = json['brendImgLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['pavillon'] = this.pavillon;
    data['categorie'] = this.categorie;
    data['tel'] = this.tel;
    data['presentation'] = this.presentation;
    data['brendImgLink'] = this.brendImgLink;
    return data;
  }
}

