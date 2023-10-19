import 'package:cached_network_image/cached_network_image.dart';
import 'package:clientfoire/models/GallerieModel.dart';
import 'package:clientfoire/utilitaires/Constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../ApiServices/ApiServices.dart';
import '../database/DBProvider.dart';
import '../main.dart';


class GalleriePage extends StatefulWidget {
  const GalleriePage({Key? key}) : super(key: key);

  @override
  _GalleriePageState createState() => _GalleriePageState();
}


class _GalleriePageState extends State<GalleriePage> {

  //criteres de recherche
  String critere1 = "";
  String _selected = "Choisir un exposant";

  final TextEditingController _controller1 = TextEditingController();

  //List<ExposantModel> ex = List.empty();
  List<GalleryModel> photos = List.empty();
  List<GalleryModel> searchResult = List.empty();
  // late int tofIndex;

  @override
  void initState() {
    // TODO: implement initState
    main();
    setState(() {
      DBProvider.db.getGallerieExposants().then((e) => galExpo = e);
      _chargeGallerie();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.deepOrange.shade50,
      appBar: AppBar(
        // backgroundColor: Colors.white10,
        // foregroundColor: kDeepOrange,
        elevation: 0.0,
        centerTitle: true,
        title: Text("Gallerie",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              //color: Colors.black54
          ),
        ),
        actions: [
            //Reccuperation des donnees depuis l'api'
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
                onPressed: () => _fetchGallerieFromApi(),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50.0)),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                             _selected = "Choisir un exposant";
                             _refreshGallerie();
                            });
                          },
                          icon: Icon(LineIcons.timesCircle)
                      ),
                      Expanded(
                        child: DropdownButton(
                          isExpanded: true,
                          hint:  Text(_selected.toString()),
                          items: galExpo.map((e){
                            return new DropdownMenuItem(
                              child: new Text(e.exposant.toString(),),
                              value: e.exposant.toString(),
                            );
                          }).toList(),
                          onChanged: (val){
                            critere1 = removeDiacritics(val.toString().toLowerCase());
                            setState(() {
                              _selected = val.toString();
                              searchResult = photos.where((a) {
                                var nom = a.exposant?.toLowerCase();
                                return removeDiacritics(nom!).contains(critere1);
                              }).toList();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0,),
            Expanded(
              child: _buldinglist(),
            ),
          ],
        ),
      ),
    );
  }

  _buldinglist() {
    return FutureBuilder(
        future: DBProvider.db.getAllPhotos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: SnackBar(
                  content: Text("Erreur de chargement des données"),
                  backgroundColor: kYellow,
                )
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
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
                              _chargeGallerie();
                              setState(() {
                                _selected = "Choisir un exposant";
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
                onRefresh: _refreshGallerie,
                child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery
                        .of(context)
                        .size
                        .width * 0.03),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 15.0
                    ),
                    itemCount: searchResult.length,
                    itemBuilder: (context, index) {
                      var tofIndex = index;
                      var id = searchResult[index].id;
                      return Hero(
                        tag: 'logo$id',
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => GalleryWidget(
                                    photos: photos,
                                    index: tofIndex,
                                  ),
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
                            child: CachedNetworkImage(
                              imageUrl: '${searchResult[index].photoLink}',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(Logo_foire),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
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

  _chargeGallerie() {
    //photos
    DBProvider.db.getAllPhotos().then((value) {
      photos = value;
      searchResult = photos;
      if(value.isEmpty){
        Fluttertoast.showToast(
            msg: "Pas de nouvelles images publiées !",
            backgroundColor: kDeepOrange.withOpacity(0.5),
            gravity: ToastGravity.CENTER
        );
      }
    });
  }

  _fetchGallerieFromApi() async {
    var connexionState = await Connectivity().checkConnectivity();
    if(connexionState == ConnectivityResult.mobile || connexionState == ConnectivityResult.wifi){
      Fluttertoast.showToast(
          msg: "Nous contactons le serveur, pour la mise jour !",
          backgroundColor: kDeepOrange.withOpacity(0.5),
          gravity: ToastGravity.CENTER
      );
      DBProvider.db.deleteAllExposants().whenComplete((){
        TfoireApiData().getGalleryFromApi().whenComplete(() {
          Fluttertoast.showToast(
              msg: "Mise à jour terminée, actualisation...!",
              backgroundColor: kDeepOrange.withOpacity(0.5),
              gravity: ToastGravity.CENTER
          );
          Future.delayed(Duration(seconds: 5), (){
            setState(() {
              _chargeGallerie();
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
  Future _refreshGallerie() async {
    //rechargement de la liste
    setState(() {
      //_fetchGallerieFromApi();
      DBProvider.db.getAllPhotos().then((value) {
        photos = value;
        searchResult = photos;
      }).whenComplete(() async {
        await Future.delayed(Duration(milliseconds: 1000));
        refreshController.refreshCompleted();
      });
    });
  }
}

class GalleryWidget extends StatefulWidget {
  final PageController pageController;
  final List<GalleryModel> photos;
  final int index;

  GalleryWidget({
    required this.photos,
    this.index = 0, }):pageController = PageController(initialPage: index);

  @override
  _GalleryWidgetState createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {

  late int index = widget.index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white10,
        // foregroundColor: kDeepOrange,
        elevation: 0.0,
        centerTitle: true,
        title: Text("Gallerie",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            //color: Colors.black54
          ),
        ),
      ),
      backgroundColor: Colors.white,
        floatingActionButton: GestureDetector(
          child: Container(
            child: Text('${widget.photos[index].exposant}',
              style: TextStyle(
                // color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),
            )
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            PhotoViewGallery.builder(
              backgroundDecoration: BoxDecoration(
                color: Colors.white,
              ),
              pageController: widget.pageController,
              itemCount: widget.photos.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(widget.photos[index].photoLink.toString()),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 4,
                );
              },
              onPageChanged: (index) => setState(() => this.index = index),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Image: ${index + 1} / ${widget.photos.length}',
                style: TextStyle(
                    // color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400
                ),
              ),
            ),
          ]
        )
    );
  }
}
