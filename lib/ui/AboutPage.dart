
import 'package:clientfoire/utilitaires/Constants.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share/share.dart';


class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDeepOrange,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'A Propos',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0
          ),
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget> [
            Container(
              decoration: const BoxDecoration(
                color: kDeepOrange,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0)
                ),
              ),
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 1,
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Text("Version",
                          style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 0.5
                          ),
                        ),
                      ),
                      Text(APP_VERSION,
                        style: TextStyle(
                            fontSize: 70.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ],
              )
              )
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.all(10.0),
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50.0), topLeft:Radius.circular(50.0))
                ),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 1,
                      decoration: BoxDecoration(
                        color: kDeepOrange,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),
                          bottomLeft: Radius.circular(50.0)
                        ),
                      ),
                      child: Container(
                        child: ListView(
                          children: [
                            SizedBox(height: 225.0,),
                            IconButton(
                                onPressed: (){
                                  makeCall(telAssistance);
                                },
                                icon: Icon(LineIcons.phone, color: Colors.white,size: 30.0,)
                            ),
                            SizedBox(height: 50.0,),
                            IconButton(
                                onPressed: (){
                                  Uri _url = Uri.parse(
                                      "whatsapp://send?phone=" + telAssistance + "&text="
                                      "Bonjour, j'aimerais avoir des informations sur la foire togo 2000 !"
                                  );
                                  myUrlLauncher(_url);
                                },
                                icon: Icon(LineIcons.whatSApp, color: Colors.white,size: 30.0,)
                            ),
                            SizedBox(height: 50.0,),
                            IconButton(
                                onPressed: (){
                                  Share.share("Salut! Je t'invite à téléchager cette superbe application de la foire Togo 2000 sur playstore. c'est par ici : https://play.google.com/store/apps/details?id=com.cetef.foiretogo");
                                },
                                icon: Icon(Icons.share, color: Colors.white,size: 30.0,)
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 1,
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text("Powerd by",
                                  style: TextStyle(
                                      color: kTextGray,
                                      fontSize: 20.0
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text("CETEF",
                                  style: TextStyle(
                                      color: kDeepOrange,
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height *0.5,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text("Pour toute information, contactez le CETEF, organisateur de la Foire Internationale de Lomé",
                                    style: TextStyle(
                                        color: kTextGray,
                                        fontSize: 20.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(Copyright + "\n\nDeveloper +22892868204",
                                style: TextStyle(
                                  color: Colors.black12
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


