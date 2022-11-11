import 'package:clientfoire/ApiServices/ApiServices.dart';
import 'package:clientfoire/database/DBProvider.dart';
import 'package:clientfoire/models/NewModel.dart';
import 'package:clientfoire/utilitaires/Constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';
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
                            child: ListTile(
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(events[index].jour.toString(),style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black26
                                  ),),
                                  Text(events[index].annee.toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.black26
                                    ),
                                  ),
                                ],
                              ),
                              title: Text(events[index].title.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  //fontSize: 20,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              subtitle: Column(
                                children: [
                                  SizedBox(
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
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: ReadMoreText(
                                      events[index].libelle.toString(),
                                      trimLines: 2,
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
                                        color: kDeepOrangeSelf,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0,
                                      ),
                                      lessStyle: TextStyle(
                                        color: kDeepOrangeSelf,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: Divider(
                              color: kDeepOrange,
                            ),
                          ),
                        ],
                      );
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
      DBProvider.db.deleteAllExposants().whenComplete((){
        TfoireApiData().getExposantsFromApi().whenComplete(() {
          Fluttertoast.showToast(
              msg: "Mise à jour terminée, veuillez rafraichir la liste !",
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
