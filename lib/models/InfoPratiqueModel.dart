import 'dart:convert';

List<InfoPratiqueModel> infoPratiqueFromJason(String str) =>
    List<InfoPratiqueModel>.from(json.decode(str).map((x)=>InfoPratiqueModel.fromJson(x)));

//conversion du model en json
String infoPratiqueToJason(List<InfoPratiqueModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoPratiqueModel {

  int id = 0;
  String details = "";
  int ordre = 0;
  String titre = "";

  InfoPratiqueModel({required this.id, required this.details, required this.ordre,required this.titre,});

  InfoPratiqueModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    details = json['details'];
    ordre = json['ordre'];
    titre = json['titre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['details'] = this.details;
    data['ordre'] = this.ordre;
    data['titre'] = this.titre;
    return data;
  }

}
