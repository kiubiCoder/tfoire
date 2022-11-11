
class VersionsModel {
  int? id;
  String? agendaVersion;
  String? articleVersion;
  String? exposantVersion;
  String? gallerieVersion;
  String? newVersion;
  String? pavillonVersion;

  VersionsModel(
      {
        this.id,
        this.agendaVersion,
        this.articleVersion,
        this.exposantVersion,
        this.gallerieVersion,
        this.newVersion,
        this.pavillonVersion
      });

  VersionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agendaVersion = json['agendaVersion'];
    articleVersion = json['articleVersion'];
    exposantVersion = json['exposantVersion'];
    gallerieVersion = json['gallerieVersion'];
    newVersion = json['newVersion'];
    pavillonVersion = json['pavillonVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['agendaVersion'] = this.agendaVersion;
    data['articleVersion'] = this.articleVersion;
    data['exposantVersion'] = this.exposantVersion;
    data['gallerieVersion'] = this.gallerieVersion;
    data['newVersion'] = this.newVersion;
    data['pavillonVersion'] = this.pavillonVersion;
    return data;
  }
}