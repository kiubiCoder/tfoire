import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:clientfoire/database/DBProvider.dart';
import 'package:clientfoire/ui/BoutiquesPage.dart';
import 'package:clientfoire/ui/AboutPage.dart';
import 'package:clientfoire/ui/AgendaPage.dart';
import 'package:clientfoire/ui/FirstPage.dart';
import 'package:clientfoire/ui/GalleriePage.dart';
import 'package:clientfoire/ui/HomePage.dart';
import 'package:clientfoire/ui/NewsPage.dart';
import 'package:clientfoire/ui/ExposantsPage.dart';
import 'package:clientfoire/ui/loadingPage.dart';
import 'package:clientfoire/ui/InfosPratiquesPage.dart';
import 'package:clientfoire/utilitaires/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/ArticleModel.dart';
import 'models/ExposantModel.dart';
import 'models/GallerieModel.dart';

bool? appStatus ;
bool? tutoStatus ;
List<ExposantModel> ex = List.empty();
List<GalleryModel> galExpo = List.empty();
List<ArticleModel> artclExpo = List.empty();

var connexionState =  (Connectivity().checkConnectivity());
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  //decclaration de preference partagées
  //DBProvider.db.getAllExposant().then((e) => ex = e);
  DBProvider.db.getGallerieExposants().then((e) => galExpo = e);
  DBProvider.db.getArticlesExposants().then((e) => artclExpo = e);
  final prefs = await SharedPreferences.getInstance();

  appStatus = prefs.getBool(PREFKEY);
  //final cron = Cron();
  // cron.schedule(Schedule.parse('*/1 * * * *'), (){
  //   if(appStatus==true){
  //     NativeNotify.initialize(1929, 'ZGX188VXzCTH6qGUWpzJ9H', null, null);
  //   }
  // });

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom,
    SystemUiOverlay.top,
  ]);
  //style du systeme
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white60,
        systemNavigationBarDividerColor: Colors.white,
      ),
  );

  //Blocage sur l'orientation
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]
  );


  //shared preferences
  if(prefs.getInt("agendaVersion")==null) prefs.setInt("agendaVersion",0);
  if(prefs.getInt("articleVersion")==null) prefs.setInt("articleVersion",0);
  if(prefs.getInt("exposantVersion")==null) prefs.setInt("exposantVersion",0);
  if(prefs.getInt("gallerieVersion")==null) prefs.setInt("gallerieVersion",0);
  if(prefs.getInt("newVersion")==null) prefs.setInt("newVersion",0);
  if(prefs.getInt("pavillonVersion")==null) prefs.setInt("pavillonVersion",0);

  //Creation de la base de donnee
  DBProvider;

  //NativeNotify.initialize(1929, 'ZGX188VXzCTH6qGUWpzJ9H', null, null);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState(){
    // TODO: implement initState
    timeBaseUpdateJob();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      //responsivite
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(480, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(480, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.resize(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
        ],
      ),
      theme: ThemeData(
        primarySwatch: Colors.brown,
        appBarTheme: AppBarTheme(
          backgroundColor: kDeepOrange,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(color: kDarkMaroon),
          headline2: TextStyle(color: kDarkMaroon),
          bodyText2: TextStyle(color: kDarkMaroon),
          subtitle1: TextStyle(color: kDarkMaroon),
        ),
        primaryColor: kClearMaroon,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      //Routage des interfaces
      routes: {
        'home':(context)=> const HomePage(),
        'load':(context)=> const LoadindPage(),
        'news':(context)=> const NewsPage(),
        'infos':(context)=> const InfosPratiquePage(),
        'gallerie':(context)=> const GalleriePage(),
        'exposant':(context)=> const ExposantsPage(),
        'store':(context)=> const BoutiquesPage(),
        'agenda':(context)=> const AgendaPage(),
        'about':(context)=> const AboutPage(),
        'firstpage':(context)=> const FirstPage(),
      },

      //initialisation de la page d'acceuil
      initialRoute: appStatus == true ? 'firstpage' : 'load',
      // initialRoute: appStatus == true ? 'firstpage' : 'load',

      themeMode: ThemeMode.system,

    );
  }
}
