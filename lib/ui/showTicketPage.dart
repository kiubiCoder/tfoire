import 'package:clientfoire/utilitaires/Constants.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowTicket extends StatefulWidget {
  const ShowTicket({Key? key}) : super(key: key);

  @override
  _ShowTicketState createState() => _ShowTicketState();
}

class _ShowTicketState extends State<ShowTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Mon Pass",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              child: QrImage(
                foregroundColor: kDeepOrange,
                data: "Ticket valide aujourd'hui",
                version: QrVersions.auto,
                size: 250,
                gapless: false,
                errorStateBuilder: (context,err){
                  return Container(
                    child: Text("Ce Qr code presente une erreur",
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
            Text("Faites scanner pour accéder à la foire !",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
              ),
            )
          ],
        )
      ),
    );
  }
}
