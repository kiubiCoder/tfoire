class NotifModel {
  int? id;
  String? dateNotif;
  String? title;
  String? message;
  String? pageCible;

  NotifModel(
      {this.id, this.dateNotif, this.title, this.message, this.pageCible});

  NotifModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateNotif = json['dateNotif'];
    title = json['title'];
    message = json['message'];
    pageCible = json['pageCible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dateNotif'] = this.dateNotif;
    data['title'] = this.title;
    data['message'] = this.message;
    data['pageCible'] = this.pageCible;
    return data;
  }
}
