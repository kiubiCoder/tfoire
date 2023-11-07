import 'package:cached_network_image/cached_network_image.dart';
import 'package:clientfoire/database/DBProvider.dart';
import 'package:clientfoire/models/InfoPratiqueModel.dart';
import 'package:clientfoire/utilitaires/Constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';

import '../ApiServices/ApiServices.dart';

class InfosPratiquePage extends StatefulWidget {
  const InfosPratiquePage({Key? key}) : super(key: key);

  @override
  _InfosPratiquePageState createState() => _InfosPratiquePageState();
}

class _InfosPratiquePageState extends State<InfosPratiquePage> {

  List<InfoPratiqueModel> listInfoPratique = List.empty();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _chargeInfoPratiques();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // foregroundColor: kDeepOrangeSelf,
        // backgroundColor: Colors.white10,
        elevation: 0.0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Infos',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white
              ),
            ),
            const Text(
              ' Pratiques',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white
              ),
            ),
          ],
        ),
        actions: [
          //button icon pour page a propos
          AboutButton(context),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
                onPressed: (){
                  _fetchInfosPratiquesFromApi();
                  DBProvider.db.getAllInfosPratiques().then((value){
                    setState(() {
                      listInfoPratique = value;
                    });
                  });
                },
                icon: Icon(LineIcons.alternateSync)
            ),
          )
        ],
      ),
      body: _buldinglist(),
    );
  }

  _buldinglist() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/coloredBack.png")
          ),
      ),
      child: FutureBuilder(
          future: DBProvider.db.getAllInfosPratiques(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasError){
              return Center(child: Text("${snapshot.error}"),);
            }else if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
              if(listInfoPratique.isEmpty){
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
                                setState(() {
                                  _chargeInfoPratiques();
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
                  onRefresh: _chargeInfoPratiques,
                  child: ListView.builder(
                      itemCount: listInfoPratique.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:  Container(
                                    margin: EdgeInsets.only(top: 25,left: 8.0,right: 8.0),
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
                                      leading: Icon(LineIcons.handPointingRight,),
                                      title: Text(listInfoPratique[index].titre.toString() != null ? listInfoPratique[index].titre.toString() : "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20.0,
                                            color: kTextGray
                                        ),
                                      ),
                                      subtitle: ReadMoreText(
                                        listInfoPratique[index].details.toString() != null ? listInfoPratique[index].details.toString() : "",
                                        trimLines: 5,
                                        style: TextStyle(
                                            fontSize: 18.0
                                        ),
                                        postDataTextStyle: TextStyle(
                                          color: kDeepOrangeSelf,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        preDataTextStyle: TextStyle(
                                            color: kDeepOrangeSelf,
                                            fontWeight: FontWeight.w400
                                        ),
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: '  Lire plus',
                                        trimExpandedText: '   Réduire',
                                        moreStyle: TextStyle(
                                          color: kClearMaroon,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18.0,
                                        ),
                                        lessStyle: TextStyle(
                                          color: kClearMaroon,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                );
              }
            }
          }
      ),
    );
  }

  _chargeInfoPratiques() {
    setState(() {
      DBProvider.db.getAllInfosPratiques().then((value) {
        listInfoPratique = value;
        if(value.isEmpty){
          Fluttertoast.showToast(
              msg: "Informations bientôt disponible !",
              backgroundColor: kDeepOrange.withOpacity(0.5),
              gravity: ToastGravity.CENTER
          );
        }
      });
    });
  }

  _fetchInfosPratiquesFromApi() async {
    var connexionState = await Connectivity().checkConnectivity();
    if(connexionState == ConnectivityResult.mobile || connexionState == ConnectivityResult.wifi){
      Fluttertoast.showToast(
          msg: "Nous contactons le serveur, pour la mise jour !",
          backgroundColor: kDeepOrange.withOpacity(0.5),
          gravity: ToastGravity.CENTER
      );
      DBProvider.db.deleteAllInfosPratique().whenComplete((){
        TfoireApiData().getInfosPratiques().whenComplete(() {
          Fluttertoast.showToast(
              msg: "Actualisation...!",
              backgroundColor: kDeepOrange.withOpacity(0.5),
              gravity: ToastGravity.CENTER
          );
          Future.delayed(Duration(seconds: 5), (){
            setState(() {
              _chargeInfoPratiques();
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

}


