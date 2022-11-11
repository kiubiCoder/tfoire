import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clientfoire/utilitaires/Constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';



class LoadindPage extends StatefulWidget {
  const LoadindPage({Key? key}) : super(key: key);

  @override
  _LoadindPageState createState() => _LoadindPageState();
}



class _LoadindPageState extends State<LoadindPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isConnected(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child:DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: kDeepOrange
                            ),
                            child: Column(
                              children: [
                                AnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  animatedTexts: [
                                    TypewriterAnimatedText('Foire Togo 2000',
                                      speed: const Duration(milliseconds: 200),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: Text("Ce chargement ne se fera qu'une fois, ne fermez pas l'application SVP !",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Lottie.asset('assets/lotties/loading.json',
                          fit: BoxFit.cover
                        ),
                        Shimmer.fromColors(
                          baseColor: kDeepOrange,
                          highlightColor: Colors.white,
                          child: Text("Chargement ...",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Container(
                          child: Text("Version " + APP_VERSION,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ],
            ),
        )
    );
  }
}


