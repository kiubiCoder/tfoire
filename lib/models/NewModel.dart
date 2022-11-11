import 'dart:convert';

List<NewModel> agendaFromJason(String str) =>
    List<NewModel>.from(json.decode(str).map((x)=>NewModel.fromJson(x)));

//conversion du model en json
String agendaToJason(List<NewModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewModel {
  int? id;
  String? title;
  String? libelle;
  String? image1;
  String? image2;
  String? jour;
  String? annee;

  NewModel(
      {
        this.id,
        this.title,
        this.libelle,
        this.image1,
        this.image2,
        this.jour,
        this.annee,
      });

  NewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    libelle = json['libelle'];
    image1 = json['image1'];
    image2 = json['image2'];
    jour = json['jour'];
    annee = json['annee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['libelle'] = this.libelle;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['jour'] = this.jour;
    data['annee'] = this.annee;
    return data;
  }
}
