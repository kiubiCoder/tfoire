import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share/share.dart';

import '../utilitaires/Constants.dart';

class NewsDetails extends StatefulWidget {
  final String id;
  dynamic data;
  NewsDetails({Key? key, required this.id, required this.data}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: (){
            Share.share("Foire togo 2000\n\n"
                + "*" + widget.data.title.toString() + "*\n\n"
                + widget.data.libelle.toString() + "\n\n"
                + "Lomé le: " + widget.data.jour.toString() + "/" + widget.data.annee.toString() + "\n\n"
                + "Téléchagez l'application de la foire ici : " + "https://play.google.com/store/apps/details?id=com.cetef.foiretogo" + "\n",
            );
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
      ),
      appBar: AppBar(
        title: Text("Details de l'article"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              Expanded(
                child: ListView(
                  children: [
                    Html(
                        data:
                        """
                            <h2 style='font-size: xxx-large;text-align: center;text-decoration: underline;text-transform: uppercase'>${widget.data.title.toString()}</h2><br>
                        """,
                    ),
                    CachedNetworkImage(
                      imageUrl: widget.data.image1.toString(),
                      fit: BoxFit.cover,
                    ),
                    Html(
                      data:
                      """                            
                            <p>
                              <span style='font-size: xx-large;font-weight: bold;color: darkgray'>${widget.data.jour.toString()}</span>
                            </p>
                            <p style='color: black;font-size: x-large'>
                              ${widget.data.libelle.toString()}
                            </p>
                        """,
                    ),
                    CachedNetworkImage(
                      imageUrl: widget.data.image2.toString(),
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ]
          )
        ),
      ),
    );
  }
}
