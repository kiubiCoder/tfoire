
class AgendaModel{
  int? id;
  String? titre;
  String? libelle;
  String? date;
  String? time;

  AgendaModel({
    this.id,
    this.titre,
    this.libelle,
    this.date,
    this.time,
  });

  AgendaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titre = json['titre'];
    libelle = json['libelle'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titre'] = this.titre;
    data['libelle'] = this.libelle;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
