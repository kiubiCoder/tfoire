import 'dart:io';

import 'package:clientfoire/Models/AgendaModel.dart';
import 'package:clientfoire/models/AdModel.dart';
import 'package:clientfoire/models/ExposantModel.dart';
import 'package:clientfoire/models/GallerieModel.dart';
import 'package:clientfoire/models/NewModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/ArticleModel.dart';
import '../models/InfoPratiqueModel.dart';
import '../models/MainAddModel.dart';
import '../models/NotifModel.dart';

class DBProvider{
  static final _databaseVersion = 1;
  static final DBProvider db = DBProvider._internal();
  factory DBProvider() => db;
  DBProvider._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'foire.db');
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDatabase,
      //onUpgrade: _onUpgrade,
    );
  }

  //creation de la base de données
  Future<void> _createDatabase(Database db, int version) async {
    //creation de la table des comparatifs
    await db.execute(
        'CREATE TABLE Agenda('
            'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
            'titre TEXT,'
            'libelle TEXT,'
            'date TEXT,'
            'time TEXT'
            ')'
    );
    print("===================  table agenda creee =========================");

    //Table Exposant
    await db.execute(
        'CREATE TABLE Exposant('
            'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
            'nom TEXT,'
            'pavillon TEXT,'
            'categorie TEXT,'
            'tel TEXT,'
            'presentation TEXT,'
            'brendImgLink TEXT'
            ')'
    );
    print("===================  table exposant creee =========================");

    //Table Gallery
    await db.execute(
        'CREATE TABLE Gallery('
            'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
            'photoName TEXT,'
            'photoLink TEXT,'
            'exposant TEXT'
            ')'
    );
    print("===================  table Gallery creee =========================");

    //Table News
    await db.execute(
        'CREATE TABLE New('
            'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
            'title TEXT,'
            'libelle TEXT,'
            'image1 TEXT,'
            'image2 TEXT,'
            'jour TEXT,'
            'annee TEXT'
            ')'
    );
    print("===================  table News creee =========================");

    //Table Ads
    await db.execute(
        'CREATE TABLE Ads('
            'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
            'adLink TEXT,'
            'title TEXT'
            ')'
    );
    print("===================  table Ads creee =========================");

    //Table du Add principal
    await db.execute(
        'CREATE TABLE MainAdd('
            'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
            'adLink TEXT,'
            'libelle TEXT'
            ')'
    );
    print("===================  table mainAdd  =========================");

    //Table du Add principal
    await db.execute(
        'CREATE TABLE Article('
            'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
            'libelle TEXT,'
            'prixBase TEXT,'
            'prixBarre TEXT,'
            'exposant TEXT,'
            'articleImage TEXT'
            ')'
    );
    print("===================  tablearticle  =========================");

    await db.execute(
        'CREATE TABLE Notif('
            'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
            'dateNotif TEXT,'
            'title TEXT,'
            'message TEXT,'
            'pageCible TEXT'
            ')'
    );

    //creation de la table info pratique
    await db.execute(
        'CREATE TABLE InfoPratique('
            'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
            'details TEXT,'
            'ordre INTEGER,'
            'titre TEXT'
            ')'
    );
    print("===================  table Info Pratique creee =========================");


  }
  //fonction de mise à jour
  /*void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Perform database schema update for version 2
      await db.execute('ALTER TABLE your_table ADD COLUMN new_column TEXT');
    }

    // Additional schema updates for other versions can be added here
  }*/

  //====================================================
  //============== Info pratique      ==================
  //====================================================

  //Insertion d'infos pratiques
  createInfoPratique(InfoPratiqueModel infoPratiqueModel) async {
    final db = await database;
    var batch = db.batch();
    await deleteAllInfosPratique().whenComplete(() async {
      print('Deleted infos pratiques');
      batch.insert('InfoPratique', infoPratiqueModel.toJson());
      await batch.commit(noResult: true, continueOnError: true);
    });
  }

  // Suppression des infos pratiques
  Future<int?> deleteAllInfosPratique() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM InfoPratique');

    return res;
  }

  //Liste de tous les infos pratiques
  Future<List<InfoPratiqueModel>> getAllInfosPratiques() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM InfoPratique ORDER BY ordre ASC");

    List<InfoPratiqueModel> list = res.isNotEmpty ? res.map((c) => InfoPratiqueModel.fromJson(c)).toList() : [];

    return list;
  }

  //nombre infos pratiques
  Future<int?> countInfosPratique() async {
    var conexion = await database;
    final res = Sqflite.firstIntValue(await conexion.rawQuery("SELECT COUNT(*) FROM InfoPratique"));
    return res;
  }



  //=================================================
  //===============  Agenda =========================
  //=================================================

  // Insertion d'un acte dans la base
  createEvent(AgendaModel agendaModel) async {
    final db = await database;
    var batch = db.batch();
    await deleteAllEvents().whenComplete(() async {
      print('Deleted events');
      batch.insert('Agenda', agendaModel.toJson());
      await batch.commit(noResult: true, continueOnError: true);
    });
  }

  // Suppression des actes
  Future<int?> deleteAllEvents() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Agenda');
    //final res = await db?.rawDelete('DELETE FROM Agenda');

    return res;
  }

  //Liste de tous les actes
  Future<List<AgendaModel>> getAllEvents() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Agenda ORDER BY id DESC");

    List<AgendaModel> list = res.isNotEmpty ? res.map((c) => AgendaModel.fromJson(c)).toList() : [];

    return list;
  }

  //nombre d'evenements dans l'agenda
  Future<int?> countEvents() async {
    var conexion = await database;
    final res = Sqflite.firstIntValue(await conexion.rawQuery("SELECT COUNT(*) FROM Agenda"));
    return res;
  }

  //=================================================
  //===============  Exposants =========================
  //=================================================

  // Insertion d'un acte dans la base
  createExposant(ExposantModel exposantModel) async {
    final db = await database;
    var batch = db.batch();
    await deleteAllExposants().whenComplete(() async{
      print('Deleted exposant');
      batch.insert('Exposant', exposantModel.toJson());
      await batch.commit(noResult: true, continueOnError: true);
    });
  }

  // Suppression des actes
  Future<int?> deleteAllExposants() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Exposant');
    return res;
  }

  //Liste de tous les actes
  Future<List<ExposantModel>> getAllExposant() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Exposant ORDER BY id DESC");

    List<ExposantModel> list = res.isNotEmpty ? res.map((c) => ExposantModel.fromJson(c)).toList() : [];

    return list;
  }

  //reccuperation du numero d'un exposant
  Future<List<ExposantModel>> getTelExposantByName(String nomExposant) async {
    final db = await database;
    final res = await db.rawQuery("SELECT Exposant.tel FROM Exposant WHERE Exposant.nom LIKE '%$nomExposant%'");
    print('================ $res');
    List<ExposantModel> list = res.isNotEmpty ? res.map((c) => ExposantModel.fromJson(c)).toList() : [];
    return list;
  }

  //nombre d'exposant
  Future<int?> countExposant() async {
    var conexion = await database;
    final res = Sqflite.firstIntValue(await conexion.rawQuery("SELECT COUNT(*) FROM Exposant"));
    return res;
  }

  //=================================================
  //===============  Gallery ========================
  //=================================================

  // Insertion d'un acte dans la base
  createPhoto(GalleryModel galleryModel) async {
    final db = await database;
    var batch = db.batch();
    await deleteAllPhotos().whenComplete(() async{
      batch.insert('Gallery', galleryModel.toJson());
      await batch.commit(noResult: true, continueOnError: true);
    });

  }

  // Suppression des actes
  Future<int?> deleteAllPhotos() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Gallery');

    return res;
  }

  //Liste de toutes les photos
  Future<List<GalleryModel>> getAllPhotos() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Gallery ORDER BY id DESC");

    List<GalleryModel> list = res.isNotEmpty ? res.map((c) => GalleryModel.fromJson(c)).toList() : [];

    return list;
  }

  //Liste des exposants presents dans la gallerie
  Future<List<GalleryModel>> getGallerieExposants() async {
    final db = await database;
    final res = await db.rawQuery("SELECT DISTINCT exposant FROM Gallery ORDER BY id DESC");

    List<GalleryModel> list = res.isNotEmpty ? res.map((c) => GalleryModel.fromJson(c)).toList() : [];

    return list;
  }

  //nombre d'exposant
  Future<int?> countGallery() async {
    var conexion = await database;
    final res = Sqflite.firstIntValue(await conexion.rawQuery("SELECT COUNT(*) FROM Gallery"));
    return res;
  }

  //=================================================
  //===================== News ======================
  //=================================================

  //Insertion des news
  createNew(NewModel newModel) async {
    final db = await database;
    var batch = db.batch();
    await deleteAllNews().whenComplete(() async{
      batch.insert('New', newModel.toJson());
      await batch.commit(noResult: true, continueOnError: true);
    });

  }

  //Suppression des news
  Future<int?> deleteAllNews() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM New');
    return res;
  }

  //Liste des news
  Future<List<NewModel>> getAllNews() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM New ORDER BY id DESC");
    List<NewModel> list = res.isNotEmpty ? res.map((c) => NewModel.fromJson(c)).toList() : [];
    return list;
  }

  //nombre de news
  Future<int?> countNews() async {
    var conexion = await database;
    final res = Sqflite.firstIntValue(await conexion.rawQuery("SELECT COUNT(*) FROM New"));
    return res;
  }

  //=================================================
  //===================== Articles de boutique ======================
  //=================================================

  //Insertion des article
  createArticle(ArticleModel articleModel) async {
    final db = await database;
    var batch = db.batch();
    await deleteAllArticle().whenComplete(() async{
      batch.insert('Article', articleModel.toJson());
      await batch.commit(noResult: true, continueOnError: true);
    });

  }

  //Suppression des article
  Future<int?> deleteAllArticle() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Article');
    return res;
  }

  //Liste des article
  Future<List<ArticleModel>> getAllArticles() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Article ORDER BY id DESC");
    List<ArticleModel> list = res.isNotEmpty ? res.map((c) => ArticleModel.fromJson(c)).toList() : [];
    return list;
  }

  //Liste des exposants ayants publie un article
  Future<List<ArticleModel>> getArticlesExposants() async {
    final db = await database;
    final res = await db.rawQuery("SELECT DISTINCT exposant FROM Article ORDER BY id DESC");
    List<ArticleModel> list = res.isNotEmpty ? res.map((c) => ArticleModel.fromJson(c)).toList() : [];
    return list;
  }

  //nombre de article
  Future<int?> countArticles() async {
    var conexion = await database;
    final res = Sqflite.firstIntValue(await conexion.rawQuery("SELECT COUNT(*) FROM Article"));
    return res;
  }

  //=================================================
  //===================== Main ad ======================
  //=================================================

  //Insertion des article
  createMainAd(MainAddModel mainAddModel) async {
    final db = await database;
    var batch = db.batch();
    await deleteAllMainAds().whenComplete(()async{
      batch.insert('MainAdd', mainAddModel.toJson());
      await batch.commit(noResult: true, continueOnError: true);
    });

  }

  //Suppression des article
  Future<int?> deleteAllMainAds() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM MainAdd ');
    return res;
  }

  //Liste des article
  Future<List<MainAddModel>> getAllMainAds() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM MainAdd ORDER BY id DESC");
    List<MainAddModel> list = res.isNotEmpty ? res.map((c) => MainAddModel.fromJson(c)).toList() : [];
    return list;
  }

  //nombre de article
  Future<int?> countMainAds() async {
    var conexion = await database;
    final res = Sqflite.firstIntValue(await conexion.rawQuery("SELECT COUNT(*) FROM MainAdd"));
    return res;
  }

  //=================================================
  //===================== Ads ======================
  //=================================================

  //Insertion des news
  createAd(AdModel adModel) async {
    final db = await database;
    var batch = db.batch();
    await deleteAllAds().whenComplete(() async{
      batch.insert('Ads', adModel.toJson());
      await batch.commit(noResult: true, continueOnError: true);
    });

  }

  //Suppression des news
  Future<int?> deleteAllAds() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Ads');
    return res;
  }

  //Liste des news
  Future<List<AdModel>> getAllAds() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Ads ORDER BY id DESC");
    List<AdModel> list = res.isNotEmpty ? res.map((c) => AdModel.fromJson(c)).toList() : [];
    return list;
  }

  //nombre de news
  Future<int?> countAds() async {
    var conexion = await database;
    final res = Sqflite.firstIntValue(await conexion.rawQuery("SELECT COUNT(*) FROM Ads"));
    return res;
  }

  //=================================================
  //===================== Notifs ======================
  //=================================================

  //Insertion des news
  createNotif(NotifModel notifModel) async {
    final db = await database;
    var batch = db.batch();
    await deleteAllNotifs().whenComplete(() async{
      batch.insert('Notif', notifModel.toJson());
      await batch.commit(noResult: true, continueOnError: true);
    });

  }

  //Suppression des news
  Future<int?> deleteAllNotifs() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Notif');
    return res;
  }

  //Liste des news
  Future<List<NotifModel>> getAllNotifs() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Notif ORDER BY id DESC");
    List<NotifModel> list = res.isNotEmpty ? res.map((c) => NotifModel.fromJson(c)).toList() : [];
    return list;
  }

  //nombre de news
  Future<int?> countNotifs() async {
    var conexion = await database;
    final res = Sqflite.firstIntValue(await conexion.rawQuery("SELECT COUNT(*) FROM Notif"));
    return res;
  }

}
