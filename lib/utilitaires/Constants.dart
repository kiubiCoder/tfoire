import 'package:clientfoire/ApiServices/ApiServices.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:clientfoire/Ui/AboutPage.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../database/DBProvider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';






//=nouvelle charte graphique

const kTextGray = Color(0XFF000000);
const kDarkGreen = Color(0XFF3D7C47);
const kYellow = Color(0XFFfc200);
const kDarkMaroon = Color(0XFF009152);
const kDeepOrange = Color(0XFF009152);
const kClearMaroon = Color(0XFFe30512);
const kVermillon = Color(0XFFE94F49);
const kDeepOrangeSelf = Color(0XFF841400);
const kFloozback = Color(0XFFEC6607);
const kTmoneyback = Color(0XFFFADB16);

//Ancienne charte graphique

/*const kTextGray = Color(0XFFB8B8B8);
const kDarkGreen = Color(0XFF3D7C47);
const kYellow = Color(0XFF841400);
const kDarkMaroon = Color(0XFF4E0C03);
const kDeepOrange = Color(0XFF603913);
const kClearMaroon = Color(0XFF841400);
const kVermillon = Color(0XFFE94F49);
const kDeepOrangeSelf = Color(0XFF841400);
const kFloozback = Color(0XFFEC6607);
const kTmoneyback = Color(0XFFFADB16);*/

//22200060094892




final oCcy = new NumberFormat("#,###", "en_US");

//contacts
final String telAssistance = '+22893022193';
final String whatsappAssistance = '+22893022193';
final String APP_VERSION = "1.0.2";
final String Copyright = "Copyright @ CETEF 2022";
String PREFKEY = 'appState';
String Logo_foire = 'assets/images/cetef.png';

//odda
//final String API_BASE_URL = 'http://192.168.1.127:5500/Api/v1/togo2000/';
//dsi
//final String API_BASE_URL = 'http://10.10.21.52:5500/Api/v1/togo2000/';
//distant
final String API_BASE_URL = 'http://161.97.109.219:5500/Api/v1/togo2000/';

//lancement d'url
Future myUrlLauncher(Uri url) async {
  if (!await launchUrl(url)) {
    Fluttertoast.showToast(
        msg: "Impossible d'ouvrir le lien $url",
        backgroundColor: kDeepOrange.withOpacity(0.5),
        gravity: ToastGravity.CENTER
    );
  }
}

//fonction d'appel direct
makeCall(String numTel) async {
  await FlutterPhoneDirectCaller.callNumber(numTel);
}

RefreshController refreshController = RefreshController(initialRefresh: false);

void onRefresh() async{
  // monitor network fetch
  await Future.delayed(Duration(milliseconds: 1000));
  // if failed,use refreshFailed()
  refreshController.refreshCompleted();
}

Future isConnected(context) async{
  var connexionState = await (Connectivity().checkConnectivity());
  //si connecte mais aucune donnee en locale
  if(connexionState == ConnectivityResult.mobile || connexionState == ConnectivityResult.wifi){
    //chargement de donnees depuis l'api
    LoadAllPrimaryDataNew(context);
  }else{
    AlertDialog(
      title: Text("Erreur de reccupération des données"),
      actions: [
        TextButton(
          child: const Text('Fermer',
            style: TextStyle(
                color: kDeepOrange
            ),
          ),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    print("JE NE SUIS PAS CONNECTE");
  }
}

//Fonction de chargement des donnees de l'api
void  LoadAllPrimaryDataNew(context) async{
  //tailles des donnees de l'api
  int tailleExposants=0;
  int tailleEvents=0;
  int tailleNews=0;
  int tailleGallery=0;
  int tailleAds=0;
  int tailleArticles=0;
  int tailleMainAd=0;
  int tailleInfosPratique = 0;

  //tailles des donnees en locale
  int? tailleExposantsLocale=0;
  int? tailleEventsLocale=0;
  int? tailleNewsLocale=0;
  int? tailleGalleryLocale=0;
  int? tailleAdsLocale=0;
  int? tailleArticleLocale=0;
  int? tailleMainAdLocale=0;
  int? tailleInfosPratiqueLocale = 0;

  await Future.wait([
    TfoireApiData().getExposantsFromApi(),
    TfoireApiData().getAgendaFromApi(),
    TfoireApiData().getNewsFromApi(),
    TfoireApiData().getGalleryFromApi(),
    TfoireApiData().getAllAdsFromApi(),
    TfoireApiData().getAllArticlesFromApi(),
    TfoireApiData().getMainAd(),
    TfoireApiData().getInfosPratiques(),
  ]).then((response) {
    tailleExposants  = response[0].length;
    tailleEvents  = response[1].length;
    tailleNews  = response[2].length;
    tailleGallery  = response[3].length;
    tailleAds  = response[4].length;
    tailleArticles  = response[5].length;
    tailleMainAd  = response[6].length;
  },
      onError: (err) {
        Fluttertoast.showToast(
          msg: "Une erreur est survenue lors du contacte de l'API",
          backgroundColor: Colors.deepOrange.withOpacity(0.8),
          gravity: ToastGravity.BOTTOM,
        );
      }).whenComplete(() async{

    //reccuperation des donnees stockees dans la base locale
    tailleExposantsLocale  = await DBProvider.db.countExposant();
    tailleEventsLocale  = await DBProvider.db.countEvents();
    tailleNewsLocale  = await DBProvider.db.countNews();
    tailleGalleryLocale = await DBProvider.db.countGallery();
    tailleAdsLocale = await DBProvider.db.countAds();
    tailleArticleLocale = await DBProvider.db.countArticles();
    tailleMainAdLocale = await DBProvider.db.countMainAds();


    //print("Fin de chargement ");

    //print("=== Tailles telechargees ");
    // print(tailleExposants);
    // print(tailleEvents);
    // print(tailleNews);
    // print(tailleGallery);
    // print(tailleAds);
    // print(tailleArticles);
    // print(tailleMainAdLocale);

    //print("=== Tailles locales");
    // print(tailleExposantsLocale);
    // print(tailleEventsLocale);
    // print(tailleNewsLocale);
    // print(tailleGalleryLocale);
    // print(tailleAdsLocale);
    // print(tailleArticleLocale);
    // print(tailleMainAd);

    //cheick si les donees recues sont au meme nombre que celles inserees dans la base
    if(tailleEvents == await tailleEventsLocale ||
        tailleExposants == await tailleExposantsLocale ||
        tailleNews == await tailleNewsLocale || tailleAds == tailleAdsLocale){

      Fluttertoast.showToast(
        msg: "Chargement terminé !",
        backgroundColor: Colors.deepOrange.withOpacity(0.8),
        gravity: ToastGravity.BOTTOM,
      );

      //initiatialisation de shared preferences
      final prefs = await SharedPreferences.getInstance();

      //definition de l'etat du sharepref
      await prefs.setBool(PREFKEY, true);
      bool? etat = prefs.getBool(PREFKEY);
      print("Valeur prefs changer ======= $etat");

      Navigator.pushReplacementNamed(context, 'home');
    }

  });

}

//widget de la page A propos
Widget AboutButton(context) => IconButton(
  padding: const EdgeInsets.only(right: 15.0),
  icon: const Icon(LineIcons.infoCircle),
  onPressed: (){
      Navigator.push(context,MaterialPageRoute(
          builder: (_) => const AboutPage()
      )
    );
  },
);


//pavillons
final List<Map<String, dynamic>> pavillonItems = [
  {
    'value': 'agou',
    'label': 'Pavillon AGOU',
    'icon': Icon(Icons.check,color: Colors.deepOrange,),
    'textStyle': TextStyle(color: kDeepOrange),
  },
  {
    'value': 'fazao',
    'label': 'Pavillon FAZAO',
    'icon': Icon(Icons.check,
      color: Colors.deepOrange,
    ),
    'textStyle': TextStyle(color: kDeepOrange),
  },
  {
    'value': 'mono',
    'label': 'Pavillon MONO',
    'icon': Icon(Icons.check,color: Colors.deepOrange,),
    'textStyle': TextStyle(color: kDeepOrange),
  },
  {
    'value': 'Oti',
    'label': 'Pavillon OTI',
    'icon': Icon(Icons.check,color: Colors.deepOrange,),
    'textStyle': TextStyle(color: kDeepOrange),
  },
  {
    'value': 'haho',
    'label': 'Gallerie HAHO',
    'icon': Icon(Icons.check,color: Colors.deepOrange,),
    'textStyle': TextStyle(color: kDeepOrange),
  },
  {
    'value': 'kara',
    'label': 'Gallerie KARA',
    'icon': Icon(Icons.check,color: Colors.deepOrange,),
    'textStyle': TextStyle(color: kDeepOrange),
  },
  {
    'value': 'restauration',
    'label': 'Restauration',
    'icon': Icon(Icons.check,color: Colors.deepOrange,),
    'textStyle': TextStyle(color: kDeepOrange),
  },
  {
    'value': 'shopping',
    'label': 'Espace shopping',
    'icon': Icon(Icons.check,color: Colors.deepOrange,),
    'textStyle': TextStyle(color: kDeepOrange),
  },
  {
    'value': 'kiosques',
    'label': 'Kiosques',
    'icon': Icon(Icons.check,color: Colors.deepOrange,),
    'textStyle': TextStyle(color: kDeepOrange),
  },
  {
    'value': 'cetef',
    'label': 'CETEF',
    'icon': Icon(Icons.check,color: Colors.deepOrange,),
    'textStyle': TextStyle(color: kDeepOrange),
  },
];

Future timeBaseUpdateJob() async{
  var connexionState = await Connectivity().checkConnectivity();
  if(connexionState == ConnectivityResult.mobile || connexionState == ConnectivityResult.wifi){
    DBProvider.db.deleteAllExposants().whenComplete((){
      DBProvider.db.deleteAllEvents().whenComplete((){
        DBProvider.db.deleteAllPhotos().whenComplete((){
          DBProvider.db.deleteAllArticle().whenComplete((){
            DBProvider.db.deleteAllAds().whenComplete((){
              TfoireApiData().getExposantsFromApi().whenComplete((){
                TfoireApiData().getAgendaFromApi().whenComplete((){
                  TfoireApiData().getNewsFromApi().whenComplete((){
                    TfoireApiData().getGalleryFromApi().whenComplete((){
                      TfoireApiData().getAllAdsFromApi().whenComplete((){
                        TfoireApiData().getAllArticlesFromApi().whenComplete((){
                          TfoireApiData().getMainAd().whenComplete((){
                            TfoireApiData().getInfosPratiques();
                          });
                        });
                      });
                    });
                  });
                });
              });
            });
          });
        });
      });
    });
  }
}

//suppression du cache
Future<void> _deleteCacheDir() async {
  final cacheDir = await getTemporaryDirectory();

  if (cacheDir.existsSync()) {
    cacheDir.deleteSync(recursive: true);
  }
}

Future<void> _deleteAppDir() async {
  final appDir = await getApplicationDocumentsDirectory();

  if(appDir.existsSync()){
    appDir.deleteSync(recursive: true);
  }
}

//lancement de whatsapp
openwhatsapp(String whatsappNumber) async{
  var whatsappURL_android = "whatsapp://send?phone=" + whatsappNumber + "&text=foire_togo_2000";
  //var whatsappURL_ios = "https://wa.me/$telAssistance?text=${Uri.parse("foire togo 2000")}";
  if(await canLaunchUrl(Uri.parse(whatsappURL_android))){
    await launchUrl(Uri.parse(whatsappURL_android));
  }else{
    Fluttertoast.showToast(
        msg: "Whatsapp n'est pas installé",
        backgroundColor: kDeepOrange.withOpacity(0.5),
        gravity: ToastGravity.CENTER
    );
  }
}



