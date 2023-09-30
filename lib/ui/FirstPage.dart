import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clientfoire/database/DBProvider.dart';
import 'package:clientfoire/models/MainAddModel.dart';
import 'package:clientfoire/ui/HomePage.dart';
import 'package:clientfoire/utilitaires/Constants.dart';
import 'package:flutter/material.dart';


class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  //temps avant l'apparution du bouton de next
  int timeButtonShow = 5;
  List<MainAddModel> leAdd = List.empty();

  @override
  void initState() {
    // TODO: implement initState
    DBProvider.db.getAllMainAds().then((value){
      leAdd = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Timer(
      Duration(seconds: 1), () => setState(() {
        if(timeButtonShow > 0){
          timeButtonShow--;
        }else{
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => HomePage())
          );
        }
      }),
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(100.0))
              ),
              margin: EdgeInsets.only(bottom: 100.0),
              padding: EdgeInsets.all(15.0),
              child: Text(timeButtonShow.toString(),
                style: TextStyle(
                    color: kDeepOrange,
                    fontSize: 25.0
                ),
              ),
            ),
      body: Stack(
        children: [
          CachedNetworkImage(
              //placeholder: (context, url) => Image.asset("assets/images/ic_foire.png"),
             // placeholder: (context, url) => Image.ne,
              imageUrl: leAdd.first.adLink.toString() != "" ? leAdd.first.adLink.toString() : 'assets/image/ic_foire.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
          )
        ],
      )
    );
  }
}
