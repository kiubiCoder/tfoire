import 'package:clientfoire/models/NotifModel.dart';
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


class NotifPage extends StatefulWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  _NotifPageState createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {

  //criteres de recherche
  String critere1 = "";
  //controllers de saaisie
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  //List<ExposantModel> ex = List.empty();
  //liste de base
  List<NotifModel> notifs = List.empty();
  List<NotifModel> searchResult = List.empty();

  @override
  void initState() {
    // TODO: implement initState
    main();
    setState(() {
      _chargeNotifs();
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
          'Notifications',
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
                onPressed: () => _fetchNotifsFromApi(),
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
                    TextField(
                      controller: controller1,
                      maxLength: 50,
                      decoration: InputDecoration(
                        labelText: "Titre/ Message, Date de la notification",
                        suffixIcon: Icon(LineIcons.search),
                      ),
                      //============== Action lors de la saisie
                      onChanged: (text){
                        critere1 =  removeDiacritics(text.toLowerCase());
                        setState(() {
                          //_changeIcon(critere1);
                          searchResult = notifs.where((a) {
                            var libelle = a.title?.toLowerCase();
                            var date = a.dateNotif?.toLowerCase();
                            var message = a.message?.toLowerCase();
                            return removeDiacritics(date!).contains(critere1)
                                || removeDiacritics(libelle!).contains(critere1)
                                || removeDiacritics(message!).contains(critere1);
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
                              _chargeNotifs();
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
                onRefresh: _NotifsRefresh,
                child: ListView.builder(
                    itemCount: searchResult.length,
                    itemBuilder: (context,index){
                       var redirectPage = searchResult[index].pageCible;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                        child: Column(
                          children: [
                            Card(
                              elevation: 0.01,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: (){
                                    Navigator.pushNamed(context, redirectPage.toString());
                                  },
                                  leading: Container(
                                    width: MediaQuery.of(context).size.width * 0.2,
                                    child: Icon(LineIcons.bellAlt)
                                  ),
                                  title: Text(searchResult[index].title.toString() != "" ? searchResult[index].title.toString() : "",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Text(searchResult[index].message.toString() != "" ? searchResult[index].message.toString() : "",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      Text(searchResult[index].dateNotif.toString() != "" ? searchResult[index].dateNotif.toString() : "",
                                        style: TextStyle(
                                          fontSize: 15.0,
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

  _chargeNotifs(){
    setState(() {
      DBProvider.db.getAllNotifs().then((value) {
        notifs = value;
        searchResult = notifs;
        if(value.isEmpty){
          Fluttertoast.showToast(
              msg: "Les notifications s'affichent ici!",
              backgroundColor: kDeepOrange.withOpacity(0.5),
              gravity: ToastGravity.CENTER
          );
        }
      });
    });
  }

  _fetchNotifsFromApi() async{
    var connexionState = await Connectivity().checkConnectivity();
    if(connexionState == ConnectivityResult.mobile || connexionState == ConnectivityResult.wifi){
      Fluttertoast.showToast(
          msg: "Nous contactons le serveur, pour la mise jour !",
          backgroundColor: kDeepOrange.withOpacity(0.5),
          gravity: ToastGravity.CENTER
      );
      DBProvider.db.deleteAllNotifs().whenComplete((){
        TfoireApiData().getNotificationsFromApi().whenComplete(() {
          Fluttertoast.showToast(
              msg: "Mise à jour terminée, actualisation...!",
              backgroundColor: kDeepOrange.withOpacity(0.5),
              gravity: ToastGravity.CENTER
          );
          Future.delayed(Duration(seconds: 5), (){
            setState(() {
              _chargeNotifs();
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
  Future _NotifsRefresh() async{
    //rechargement de la liste
    setState(() {
      DBProvider.db.getAllNotifs().then((value) {
        notifs = value;
        searchResult = notifs;
      }).whenComplete(() async{
        await Future.delayed(Duration(milliseconds: 1000));
        refreshController.refreshCompleted();
      });
    });
  }

}
