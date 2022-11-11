import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clientfoire/utilitaires/Constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share/share.dart';
import '../database/DBProvider.dart';
import '../models/GallerieModel.dart';

class GalleryDetails extends StatefulWidget {

  var photo;
  var id;
  GalleryDetails({Key? key, required this.photo, required this.id}) : super(key: key);

  @override
  State<GalleryDetails> createState() => _GalleryDetailsState();
}

class _GalleryDetailsState extends State<GalleryDetails> {

  //lists de gallery
  List<GalleryModel> photos = List.empty();
  List<GalleryModel> searchResult = List.empty();
  String nomPhoto = "";
  String myPhotoLink = "";
  var firstIndex ;

  get id => null;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _chargeGallerie();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: kDeepOrange,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 3.0,
                        blurRadius: 10.0,
                      )
                    ]
                ),
                child: Icon(LineIcons.angleLeft,size: 20,color: Colors.white,),
              ),
            ),
          ),
         //boutton de partage des images
         /* Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Share.share("Foire togo 2000\n\n" + myPhotoLink, subject: myPhotoLink);
              },
              child: Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: kDeepOrange,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 3.0,
                        blurRadius: 10.0,
                      )
                    ]
                ),
                child: Icon(Icons.share,size: 20,color: Colors.white,),
              ),
            ),
          ),*/
        ],
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white12,
        toolbarTextStyle: TextStyle(
          color: kDeepOrange,
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Hero(
              tag: 'logo$id',
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: CarouselSlider.builder(
                      itemCount: photos.length,
                      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                          CachedNetworkImage(
                            placeholder: (context, url) => Image.asset(photos[widget.id].photoLink.toString()),
                            errorWidget: (context, url, error) => Image.asset(photos[widget.id].photoLink.toString()),
                            fit: BoxFit.contain,
                            imageUrl: photos[itemIndex].photoLink.toString(),
                          ),
                      options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              nomPhoto = photos[index].exposant.toString();
                              myPhotoLink = photos[index].photoLink.toString();
                            });
                          },
                          pageSnapping: true,
                          pauseAutoPlayOnTouch: true,
                          height: MediaQuery.of(context).size.height * 0.80,
                          aspectRatio: 16/9,
                          viewportFraction: 1,
                          initialPage: widget.id,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 10),
                          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                          autoPlayCurve: Curves.easeInOut,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          pauseAutoPlayOnManualNavigate: true
                      )
                  )
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(nomPhoto != "" || nomPhoto != null
                          ? nomPhoto
                          : "",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black26,
                          fontFamily: "Gill Sans",
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _chargeGallerie() {
    //photos
    DBProvider.db.getAllPhotos().then((value) {
      photos = value;
      searchResult = photos;
      if(value.isEmpty){
        Fluttertoast.showToast(
            msg: "Images de la 17 foire bientôt disponibles !",
            backgroundColor: kDeepOrange.withOpacity(0.5),
            gravity: ToastGravity.CENTER
        );
      }
    });
  }

}

