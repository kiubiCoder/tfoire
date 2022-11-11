import 'package:clientfoire/Models/AgendaModel.dart';
import 'package:clientfoire/database/DBProvider.dart';
import 'package:clientfoire/utilitaires/Constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:date_format/date_format.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../ApiServices/ApiServices.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {

  String critere1 = "";
  final TextEditingController controller1 = TextEditingController();

  //date actuelle
  DateTime selectedDate = DateTime.now();
  //definition de l'intervale de temps
  final firstDate = DateTime(2022,10,20);
  final lastDate = DateTime(2022,12,31);


  //lists
  List<AgendaModel> events = List.empty();
  List<AgendaModel> searchResult = List.empty();


  @override
  void initState() {
    // TODO: implement initState
    _chargeEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Calendrier de la foire',
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
                onPressed: () => _fetchEventsFromApi(),
                icon: Icon(LineIcons.alternateSync)
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
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
                      TextField(
                        controller: controller1,
                        maxLength: 50,
                        decoration: InputDecoration(
                          labelText: "Entrez les mots clés",
                          suffixIcon: Icon(LineIcons.search),
                        ),
                        //============== Action lors de la saisie
                        onChanged: (text){
                          critere1 =  removeDiacritics(text.toLowerCase());
                          setState(() {
                            //_changeIcon(critere1);
                            searchResult = events.where((a) {
                              var titre = a.titre?.toLowerCase();
                              var date = a.date?.toLowerCase();
                              return removeDiacritics(titre!).contains(critere1) || date!.toString().contains(selectedDate.toString());
                            }).toList();
                          });
                        },
                      ),
                      SizedBox(height: 15.0,),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(kDeepOrange),
                          ),
                          onPressed: () => _OpenDatePicker(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(LineIcons.calendar),
                              Text(formatDate(selectedDate, [yyyy, '-' , mm , '-' , dd])),
                            ],
                          )
                      ),
                    ],
                  ) ,
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            Expanded(
                child: _buldinglist()
            )
          ],
        )
      )
    );
  }

  _buldinglist() {
    return FutureBuilder(
        future: DBProvider.db.getAllEvents(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"),);
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (searchResult.isEmpty) {
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
                              _chargeEvents();
                              setState(() {
                                controller1.clear();
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
            } else {
              return SmartRefresher(
                enablePullDown: true,
                //enablePullUp: true,
                header: WaterDropHeader(
                  waterDropColor: kDeepOrange,
                ),
                controller: refreshController,
                onRefresh: _refreshEvents,
                child: ListView.builder(
                    itemCount: searchResult.length,
                    itemBuilder: (context,index){
                      return Card(
                        elevation: 0.2,
                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05,
                            vertical: MediaQuery.of(context).size.height * 0.005),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8.0),
                          leading: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.22,
                            child: Container(
                              // color: kDeepOrange,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Text('${searchResult[index].date != null ? searchResult[index].date : "" }',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('${searchResult[index].time != null ? searchResult[index].time : ""}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          title: Text('${searchResult[index].titre != null ? searchResult[index].titre : ""}',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                                color: kDeepOrange
                            ),
                          ),
                          subtitle: Text('${searchResult[index].libelle != null ? searchResult[index].libelle : ""}'),
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

  //selecteur de date
  _OpenDatePicker(BuildContext context) async{
    final DateTime? now = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      selectedDate = now!;
      String comp = formatDate(selectedDate, [yyyy, '-' , mm , '-' , dd]);
      print(comp);
      searchResult = events.where((e){
        var date = e.date?.toLowerCase();
        return removeDiacritics(date!).contains(comp.toString());
      }).toList();
    });
  }

  _chargeEvents(){
    setState(() {
      DBProvider.db.getAllEvents().then((value) {
        events = value;
        searchResult = events;
        if(value.isEmpty){
          Fluttertoast.showToast(
              msg: "Aucun évenement programmé pour le moment !",
              backgroundColor: kDeepOrange.withOpacity(0.5),
              gravity: ToastGravity.CENTER
          );
        }
      });
    });
  }

  _fetchEventsFromApi() async {
    var connexionState = await Connectivity().checkConnectivity();
    if (connexionState == ConnectivityResult.mobile ||
        connexionState == ConnectivityResult.wifi) {
      Fluttertoast.showToast(
          msg: "Nous contactons le serveur, pour la mise jour !",
          backgroundColor: kDeepOrange.withOpacity(0.5),
          gravity: ToastGravity.CENTER
      );
      DBProvider.db.deleteAllEvents().whenComplete((){
        TfoireApiData().getAgendaFromApi().whenComplete(() {
          Fluttertoast.showToast(
              msg: "Mise à jour terminée, actualisation...!",
              backgroundColor: kDeepOrange.withOpacity(0.5),
              gravity: ToastGravity.CENTER
          );
          Future.delayed(Duration(seconds: 5), (){
            setState(() {
              _chargeEvents();
            });
          });
        }
        ).onError((error, stackTrace) =>
          Fluttertoast.showToast(
              msg: "Il semble que le serveur sois indisponible, vérifiez votre connexion et réessayez svp !",
              backgroundColor: kDeepOrange.withOpacity(0.5),
              gravity: ToastGravity.CENTER
          )
        );
      });
    }
  }

  //rafraichissement
  Future _refreshEvents() async {
    //rechargement de la liste
    setState(() {
      DBProvider.db.getAllEvents().then((value) {
        events = value;
        searchResult = events;
      }).whenComplete(() async {
        await Future.delayed(Duration(milliseconds: 1000));
        refreshController.refreshCompleted();
      });
    });
  }

}


