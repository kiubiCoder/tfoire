import 'package:clientfoire/ui/showTicketPage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:clientfoire/utilitaires/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BuyTicket extends StatefulWidget {
  const BuyTicket({Key? key}) : super(key: key);

  @override
  _BuyTicketState createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {



  String critere1 = "";

  final TextEditingController controller1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_)=> ShowTicket())),
          child: Icon(LineIcons.qrcode,size: 90.0,color: kDeepOrange,)
      ),
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Guichet",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 0.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50.0)),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: controller1,
                        maxLength: 9,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Votre numero de telephone",
                          suffixIcon: Icon(LineIcons.search),
                        ),
                        //============== Action lors de la saisie
                        onChanged: (text){
                          critere1 =  removeDiacritics(text.toLowerCase());
                          setState(() {

                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              //margin: EdgeInsets.only(bottom: 100.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.15,
              child: ElevatedButton(
                onPressed: () async{
                  var connexionState = await (Connectivity().checkConnectivity());
                  //si connecte mais aucune donnee en locale
                  if(connexionState == ConnectivityResult.mobile || connexionState == ConnectivityResult.wifi){
                    _achatDeTicket();
                  }else{
                   Fluttertoast.showToast(
                       msg: "Aucune connexion!\nUne connexion est necessaire pour acheter votre passe",
                       backgroundColor: kDeepOrange.withOpacity(0.5),
                       gravity: ToastGravity.TOP,
                   );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(LineIcons.alternateTicket),
                    Text(" Acheter mon ticket",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kDeepOrange),
                    padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                    minimumSize: MaterialStateProperty.all( Size(15, 10))
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Future _achatDeTicket() async{
    var headers = {
      'login': 'demo',
      'apisecure': 'TXpFE54mlXkFozpg5SdMC6kNy7jTuNCMcetP',
      'apireference': '20',
      'salt': '2531',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://sandbox.semoa-payments.com/api/ping'));
    request.body = json.encode({
      "action": "ping"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: response.stream.bytesToString().toString(),
          backgroundColor: kDeepOrange.withOpacity(0.5),
          gravity: ToastGravity.TOP
      );
    }
    else {
      Fluttertoast.showToast(
          msg: response.reasonPhrase.toString(),
          backgroundColor: kDeepOrange.withOpacity(0.5),
          gravity: ToastGravity.TOP
      );
    }
    /*final response = await http.post(
      Uri.parse('https://sandbox.semoa-payments.com/api/ping'),
        headers : {
          'login': 'demo',
          'apisecure': 'TXpFE54mlXkFozpg5SdMC6kNy7jTuNCMcetP',
          'apireference': '20',
          'salt': '23211',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
            "action":"ping"
        }),
    );
    if(response.statusCode == 200){
      return print(response.body);
    }else{
      return print(response.statusCode);
    }*/
  }

}
