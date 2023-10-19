import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clientfoire/ApiServices/ApiServices.dart';
import 'package:clientfoire/database/DBProvider.dart';
import 'package:clientfoire/models/ExposantModel.dart';
import 'package:clientfoire/utilitaires/Constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:select_form_field/select_form_field.dart';

class ExposantsPage extends StatefulWidget {
  const ExposantsPage({Key? key}) : super(key: key);

  @override
  _ExposantsPageState createState() => _ExposantsPageState();
}

class _ExposantsPageState extends State<ExposantsPage> {

  //criteres de recherche
  String critere1 = "";
  String critere2 = "";

  //controllers de saaisie
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  //liste de base
  List<ExposantModel> exposants = List.empty();
  List<ExposantModel> searchResult = List.empty();

  @override
  void initState() {
    // TODO: implement initState
    _chargeExposants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Exposants',
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
                onPressed: (){
                  _fetchExposantsFromApi();
                  DBProvider.db.getAllExposant().then((value){
                    setState(() {
                      exposants = value;
                    });
                  });
                },
                icon: Icon(LineIcons.alternateSync)
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
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
                    SelectFormField(
                      controller: _controller2,
                      type: SelectFormFieldType.dropdown, // or can be dialog,
                      items: pavillonItems,
                      decoration: InputDecoration(
                        labelText: 'Trouvez les exposant d\'un pavillon',
                        suffixIcon: Icon(LineIcons.angleDown),
                        prefixIcon: IconButton(
                          icon: Icon(LineIcons.timesCircle),
                          onPressed: ()=>setState(() {
                            _controller2.clear();
                            if(_controller1 == ""){
                              _exposantsRefresh();
                            }
                          }),
                        )
                      ),
                      onChanged: (val){
                        critere2 = removeDiacritics(val.toLowerCase());
                        setState(() {
                          searchResult = exposants.where((a) {
                            var nom = a.nom?.toLowerCase() == null ? ' ' : a.nom?.toLowerCase();
                            var pavillon = a.pavillon?.toLowerCase() == null ? ' ' : a.pavillon?.toLowerCase();
                            return removeDiacritics(nom!).contains(critere1) && removeDiacritics(pavillon!).contains(critere2);
                          }).toList();
                        });
                      },
                    ),
                    TextField(
                      controller: _controller1,
                      maxLength: 50,
                      decoration: InputDecoration(
                        labelText: "Entrez un mot clé",
                        suffixIcon: Icon(LineIcons.search),
                        prefixIcon: IconButton(
                          icon: Icon(LineIcons.timesCircle),
                          onPressed: ()=>setState(() {
                            _controller1.clear();
                            if(_controller2 == ""){
                              _exposantsRefresh();
                            }
                          }),
                        )
                      ),
                      //============== Action lors de la saisie
                      onChanged: (text){
                        critere1 =  removeDiacritics(text.toLowerCase());
                        setState(() {
                          //_changeIcon(critere1);
                          searchResult = exposants.where((a) {
                            var nom = a.nom?.toLowerCase() == null ? ' ': a.nom?.toLowerCase();
                            var cate = a.categorie?.toLowerCase() == null ? ' ' : a.categorie?.toLowerCase();
                            var pav = a.pavillon?.toLowerCase() == null ? ' ' : a.pavillon?.toLowerCase();
                            return removeDiacritics(nom!).contains(critere1) || removeDiacritics(cate!).contains(critere1) || removeDiacritics(pav!).contains(critere1);
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
          Expanded(child: _buldinglist(),)
        ],
      )
    );
  }

  _buldinglist() {
    return FutureBuilder(
        future: DBProvider.db.getAllEvents(),
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
                          _chargeExposants();
                          setState(() {
                            _controller1.clear();
                            _controller2.clear();
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
                onRefresh: _exposantsRefresh,
                child: ListView.builder(
                    itemCount: searchResult.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.06),
                                      spreadRadius: 7,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  leading: Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    child: CachedNetworkImage(
                                      imageUrl: searchResult[index].brendImgLink.toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Image.asset(Logo_foire),
                                    ),
                                  ),
                                  title: Text(searchResult[index].nom.toString() != "" ? searchResult[index].nom.toString() : "",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(searchResult[index].presentation.toString() != "" ? searchResult[index].presentation.toString() : "",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () => makeCall(searchResult[index].tel.toString()),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.black12,
                                              child: Icon(LineIcons.phone, color: kDeepOrange),
                                            ),
                                          ),
                                          SizedBox(width: 15.0,),
                                          GestureDetector(
                                            onTap: (){
                                              Uri _url = Uri.parse(
                                                  "whatsapp://send?phone=" + searchResult[index].tel.toString() + "&text="
                                                      "Bonjour, je vous écris depuis l'application de la foire togo 2000 !"
                                              );
                                              myUrlLauncher(_url);
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Colors.black12,
                                              child: Icon(LineIcons.whatSApp, color: Colors.green,),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  trailing: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 25.0),
                                        child: Text(searchResult[index].pavillon != null
                                            ? searchResult[index].pavillon.toString() : "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            /*SizedBox(
                              width: MediaQuery.of(context).size.height * 0.5,
                              child: Divider(
                                color: kDeepOrange,
                              ),
                            ),*/
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

  _chargeExposants(){
    setState(() {
      _controller1.clear();
      _controller2.clear();
      DBProvider.db.getAllExposant().then((value) {
        exposants = value;
        searchResult = exposants;
        if(value.isEmpty){
          Fluttertoast.showToast(
              msg: "La liste des exposants sera bientôt disponible !",
              backgroundColor: kDeepOrange.withOpacity(0.5),
              gravity: ToastGravity.CENTER
          );
        }
      });
    });
  }

  _fetchExposantsFromApi() async{
    var connexionState = await Connectivity().checkConnectivity();
    if(connexionState == ConnectivityResult.mobile || connexionState == ConnectivityResult.wifi){
      Fluttertoast.showToast(
          msg: "Nous contactons le serveur, pour la mise jour !",
          backgroundColor: kDeepOrange.withOpacity(0.5),
          gravity: ToastGravity.CENTER
      );
      DBProvider.db.deleteAllExposants().whenComplete((){
        TfoireApiData().getExposantsFromApi().whenComplete(() {
          Fluttertoast.showToast(
              msg: "Mise à jour terminée, actualisation...!",
              backgroundColor: kDeepOrange.withOpacity(0.5),
              gravity: ToastGravity.CENTER
          );
          Future.delayed(Duration(seconds: 5), (){
            setState(() {
              _chargeExposants();
            });
          });
        }
        ).onError((error, stackTrace) => Fluttertoast.showToast(
            msg: "Il semble que le serveur sois indisponible, vérifiez votre connextion et réessayez svp !",
            backgroundColor: kDeepOrange.withOpacity(0.5),
            gravity: ToastGravity.CENTER
        ));
      });
    }else{
      Fluttertoast.showToast(
          msg: "Une connexion est nécessaire pour effectuer cette action...!",
          backgroundColor: kDeepOrange.withOpacity(0.5),
          gravity: ToastGravity.CENTER
      );
    }
  }

  //rafraichissement
  Future _exposantsRefresh() async{
    //rechargement de la liste
    setState(() {
      _controller1.clear();
      _controller2.clear();
      DBProvider.db.getAllExposant().then((value) {
        exposants = value;
        searchResult = exposants;
      }).whenComplete(() async{
        await Future.delayed(Duration(milliseconds: 1000));
        refreshController.refreshCompleted();
      });
    });
  }

}
