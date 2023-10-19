import 'package:clientfoire/ApiServices/ApiServices.dart';
import 'package:clientfoire/database/DBProvider.dart';
import 'package:clientfoire/models/NewModel.dart';
import 'package:clientfoire/utilitaires/Constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'DetailNews.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  List<NewModel> events = List.empty();

  @override
  void initState() {
    //TfoireApiData().getNewsFromApi();

    // TODO: implement initState
    setState(() {
      _chargeNews();
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
              'Dernières',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white
              ),
            ),
            const Text(
              ' Nouvelles',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white
              ),
            ),
          ],
        ),
        actions: [
          //Reccuperation des donnees depuis l'api'
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
                onPressed: () => _fetchNewsFromApi(),
                icon: Icon(LineIcons.alternateSync)
            ),
          ),

        ],
      ),
      body: Column(
        children: <Widget> [
          SizedBox(height: 15.0,),
          Expanded(child: _buldinglist(),)
        ],
      ),
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
            return SmartRefresher(
              enablePullDown: true,
              //enablePullUp: true,
              header: WaterDropHeader(
                waterDropColor: kDeepOrange,
              ),
              controller: refreshController,
              onRefresh: _newsRefresh,
              child: ListView.builder(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                  itemCount: events.length,
                  itemBuilder: (context,index){
                    dynamic data = events[index];
                    String id = '${events[index].id}';
                    if(events.length ==0){
                      return CircularProgressIndicator();
                    }else{
                      if(events.isEmpty){
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
                                          _chargeNews();
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
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (_) => NewsDetails(id: id, data: data)
                                    )
                                );
                              },
                              child: Container(
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
                                    trailing: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(events[index].jour.toString(),style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black26
                                        ),),
                                        Text('2023',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.black26
                                          ),
                                        ),/*Text(events[index].annee.toString(),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.black26
                                          ),
                                        ),*/
                                      ],
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(events[index].title.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    subtitle: Column(
                                      children: [
                                        Container(
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 1.0,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: CachedNetworkImage(
                                                imageUrl: events[index].image1.toString(),
                                                placeholder: (context, url) => Icon(LineIcons.image,
                                                  color: Colors.black54,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ),
                            ),
                            /*SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: Divider(
                              color: kDeepOrange,
                            ),
                          ),*/
                          ],
                        );
                      }

                    }
                  }
              ),
            );
          }
        }
    );
  }

  _chargeNews(){
    setState(() {
      DBProvider.db.getAllNews().then((value) {
        events = value;
      });
    });
  }

  _fetchNewsFromApi() async{
    var connexionState = await Connectivity().checkConnectivity();
    if(connexionState == ConnectivityResult.mobile || connexionState == ConnectivityResult.wifi){
      Fluttertoast.showToast(
          msg: "Nous contactons le serveur, pour la mise jour !",
          backgroundColor: kDeepOrange.withOpacity(0.5),
          gravity: ToastGravity.CENTER
      );
      DBProvider.db.deleteAllNews().whenComplete((){
        TfoireApiData().getNewsFromApi().whenComplete(() {
          Fluttertoast.showToast(
              msg: "Actualisation ... !",
              backgroundColor: kDeepOrange.withOpacity(0.5),
              gravity: ToastGravity.CENTER
          );
          Future.delayed(Duration(seconds: 5), (){
            setState(() {
              _chargeNews();
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
  Future _newsRefresh() async{
    //rechargement de la liste
    setState(() {
      DBProvider.db.getAllNews().then((value) {
        events = value;
      }).whenComplete(() async{
        await Future.delayed(Duration(milliseconds: 1000));
        refreshController.refreshCompleted();
      });
    });
  }

}
