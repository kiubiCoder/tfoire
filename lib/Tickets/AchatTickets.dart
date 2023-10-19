import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'VoirTickets.dart';


class AchatTicket extends StatefulWidget {
  const AchatTicket({super.key});

  @override
  State<AchatTicket> createState() => _AchatTicketState();
}

class _AchatTicketState extends State<AchatTicket> {

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
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_)=> const CheckTicket())
              );
            },
            child: Text("Mes Tickets"),
          ),
          appBar: AppBar(title: Text("Achat de ticket"),),
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse("https://cetef.linkmobileltd.com/pay")
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
              _progress < 1 ? Container(
                child: LinearProgressIndicator(
                  value: _progress,
                ),
              ):SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
