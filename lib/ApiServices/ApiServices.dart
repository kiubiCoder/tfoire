import 'dart:async';
import 'package:clientfoire/database/DBProvider.dart';
import 'package:clientfoire/models/AdModel.dart';
import 'package:clientfoire/models/ArticleModel.dart';
import 'package:clientfoire/models/ExposantModel.dart';
import 'package:clientfoire/models/GallerieModel.dart';
import 'package:clientfoire/models/MainAddModel.dart';
import 'package:clientfoire/models/NewModel.dart';
import 'package:clientfoire/models/NotifModel.dart';
import 'package:clientfoire/models/VersionsModel.dart';
import 'package:clientfoire/utilitaires/Constants.dart';
import 'package:dio/dio.dart';
import '../Models/AgendaModel.dart';


class TfoireApiData{

  //liste des exposant
  Future  getExposantsFromApi() async {
    var url = API_BASE_URL + 'exposant/list';
    Response response = await Dio().get(url);
    return (response.data as List).map((e){
      //print('exposant $e');
      DBProvider.db.createExposant(ExposantModel.fromJson(e));
    }).toList();
  }

  //liste des événements de l'agenda
  Future getAgendaFromApi() async {
    var url = API_BASE_URL + 'agenda/list';
    Response response = await Dio().get(url);
    return (response.data as List).map((e){
      //print('agenda $e');
      DBProvider.db.createEvent(AgendaModel.fromJson(e));
    }).toList();
  }

  //liste des photos de la gallerie
  Future getGalleryFromApi() async {
    var url = API_BASE_URL + 'gallerie/list';
    Response response = await Dio().get(url);
    return (response.data as List).map((e){
      //print('gallerie $e');
      DBProvider.db.createPhoto(GalleryModel.fromJson(e));
    }).toList();
  }

  //liste des notifications
  Future getNotificationsFromApi() async {
    var url = API_BASE_URL + 'notif/list';
    Response response = await Dio().get(url);
    return (response.data as List).map((e){
      print('notifs $e');
      DBProvider.db.createNotif(NotifModel.fromJson(e));
    }).toList();
  }

  //liste des news
  Future getNewsFromApi() async {
    var url = API_BASE_URL + 'new/list';
    Response response = await Dio().get(url);
    return (response.data as List).map((e){
      //print('news $e');
      DBProvider.db.createNew(NewModel.fromJson(e));
    }).toList();
  }

  // images de publicite
  Future getAllAdsFromApi() async {
    var url = API_BASE_URL + 'ads/list';
    Response response = await Dio().get(url);
    return (response.data as List).map((e){
      //print('ads $e');
      DBProvider.db.createAd(AdModel.fromJson(e));
    }).toList();
  }

  // insertion des articles de la boutique
  Future getAllArticlesFromApi() async {
    var url = API_BASE_URL + 'article/list';
    Response response = await Dio().get(url);
    return (response.data as List).map((e){
      //print('Article $e');
      DBProvider.db.createArticle(ArticleModel.fromJson(e));
    }).toList();
  }

  // Reccuperation de la pub principale
  Future getMainAd() async {
    var url = API_BASE_URL + 'mainad/list';
    Response response = await Dio().get(url);
    return (response.data as List).map((e){
      //print('mainAd $e');
      DBProvider.db.createMainAd(MainAddModel.fromJson(e));
    }).toList();
  }

  //reccuperation des versions
  Future<List<VersionsModel>> getDatabaseVersion() async {
    var url = API_BASE_URL + 'versions/list';
    Response response = await Dio().get(url);
    return (response.data as List)
        .map((rep) => VersionsModel.fromJson(rep))
        .toList();
  }

}