import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../utilitaires/Constants.dart';
import 'AchatTickets.dart';

class CheckTicket extends StatefulWidget {
  const CheckTicket({super.key});

  @override
  State<CheckTicket> createState() => _CheckTicketState();
}

class _CheckTicketState extends State<CheckTicket> {

  double _progress = 0;
  late InAppWebViewController inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        var isLastPage = await inAppWebViewController.canGoBack();
        if(isLastPage){
          inAppWebViewController.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        floatingActionButton: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kClearMaroon),
              padding: MaterialStateProperty.all(EdgeInsets.all(15.0))
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_)=> const AchatTicket())
            );
          },
          child: Text("Achat de tickets", style: TextStyle(fontSize: 25.0),),
        ),
        appBar: AppBar(title: Text("Vos tickets"),elevation: 0.0,),
        body: Container(
          child: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.parse("https://cetef.linkmobileltd.com/check")
                ),
                onWebViewCreated: (InAppWebViewController controller){
                  inAppWebViewController = controller;
                },
                onProgressChanged: (InAppWebViewController controller, int progress){
                  setState(() {
                    _progress = _progress / 100;
                  });
                },
              ),
              /*_progress < 1 ? Container(
                child: LinearProgressIndicator(
                  value: _progress,
                ),
              ):SizedBox()*/
            ],
          ),
        ),
      ),
    );
  }
}
