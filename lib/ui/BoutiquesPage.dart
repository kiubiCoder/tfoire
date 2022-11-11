import 'package:cached_network_image/cached_network_image.dart';
import 'package:clientfoire/models/ArticleModel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:clientfoire/utilitaires/Constants.dart';

import '../ApiServices/ApiServices.dart';
import '../database/DBProvider.dart';
import '../main.dart';

class BoutiquesPage extends StatefulWidget {
  const BoutiquesPage({Key? key}) : super(key: key);

  @override
  _BoutiquesPageState createState() => _BoutiquesPageState();
}

class _BoutiquesPageState extends State<BoutiquesPage> {

  //criteres de recherche
  String critere1 = "";
  String critere2 = "";
  String _selected = "Choisir un exposant";

  //controllers de saaisie
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  //List<ExposantModel> ex = List.empty();
  //liste de base
  List<ArticleModel> articles = List.empty();
  List<ArticleModel> searchResult = List.empty();

  @override
  void initState() {
    // TODO: implement initState
    main();
    setState(() {
       DBProvider.db.getAllExposant().then((e) => ex = e);
      _chargeArticles();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Nos articles',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0
          ),
        ),
        actions: [
          //Reccuperation des donnees depuis l'api'
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
                onPressed: () => _fetchArticlesFromApi(),
                icon: Icon(LineIcons.alternateSync)
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 0.2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 18.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(50.0)),
                ),
                child: Column(
                  children: [
                    DropdownButton(
                        isExpanded: true,
                        hint: Text(_selected.toString()),
                        items: ex.map((e){
                          return new DropdownMenuItem(
                            child: new Text(e.nom.toString(),),
                            value: e.nom.toString(),
                          );
                        }).toList(),
                        onChanged: (val){
                          critere2 = removeDiacritics(val.toString().toLowerCase());
                          setState(() {
                            _selected = val.toString();
                            searchResult = articles.where((a) {
                              var nom = a.exposant?.toLowerCase();
                              var libelle = a.libelle?.toLowerCase();
                              return removeDiacritics(nom!).contains(critere2) && removeDiacritics(libelle!).contains(critere1);
                            }).toList();
                          });
                        },
                    ),
                    TextField(
                      controller: controller1,
                      maxLength: 50,
                      decoration: InputDecoration(
                        labelText: "Entrez les mots clés d\'un article",
                        suffixIcon: Icon(LineIcons.search),
                      ),
                      //============== Action lors de la saisie
                      onChanged: (text){
                        critere1 =  removeDiacritics(text.toLowerCase());
                        setState(() {
                          //_changeIcon(critere1);
                          searchResult = articles.where((a) {
                            var nom = a.exposant?.toLowerCase();
                            var libelle = a.libelle?.toLowerCase();
                            return removeDiacritics(nom!).contains(critere2) && removeDiacritics(libelle!).contains(critere1);
                          }).toList();
                        });
                      },
                    ),
                  ],
                ) ,
              ),
            ),
          ),
          SizedBox(height: 15.0,),
          Expanded(
            child: _buldinglist(),
          )
        ],
      ),
    );
  }

  _buldinglist() {
    return FutureBuilder(
        future: DBProvider.db.getAllArticles(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasError){
            return Center(child: Text("${snapshot.error}"),);
          }else if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            if(searchResult.isEmpty){
              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Lottie.asset('assets/lotties/notfound.json',
                            repeat: false,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 80.0),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ElevatedButton(
                            onPressed: (){
                              _chargeArticles();
                              setState(() {
                                controller1.clear();
                                controller2.clear();
                              });
                            },
                            child: Text("Tout afficher",
                              style: TextStyle(
                                  color: kDeepOrange,
                                  fontSize: 18.0
                              ),
                            ),
                            style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(kDeepOrange),
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                                minimumSize: MaterialStateProperty.all( Size(15, 10))
                            ),
                          ),
                        )

                      ]
                  )
              );
            }else{
               return SmartRefresher(
                 enablePullDown: true,
                 //enablePullUp: true,
                 header: WaterDropHeader(
                   waterDropColor: kDeepOrange,
                 ),
                 controller: refreshController,
                 onRefresh: _articlesRefresh,
                 child: ListView.builder(
                    itemCount: searchResult.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                        child: Column(
                          children: [
                            Card(
                              elevation: 0.01,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Container(
                                    width: MediaQuery.of(context).size.width * 0.2,
                                    child: CachedNetworkImage(
                                      imageUrl: '${searchResult[index].articleImage}',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Image.asset(Logo_foire),
                                    ),
                                  ),
                                  title: Text(searchResult[index].libelle.toString() != "" ? searchResult[index].libelle.toString() : "",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  subtitle: Text(searchResult[index].exposant.toString() != "" ? searchResult[index].exposant.toString() : "",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                    ),
                                  ),
                                  trailing: Column(
                                    children: [
                                      Text(searchResult[index].prixBarre == "0"
                                          || searchResult[index].prixBarre == null
                                          ? ""
                                          : oCcy.format(double.tryParse(searchResult[index].prixBarre.toString())) + " Fcfa",
                                          style: TextStyle(
                                            decoration: TextDecoration.lineThrough,
                                            fontSize: 18.0,
                                          )
                                      ),
                                      Text(searchResult[index].prixBase != null
                                          ? oCcy.format(double.tryParse(searchResult[index].prixBase.toString())) + ' Fcfa'
                                          : "Prix sur demande",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.5,
                              child: Divider(
                                color: kDeepOrange,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                ),
              );
            }
          }
        }
    );
  }

  _chargeArticles(){
      setState(() {
        DBProvider.db.getAllArticles().then((value) {
          articles = value;
          searchResult = articles;
          if(value.isEmpty){
            Fluttertoast.showToast(
                msg: "Aucun article en vente pour le moment !",
                backgroundColor: kDeepOrange.withOpacity(0.5),
                gravity: ToastGravity.CENTER
            );
          }
        });
      });
  }

  _fetchArticlesFromApi() async{
    var connexionState = await Connectivity().checkConnectivity();
    if(connexionState == ConnectivityResult.mobile || connexionState == ConnectivityResult.wifi){
      Fluttertoast.showToast(
          msg: "Nous contactons le serveur, pour la mise jour !",
          backgroundColor: kDeepOrange.withOpacity(0.5),
          gravity: ToastGravity.CENTER
      );
      DBProvider.db.deleteAllArticle().whenComplete((){
        TfoireApiData().getAllArticlesFromApi().whenComplete(() {
          Fluttertoast.showToast(
              msg: "Mise à jour terminée, actualisation...!",
              backgroundColor: kDeepOrange.withOpacity(0.5),
              gravity: ToastGravity.CENTER
          );
          Future.delayed(Duration(seconds: 5), (){
            setState(() {
              _chargeArticles();
            });
          });
        }
        ).onError((error, stackTrace) => Fluttertoast.showToast(
            msg: "Il semble que le serveur sois indisponible, vérifiez votre connextion et réessayez svp !",
            backgroundColor: kDeepOrange.withOpacity(0.5),
            gravity: ToastGravity.CENTER
        ));
      });
    }
  }

  //rafraichissement
  Future _articlesRefresh() async{
    //rechargement de la liste
    setState(() {
      DBProvider.db.getAllArticles().then((value) {
        articles = value;
        searchResult = articles;
      }).whenComplete(() async{
        await Future.delayed(Duration(milliseconds: 1000));
        refreshController.refreshCompleted();
      });
    });
  }

}
