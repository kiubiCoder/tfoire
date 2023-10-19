
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clientfoire/Tickets/AchatTickets.dart';
import 'package:clientfoire/database/DBProvider.dart';
import 'package:clientfoire/models/AdModel.dart';
import 'package:clientfoire/ui/17emefoire.dart';
import 'package:clientfoire/ui/BoutiquesPage.dart';
import 'package:clientfoire/ui/GalleriePage.dart';
import 'package:clientfoire/ui/showTicketPage.dart';
import 'package:clientfoire/utilitaires/Constants.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:clientfoire/Ui/AboutPage.dart';
import 'package:clientfoire/Ui/AgendaPage.dart';
import 'package:clientfoire/Ui/ExposantsPage.dart';
import 'package:clientfoire/Ui/InfosPratiquesPage.dart';
import 'package:clientfoire/Ui/NewsPage.dart';
import 'package:lottie/lottie.dart';
import 'package:clientfoire/ApiServices/ApiServices.dart';
import '../Tickets/VoirTickets.dart';
import '../models/ExposantModel.dart';


List<ExposantModel> ex = List.empty();
class HomePage extends StatefulWidget {

 const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _pageController = PageController();
  //active page
  int activePage = 0;

  late int adsLen;
  List<AdModel> ads = List.empty();
  
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    TfoireApiData().getAllAdsFromApi().whenComplete(() => DBProvider.db.getAllAds().then((value){
      ads = value;
      adsLen = ads.length - 1;
    }));
    DBProvider.db.getAllExposant().then((e) => ex = e);
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (activePage < adsLen.toInt()) {
        setState(() {
          activePage++;
          _pageController.animateToPage(
            activePage,
            duration: Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        });
      } else {
        setState(() {
          activePage = -1;
        });
      }
    });

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: _tDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Foire TOGO 2000',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0
          ),
        ),
        actions: [
          //button icon pour page a propos
          GestureDetector(
            onTap: (){
              Navigator.push(context,
              MaterialPageRoute(
              builder: (_) => const AboutPage()));
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Icon(LineIcons.infoCircle),
              //child: Image.asset("assets/images/ic_foire.png", fit: BoxFit.cover),
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(0.0),
                child: GridView(
                  padding: const EdgeInsets.all(15.0,),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 1.0,
                  ),
                  children: [
                    ElevatedButton(
                      onPressed:(){
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (_) => const NewsPage()
                            )
                        );
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  //side: const BorderSide(color: kDeepOrange)
                              )
                          ),
                          backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white)
                      ),
                      child:  const GridTile(
                          footer: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("News",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kDeepOrange,
                                fontSize: 15.0,
                                fontFamily: 'playfair display'
                              ),
                            ),
                          ),
                          child: Icon(LineIcons.newspaperAlt, size: 60.0, color: kDeepOrange,)
                      ),
                    ),
                    ElevatedButton(
                      onPressed:(){
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (_) => const AgendaPage()
                            )
                        );
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  //side: const BorderSide(color: kDeepOrange)
                              ),
                          ),
                          backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white)
                      ),
                      child:  const GridTile(
                          footer: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Agenda",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kDeepOrange,
                                fontSize: 15.0,
                                fontFamily: 'playfair display'
                              ),
                            ),
                          ),
                          child: Icon(LineIcons.addressBook,size: 60.0,color: kDeepOrange,)
                      ),
                    ),
                    ElevatedButton(
                      onPressed:(){
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (_) => const ExposantsPage()
                            )
                        );
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  //side: const BorderSide(color: kDeepOrange)
                              )
                          ),
                          backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white)
                      ),
                      child:  const GridTile(
                          footer: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Exposants",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kDeepOrange,
                                fontSize: 15.0,
                                fontFamily: 'playfair display'
                              ),
                            ),
                          ),
                          child: Icon(LineIcons.users,size: 60.0,color: kDeepOrange,)
                      ),
                    ),
                    ElevatedButton(
                      onPressed:(){
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (_) => const GalleriePage()
                            )
                        );
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  //side: const BorderSide(color: kDeepOrange)
                              )
                          ),
                          backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white)
                      ),
                      child:  const GridTile(
                          footer: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Gallerie",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'playfair display',
                                color: kDeepOrange
                              ),
                            ),
                          ),
                          child: Icon(LineIcons.image,size: 60,color: kDeepOrange,)
                      ),
                    ),
                    ElevatedButton(
                      onPressed:(){
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (_) => const InfosPratiquePage()
                            )
                        );
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                              ),
                          ),
                          backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white)
                      ),
                      child:  const GridTile(
                          footer: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Infos pratiques",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'playfair display',
                                color: kDeepOrange
                              ),
                            ),
                          ),
                          child: Icon(LineIcons.starStruck,size: 60.0,color: kDeepOrange,)
                      ),
                    ),
                    ElevatedButton(
                      onPressed:(){
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (_) => const BoutiquesPage()
                            )
                        );
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                              )
                          ),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white)
                      ),
                      child:  const GridTile(
                          footer: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Boutiques",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'playfair display',
                                color: kDeepOrange
                              ),
                            ),
                          ),
                          child: Icon(LineIcons.store,size: 60.0,color: kDeepOrange,)
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //section d'achat de ticket
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                        child: Text("Achetez votre ticket via",
                            style: TextStyle(
                                color: kDeepOrange,
                                fontSize: MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.w300,
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //togocel
                      GestureDetector(
                        /*onTap: (){
                          Uri _url = Uri.parse(
                              "whatsapp://send?phone=+22899050505&text="
                                  "FOIRE"
                          );
                          myUrlLauncher(_url);
                        },*/
                        onTap: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_)=> const AchatTicket())
                          );
                        },
                        child: Card(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.09,
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kTmoneyback
                              ),
                              child: Image.asset('assets/logos/tmoney.png'),
                            ),
                          ),
                        ),
                      ),

                      //moov
                      GestureDetector(
                        /*onTap: (){
                          Uri _url = Uri.parse(
                              "whatsapp://send?phone=+22899050505&text="
                                  "FOIRE"
                          );
                          myUrlLauncher(_url);
                        },*/
                        onTap: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_)=> const AchatTicket())
                          );
                        },
                        child: Card(
                          elevation: 0.01,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.09,
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kFloozback
                              ),
                              child: Image.asset('assets/logos/flooz.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 0.00,
                        child: _MyCarousel(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: indicators(ads.length, activePage),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
  _tDrawer() => Drawer(
    child: ListView(
      children: <Widget> [
        DrawerHeader(
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (_)=> const CheckTicket())
                );
              },
              child: Card(
                color: Colors.deepOrange.shade50,
                elevation: 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 40.0),
                            child: Column(
                              children: [
                                Text("Mon PASS",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text("Foire Togo2000",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                        child: Lottie.asset('assets/lotties/tickets.json', fit: BoxFit.cover,)
                    ),
                  ],
                ),
              ),
            )
        ),
        SizedBox(height: 50.0,),
        Padding(
            padding: EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => const GalleriePage()
                    )
                );
              },
              child: ListTile(
                title: Text('Votre foire',
                  style: TextStyle(
                      color: Colors.black54
                  ),
                ),
                leading: Icon(LineIcons.squareAlt, color: kDeepOrange,),
                trailing: Icon(LineIcons.angleRight, color: kDeepOrange,),
              ),
            )
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (_) => const BoutiquesPage()
                  )
              );
            },
            child: ListTile(
              title: Text('Boutique',
                style: TextStyle(
                  color: Colors.black54
                ),
              ),
              leading: Icon(LineIcons.squareAlt, color: kDeepOrange,),
              trailing: Icon(LineIcons.angleRight, color: kDeepOrange,),
            ),
          ),
        ),
         /*Padding(
          padding: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (_) => const NotifPage()
                  )
              );
            },
            child: ListTile(
              title: Text('Notifications',
                style: TextStyle(
                    color: Colors.black54
                ),
              ),
              leading: Icon(LineIcons.squareAlt, color: kDeepOrange,),
              trailing: Icon(LineIcons.angleRight, color: kDeepOrange,),
            ),
          ),
        ),*/
        SizedBox(height: MediaQuery.of(context).size.height * 0.10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Image.asset('assets/logos/cetef.png',
              fit: BoxFit.cover,
            )
          ),
        ),
        Container(
          child: Text("Copyright @ CETEF 2022",
            style: TextStyle(
              color: kTextGray
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    ),
  );

  _MyCarousel() {
    return Container(
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
      child: PageView.builder(
        itemCount: ads.length,
        //pageSnapping: true,
        controller: _pageController,
        onPageChanged: (page){
          setState(() {
            activePage = page;
          });
        },
        itemBuilder: (context,pagePosition){
          //reccuperation de la position active
          return GestureDetector(

            onTap: (){

              if(ads[pagePosition].title.toString().isEmpty){
                Uri _url = Uri.parse(
                    ads[pagePosition].title.toString()
                );
                myUrlLauncher(_url);
              }

            },
            child: CachedNetworkImage(
              placeholder: (context, url) => Image.asset("assets/images/ic_foire.png"),
              imageUrl: ads[pagePosition].adLink.toString() != "" ? ads[pagePosition].adLink.toString() : 'assets/image/ic_foire.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          );
        }
      ),
    );
  }

  List<Widget> indicators(imagesLength,currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 15,
        height: 20.0,
        decoration: BoxDecoration(
            color: currentIndex == index ? kDeepOrange : kTmoneyback,
            shape: BoxShape.circle,
        ),
      );
    });
  }

}
