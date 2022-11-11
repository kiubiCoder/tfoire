
class GalleryModel {
  int? id;
  String? photoName;
  String? photoLink;
  String? exposant;


  GalleryModel(
      {this.id, this.photoName, this.photoLink, this.exposant});

  GalleryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photoName = json['photoName'];
    photoLink = json['photoLink'];
    exposant = json['exposant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photoName'] = this.photoName;
    data['photoLink'] = this.photoLink;
    data['exposant'] = this.exposant;
    return data;
  }

}
