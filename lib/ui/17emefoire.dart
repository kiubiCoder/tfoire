import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:line_icons/line_icons.dart';


class FoireTogo2000 extends StatelessWidget {
  const FoireTogo2000({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Row(
          children: [
              Text("La Foire internationale de lomé",style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
            children: [
              Html(
                  data: """
                  <p style='font-size: 18px;color: black;text-align: justify'>
                      La<b style='font-size: 25px'> 17ème Foire </b> Internationale de Lomé vous ouvre ses portes <b> du 30 novembre au 18 décembre 2022 </b> sur le site du Centre Togolais des Expositions et Foires de Lomé (CETEF-LOME).
                      Manifestation phare de l’Afrique de l’Ouest, cadre idéal de promotion des produits et services, de contacts d’affaires, d’échanges, et de recherches de partenaires commerciaux, la Foire Internationale de Lomé (FIL), organisée depuis 1985, demeure l’un des plus grands rendez-vous économiques de l’Afrique en général, et de la sous-région ouest africaine en particulier.
                      La présence à chacune des éditions de plusieurs centaines d’entreprises publiques, privées, de différents secteurs d’activités, provenant de tous les continents, présente l’intérêt certain pour le développement de vos relations d’affaires.
                  </p>
                """),
              Container(
                child: CachedNetworkImage(
                  imageUrl: 'https://www.cetef.tg/wp-content/uploads/2016/03/filPresentation-247x300.jpg',
                  placeholder: (context, url) =>
                      Icon(LineIcons.image,
                        color: Colors.black54,
                      ),
                  fit: BoxFit.contain,
                ),
              ),
              Html(
                  data: """
                  <p style='font-size: 18px;color: black;text-align: justify'>
                      Sur un espace de plus de 90 000 m² à 5 minutes de l’Aéroport International Gnassingbé Eyadema avec un accès rapide et pratique (taxis, taxi-motos, bus) la foire de Lomé accueille aussi bien des lancements de produits que des soirées, défilés, ou autres manifestations.
                      Elle sera pour cette édition encore meublée par des rencontres d’affaires, des conférences, des séminaires, des tables rondes, etc.…
                      C’est l’occasion de participer à cette manifestation qui se déroulera à Lomé la capitale togolaise et qui attire chaque année plusieurs milliers de visiteurs.
                      Bienvenue alors à la 17ème Foire Internationale de Lomé qui s’étendra sur 19 jours.
                  </p>
                """
              ),
              Container(
                child: CachedNetworkImage(
                  imageUrl: 'https://www.cetef.tg/wp-content/uploads/2016/03/filPresentation2-278x300.jpg',
                  placeholder: (context, url) =>
                      Icon(LineIcons.image,
                        color: Colors.black54,
                      ),
                  fit: BoxFit.contain,
                ),
              ),
            ],

        ),
      ),
    );
  }
}
