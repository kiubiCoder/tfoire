
class ArticleModel {
  int? id;
  String? libelle;
  String? prixBase;
  String? prixBarre;
  String? exposant;
  String? articleImage;

  ArticleModel(
      {this.id, this.libelle, this.prixBase, this.prixBarre, this.exposant, this.articleImage});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
    prixBase = json['prixBase'];
    prixBarre = json['prixBarre'];
    exposant = json['exposant'];
    articleImage = json['articleImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['libelle'] = this.libelle;
    data['prixBase'] = this.prixBase;
    data['prixBarre'] = this.prixBarre;
    data['exposant'] = this.exposant;
    data['articleImage'] = this.articleImage;
    return data;
  }
}


