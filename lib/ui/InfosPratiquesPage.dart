import 'package:clientfoire/utilitaires/Constants.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:readmore/readmore.dart';

class InfosPratiquePage extends StatefulWidget {
  const InfosPratiquePage({Key? key}) : super(key: key);

  @override
  _InfosPratiquePageState createState() => _InfosPratiquePageState();
}

class _InfosPratiquePageState extends State<InfosPratiquePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // foregroundColor: kDeepOrangeSelf,
        // backgroundColor: Colors.white10,
        elevation: 0.0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Infos',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white
              ),
            ),
            const Text(
              ' Pratiques',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white
              ),
            ),
          ],
        ),
        actions: [
          //button icon pour page a propos
          AboutButton(context)
        ],
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.08),
          children: <Widget> [
              ListTile(
                leading: Icon(LineIcons.handPointingRight,),
                title: Text("Dispositions générales",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0
                  ),
                ),
                subtitle: ReadMoreText(
                  "\n1. Le présent règlement est complété par un ‘’guide’’ ou ‘’manuel"
                      " de l’exposant’’. On entend par « guide ou manuel de l’exposant »le document remis, "
                      "envoyé au moment de la demande de participation de l’exposant, ou mis à la disposition"
                      " sur le site internet du CETEF (www.cetef.tg).Il contient les informations relatives à "
                      "la manifestation, les règles et réglementations, les formulaires pour commander des "
                      "services , et toute autre information pertinente touchant à la participation de l’exposant à "
                      "la Foire Internationale de Lomé (FIL).Il s’impose dans sa globalité à l’exposant.\n\n2. On entend par « stand » l’espace occupé pour la présentation de produits ou services, ou l’espace utilisé"
                      " pour réunir des clients ou confrères.On entend par « catalogue "
                      "de la Foire Internationale de Lomé (FIL) »un document électronique ou papier contenant la liste des"
                      " exposants , le détail de leurs contacts, les plans d’attribution des stands et toute autre "
                      "information relative à la Foire Internationale de Lomé(FIL).\n\n3. En signant leur demande de participation, "
                      "les exposants en acceptent toutes les inscriptions ainsi que toutes celles que des circonstances particulières "
                      "ou nouvelles imposeraient. Ils s’engagent, en outre, à respecter l’ensemble des prescriptions légales et réglementaires "
                      "en vigueur, notamment la législation du travail et la réglementation sur la sécurité.",
                  trimLines: 5,
                  style: TextStyle(
                    fontSize: 18.0
                  ),
                  postDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400,
                  ),
                  preDataTextStyle: TextStyle(
                      color: kDeepOrangeSelf,
                      fontWeight: FontWeight.w400,
                  ),
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '  Lire plus',
                  trimExpandedText: '   Réduire',
                  moreStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                  ),
                  lessStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                  ),
                ),
              ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
              child: Divider(
                color: kDeepOrange,
              ),
            ),

            ListTile(
              leading: Icon(LineIcons.handPointingRight,),
              title: Text("Le plan d'aménagement du parc d'exposition",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0
                ),
              ),
              subtitle: ReadMoreText(
                "\nStands nationaux; Espace international; Zone d’exposition des artisans; Village des sponsors; "
                    "Espace thématique;\nAire de restauration;\nEspace de réunions d’affaires;\nEspace d’animations;\nEt Autres.",
                trimLines: 5,
                style: TextStyle(
                    fontSize: 18.0
                ),
                postDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400,
                ),
                preDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400
                ),
                trimMode: TrimMode.Line,
                trimCollapsedText: '  Lire plus',
                trimExpandedText: '   Réduire',
                moreStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
                lessStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
              child: Divider(
                color: kDeepOrange,
              ),
            ),

            ListTile(
              leading: Icon(LineIcons.handPointingRight,),
              title: Text("Promotion à la foire",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0
                ),
              ),
              subtitle: ReadMoreText(
                "\nUne importante campagne de promotion est prévue. "
                    "Elle comprend principalement :\nAffichage : Affiches , "
                    "affichettes, banderoles ; Publicité : Presse-Radio-Télévision "
                    "(spots publicitaires)Relations Presse : Dossier de Presse, communiqués, "
                    "interviews, reportagesRelations Publiques :Conférences, participation aux "
                    "évènements, rencontres.Site Internet : Informations générales , plans , inscription "
                    "en ligne , publicité.Réseaux sociaux: facebook, whatsapp, youtube, twitter, Instagram",
                trimLines: 5,
                style: TextStyle(
                    fontSize: 18.0
                ),
                postDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400,
                ),
                preDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400
                ),
                trimMode: TrimMode.Line,
                trimCollapsedText: '  Lire plus',
                trimExpandedText: '   Réduire',
                moreStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
                lessStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
              child: Divider(
                color: kDeepOrange,
              ),
            ),

            ListTile(
              leading: Icon(LineIcons.handPointingRight,),
              title: Text("Rencontres d'affaires et de partenariats: B to B",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0
                ),
              ),
              subtitle: ReadMoreText(
                "\nLes rencontres dénommées « Rencontres B to B ont pour objectif de mettre ensemble "
                    "les opérateurs économiques, exposants ou non à la foire autour d’une même table, "
                    "en vue d’échanger sur leurs produits et services, leurs conditions de transactions"
                    " et les formes de partenariat à mettre en place entre eux."
                "C’est une nouvelle opportunité offerte sur le site de la foire et qui a déjà fait ses "
                    "preuves lors des précédentes éditions de la Foire."
                "Pour toutes informations à une éventuelle participation, vous voudriez "
                    "bien consultez la fiche d’inscription à l’annexe. Autres évènements en marge "
                    "de la Foire Tour de caravane Soirées culturelles – concerts Nuit de la Foire Remise "
                    "d’attestations et de trophées",
                trimLines: 5,
                style: TextStyle(
                    fontSize: 18.0
                ),
                postDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400,
                ),
                preDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400
                ),
                trimMode: TrimMode.Line,
                trimCollapsedText: '  Lire plus',
                trimExpandedText: '   Réduire',
                moreStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
                lessStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
              child: Divider(
                color: kDeepOrange,
              ),
            ),

            ListTile(
              leading: Icon(LineIcons.handPointingRight,),
              title: Text("Transport",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0
                ),
              ),
              subtitle: ReadMoreText(
                "\nTransport aérien\n\nDes compagnies aériennes par le biais des agences de voyages desservent Lomé avec des vols réguliers et sûrs (Air France, Brussels Airlines, Ethiopian Airlines, Royal Air Maroc ,Asky Airline, Air Burkina etc.)"
                "\n\nTransport urbain\n\nDes bus de la compagnie SOTRAL et taxis de transport en commun desserviront encore le site de « TOGO 2000 ». Par ailleurs, les agences de location de voitures, mettront à des prix étudiés, leurs voitures et cars à la disposition des exposants."
                "\n\nTransport routier\n\nLes pays limitrophes comme le Ghana, le Benin et le Burkina-Faso acheminent leurs marchandises par voie terrestre vers la Foire Internationale de Lomé."
                "\nL’administration de la foire se fait le devoir de leur faciliter les formalités aux frontières pourvu qu’elle soit informée dans les meilleurs délais."
                "\n\nTransport maritime\n\nLes exposants pourront acheminer leurs marchandises par voie maritime. "
                    "Pour disposer à temps les produits à la foire et faciliter les procédures et opérations "
                    "douanières au Port Autonome de Lomé, la commande et l’envoi des marchandises doivent se "
                    "faire au moins deux mois avant l’ouverture officielle de la 14ème Foire Internationale de "
                    "Lomé. Le port Autonome de Lomé, le seul port en eau profonde de la sous-région ouest-africaine "
                    "a augmenté sa capacité en 2014 et est capable d’accueillir les navires de grande capacité.",
                trimLines: 5,
                style: TextStyle(
                    fontSize: 18.0
                ),
                postDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400,
                ),
                preDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400
                ),
                trimMode: TrimMode.Line,
                trimCollapsedText: '  Lire plus',
                trimExpandedText: '   Réduire',
                moreStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
                lessStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
              child: Divider(
                color: kDeepOrange,
              ),
            ),

            ListTile(
              leading: Icon(LineIcons.handPointingRight,),
              title: Text("Transit / Douane",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0
                ),
              ),
              subtitle: ReadMoreText(
                "\nTransit:\n\n"
                    "Les prestations en douane sont fournies aux exposants par un transitaire agréé. Le transitaire agréé pour la 14ème Foire Internationale de Lomé est :"
                    "\n\nMENSTRANS – TOGO\n"
                    "Tél. : (228) 22 22 45 76"
                    "Fax : (228) 22 22 96 26"
                    "Cel. : (228) 90 04 41 62 / 90 12 79 99"
                    "E-mail : menstg2003@yahoo.fr menstgcom@yahoo.fr\n\n"
                    "Douane:\n\n"
                    "L’importation et réexportation des marchandises"
                    "La liste des produits (quantité et valeur) doit être présentée au Service des douanes à l’entrée du pays."
                    "Tous les produits importés pour la foire doivent être placés sous le Régime d’Admission Temporaire d’importation. Tous les produits doivent être emballés et étiquetés « Foire Internationale de Lomé »."
                    "Les produits non vendus à la foire doivent être réexpédiés dans leurs pays d’origine au plus tard un mois à compter du jour de fermeture de la foire. Les produits qui ne seront pas réexpédiés seront soumis au taux normal de dédouanement en vigueur au Togo."
                    "Après une semaine de la fermeture de la foire, les produits encore au magasin du CETEF occasionneront d’autres frais supplémentaires pour l’exposant."
                    "Les facilités douanières offertes exclusivement pour les exposants de la 14ème Foire Internationale de Lomé sont les suivantes :"
                    "a. Tous les produits qui seront exposés à la Foire seront placés sous le régime d’Admission Temporaire (AT, régime S 508)."
                    "b. Les produits tiers, c’est-à-dire ceux non originaires de l’UEMOA et de la CEDEAO supporteront un taux forfaitaire de 28% de la valeur en douane au lieu de 52% en vigueur sur le territoire douanier."
                    "c. Les produits originaires non agréés de l’UEMOA accompagnés du certificat de produits originaires non agréés seront exonérés de 5% du taux forfaitaire de 28%, le taux retenu est alors de 23%.\n\n"
                    "d. Les produits originaires agréés et ceux de l’artisanat traditionnel de l’UEMOA et de la CEDEAO seront exonérés du droit de douane et de la redevance statistique, ils supporteront donc un taux de 7%."
                    "L’inspection est obligatoire"
                    "A l’issue de chaque inspection par la douane Togolaise, une attestation de vérification (AV) est délivrée pour les déclarations de valeurs jugées recevables (trois critères : la qualité, la quantité, et le prix). A contrario, un avis de refus d’attestation (ARA) sera délivré au déclarant."
                    "Les dispositions du code des douanes prévoient que toute importation ou exportation de marchandises doit faire l’objet d’une déclaration en douane, même en cas d’exonération des droits et taxes."
                    "Cette déclaration doit être établie par les commissionnaires en douane agrées, les propriétaires des marchandises, les bénéficiaires d’un crédit d’enlèvement."
                    "e. Au terme de la foire, les produits non vendus devront être réexportés ou mis à la consommation après paiement des droits et taxes exigibles."
                    "f. Des laissez-passer remis aux exposants doivent être collés sur les lots de marchandises, les cars et véhicules destinés à la 17ème Foire Internationale de Lomé."
                    "\n\nFormalités de police, de visas et de santé (pour les étrangers)"
                    "Des dispositions seront prises à l’Aéroport International de Lomé pour faciliter aux exposants les formalités d’arrivée et de départ."
                    "\n\nLes visas, pour ceux qui n’ont pas pu l’obtenir dans leur pays de provenance, seront délivrés par les services de la Police Nationale à l’aéroport International de Lomé. Les exposants devront, à cet effet, signaler leur date d’arrivée et le numéro de leur vol aux organisateurs."
                    "\n\nTermes et conditions de Participation"
                    "Ont accès, les exposants :"
                    "Nationaux de tous les domaines d’activités ;"
                    "Des pays africains et plus spécialement de la sous-région ;"
                    "\n\nDu reste du monde ;\nToute demande de participation à la Foire doit se faire à l’aide d’une fiche de demande de participation délivrée par les organisateurs ou figurant sur le site internet : www.cetef.tg",
                trimLines: 5,
                style: TextStyle(
                    fontSize: 18.0
                ),
                postDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400,
                ),
                preDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400
                ),
                trimMode: TrimMode.Line,
                trimCollapsedText: '  Lire plus',
                trimExpandedText: '   Réduire',
                moreStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
                lessStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
              child: Divider(
                color: kDeepOrange,
              ),
            ),

            ListTile(
              leading: Icon(LineIcons.handPointingRight,),
              title: Text("Hébergement (pour les étrangers)",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0
                ),
              ),
              subtitle: ReadMoreText(
                "\nDes hôtels partenaires offrant les meilleures qualités de services et de sécurité ont été "
                    "sélectionnés pour accueillir les exposants de la Foire Internationale de Lomé.\n\n"
                    "Pour votre réservation, veuillez contacter, soit directement l’hôtel que vous "
                    "aurez retenu, soit le Centre Togolais des Expositions et Foires de Lomé « TOGO 2000 » qui transmettra.",
                trimLines: 5,
                style: TextStyle(
                    fontSize: 18.0
                ),
                postDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400,
                ),
                preDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400
                ),
                trimMode: TrimMode.Line,
                trimCollapsedText: '  Lire plus',
                trimExpandedText: '   Réduire',
                moreStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
                lessStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
              child: Divider(
                color: kDeepOrange,
              ),
            ),

            ListTile(
              leading: Icon(LineIcons.handPointingRight,),
              title: Text("Location d'espace",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0
                ),
              ),
              subtitle: ReadMoreText(
                "\nLes tarifs appliqués sont les suivants:\n\n"
                    "Module de 9 m² minimum aménagé et climatisé : 65.000 F CFA//100Euro/m²\n"
                    "Module de 9 m² minimum aménagé non climatisé: 50.000 F CFA//77Euro/m²"
                    "\n\nSurfaces extérieures : 35 000 FCFA//54Euro/m²"
                    "Espaces shopping (semi-couvert) : 30.000 F CFA//46Euro/m²",
                trimLines: 5,
                style: TextStyle(
                    fontSize: 18.0
                ),
                postDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400,
                ),
                preDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400
                ),
                trimMode: TrimMode.Line,
                trimCollapsedText: '  Lire plus',
                trimExpandedText: '   Réduire',
                moreStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
                lessStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
              child: Divider(
                color: kDeepOrange,
              ),
            ),

            ListTile(
              leading: Icon(LineIcons.handPointingRight,),
              title: Text("Paiements",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0
                ),
              ),
              subtitle: ReadMoreText(
                "\nMETHODE DE PAYEMENT\n\n"
                    "Tous les frais dus à :"
                    "\nla location de stand,"
                    "\nla publicité,"
                    "\nle matériel de stand,"
                    "\nle catalogue au cours de la foire doivent être régler par transfert bancaire certifié payable au CETEF-LOME."
                    "\nLe payement des sociétés togolaises (et celles étrangères qui se sont enregistrées au Togo) doit se faire en francs CFA.\n\n"
                    "Le montant de la participation est intégralement dû dès la signature de la fiche de participation."
                    "\n\nUn acompte de 50 % sera payé à la signature de la fiche de participation. A défaut du paiement du solde au plus tard le 1er novembre 2022, les organisateurs pourront résilier de plein droit les engagements."
                    "\n\nLe signataire de la fiche de participation reste toutefois redevable de la totalité de son engagement envers les organisateurs."
                    "\n\nTout exposant ayant payé les frais de participation doit exiger un reçu délivré par les organisateurs.",
                trimLines: 5,
                postDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400,
                ),
                style: TextStyle(
                    fontSize: 18.0
                ),
                preDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400
                ),
                trimMode: TrimMode.Line,
                trimCollapsedText: '  Lire plus',
                trimExpandedText: '   Réduire',
                moreStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
                lessStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
              child: Divider(
                color: kDeepOrange,
              ),
            ),

            ListTile(
              leading: Icon(LineIcons.handPointingRight,),
              title: Text("Réservation de stands",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0
                ),
              ),
              subtitle: ReadMoreText(
                "\nSeules les réservations effectuées par signature du formulaire « DEMANDE DE PARTICIPATION » et parvenues au CETEF avant le 1er novembre 2022 pourront être satisfaites dans la mesure des disponibilités.\n"
                    "La demande doit être déposée auprès des organisateurs accompagnée de l’acompte de 50% afin que l’espace puisse être octroyé et ceci au plus tard le 27 novembre 2022. Les exposants étrangers doivent envoyer par courrier électronique les fiches dûment remplis aux organisateurs."
                    "\nLa demande une fois signée constitue un contrat entre la société exposante et le CETEF-LOME."
                    "\n\nALLOCATION D’ESPACE"
                    "\n\na) Les organisateurs ont le devoir de donner à chaque exposant et selon sa demande l’espace qui lui est dû et les exposants n’ont aucunement le droit de sous-louer cet espace sans l’avis des organisateurs."
                    "\nb) Les organisateurs se réservent le droit de changer l’espace à l’exposant selon les circonstances sans que l’exposant ne réclame un dédommagement."
                    "\nc) Tout exposant qui n’a pas pu honorer le payement du coût de son stand ne peut se prévaloir d’exposition."
                    "\n\nL’OCCUPATION DE L’ESPACE"
                    "\n\nTout exposant doit aménager son stand et installer ses marchandises avant le jour de la cérémonie d’ouverture c’est au plus tard le 27 novembre 2022 au soir;"
                    "L’exposant est tenu d’exposer uniquement les produits cités sur sa demande. Toute autre addition doit être communiquée aux organisateurs."
                    "\n\nLES EXPOSANTS AMBULANTS"
                    "\n\nLa vente ambulante est strictement interdite sur le site durant toute la période de la foire. Tout exposant qui tentera de le faire verra ses marchandises saisies."
                    "\n\nSTAND D’EXPOSITION"
                    "\n\nLes exposants doivent vendre et promouvoir leurs marchandises dans leurs stands;"
                    "La vente de chaque exposant doit se faire exclusivement dans son stand ;"
                    "L’exposant qui viole ce règlement sera exclu de la foire.",
                trimLines: 5,
                style: TextStyle(
                    fontSize: 18.0
                ),
                postDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400,
                ),
                preDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400
                ),
                trimMode: TrimMode.Line,
                trimCollapsedText: '  Lire plus',
                trimExpandedText: '   Réduire',
                moreStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
                lessStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
              child: Divider(
                color: kDeepOrange,
              ),
            ),

            ListTile(
              leading: Icon(LineIcons.handPointingRight,),
              title: Text("Sécurité",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0
                ),
              ),
              subtitle: ReadMoreText(
                "\nToutes les mesures de sécurité doivent être prises par les organisateurs afin que les exposants et visiteurs puissent circuler librement sur le site,"
                    "Les exposants doivent être responsables de leurs biens durant la période de la foire,"
                    "Les organisateurs ne sont nullement responsables d’aucune perte ou vol et d’un dommage causé au cours de l’ouverture des pavillons."
                    "Dans le souci de maintenir la sécurité des exposants et visiteurs sur le site, il est formellement interdit toute circulation et le stationnement de véhicules non autorisés sur le site de la foire de 11H00 à 22H00 les jours ouvrables et de 11H00 à 00H00 les week-ends."
                    "Les pavillons sont fermés à clé la nuit et gardés par la sécurité de la foire pendant le jour, la sécurité privée et la police nationale assurent l’ordre."
                    "\n\nLES PRODUITS PROHIBES ET NON DESIRES"
                    "Les produits ci-après listés sont interdits pour l’exposition :"
                    "Les matériaux inflammables et explosifs ;"
                    "Les armes et munitions ;"
                    "Les produits et matériaux"
                    "radioactifs;"
                    "Les animaux sauvages et féroces ;"
                    "Les documents pornographiques et offensifs ;"
                    "Les produits toxiques et hasardeux."
                    "les produits frelatés"
                    "les produits de friperie ou déjà usager"
                    "\n\nTout exposant désireux d’expérimenter son équipement ou sa machine à partir des produits comme : pétrole, l’essence, de l’alcool etc doit avoir l’autorisation des organisateurs par une note officielle signée par le Service National des sapeurs-pompiers du Togo."
                    "\n\nLa démonstration des gros porteurs et de grandes machines doit se faire sur une période et un emplacement bien déterminés par les organisateurs."
                    "\n\nLA SECURITE INCENDIE\n\n"
                    "Les organisateurs ou les sapeurs-pompiers peuvent mettre fin à une démonstration lorsqu’ils jugent que cela peut perturber la foire."
                    "Tout exposant doit avoir un extincteur dans son stand et d’autres installations contre incendies surtout les stands où sont exposés des produits inflammables."
                    "\n\nLA RESILIATION DE PARTICIPATION\n\n"
                    "Sans aucun préjudice causé aux organisateurs dans la rupture du contrat, les organisateurs peuvent à l’amiable accepter la résiliation du contrat de participation."
                    "Si le refus d’exposition est accepté, l’exposant doit payer une indemnité et ses fonds seront recouvrés à la fin de la foire. L’exposant qui demande l’annulation de sa participation a l’obligation d’indemniser les organisateurs pour toute perte subi suite à sa résiliation."
                    "Les organisateurs sont en droit de changer la date de l’exposition si la situation ou les conditions l’exigent. Dans ce cas d’espèce les exposants sont dans l’obligation de conserver toutes les clauses de leur contrat de participation sans toutefois réclamer des dédommagements."
                    "\n\nL’ANNULATION OU LE REPORT DE LA FOIRE\n\n"
                    "Dans les circonstances ci-après mentionnées, les organisateurs n’ont aucune responsabilité et ne peuvent dédommager les exposants :"
                    "Cas de force majeur,"
                    "Une guerre (politique, civil, ou militaire),"
                    "Une décision du gouvernement togolais,"
                    "Catastrophes naturelles (feu, inondation, tempête, séisme, épidémie, etc.)"
                    "\n\nLE PERMIS DE CONSTRUIRE DU STAND\n\n"
                    "Avant de commencer la construction de son stand, l’exposant doit avoir l’accord des organisateurs sur l’emplacement de son pavillon, les limites de son stand, l’emplacement et les normes à suivre dans la construction des stands,"
                    "La construction des pavillons, stands ou des étagères doit être terminée au plus le 27 novembre 2022 à 18 H 00,"
                    "Tout exposant qui s’entête à construire sur un espace excédant son dû, sera soumis à une sanction (Il remboursera l’excédent de l’espace)."
                    "\n\nLE TRANSPORT DES BIENS\n\n"
                    "Les exposants sont responsables des frais de transport de leurs marchandises vers le site de la foire et à la fin de la foire,"
                    "L’approvisionnement des stands et la circulation des véhicules sur le site aux heures d’ouverture de l’exposition sur toute la période de la foire,"
                    "Les exposants doivent démolir leurs stands au plus tard deux jours après la foire, passé ce délai, l’administration de la Foire se réserve le droit de procéder à leurs démolitions complètes."
                    "\n\nLES CLAUSES DU CONTRAT DE PARTICIPATION\n\n"
                    "Tout litige qui naîtra entre les organisateurs et tout exposant sera réglé suivant les clauses du contrat. L’interprétation des organisateurs sera la dernière décision."
                    "Les termes des conditions de participation peuvent changer sans l’avis des exposants.",
                trimLines: 5,
                style: TextStyle(
                    fontSize: 18.0
                ),
                postDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400,
                ),
                preDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400
                ),
                trimMode: TrimMode.Line,
                trimCollapsedText: '  Lire plus',
                trimExpandedText: '   Réduire',
                moreStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
                lessStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
            ),


            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
              child: Divider(
                color: kDeepOrange,
              ),
            ),

            ListTile(
              leading: Icon(LineIcons.handPointingRight,),
              title: Text("Autres informations",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0
                ),
              ),
              subtitle: ReadMoreText(
                "\nDEMANDE SPECIALE\n\n"
                    "Veuillez remplir le formulaire ou contacter les organisateurs pour une demande spéciale en :\n"
                    "a) Eau"
                    "\nb) Installation électrique (3 phases ou simple) ;"
                    "\nc) Le téléphone ou l’internet ;"
                    "\nd) Les fournitures de stand (tables, chaises…)"
                    "\ne) La journée du pays ou la dégustation des produits\n\n"
                    "Il y a une distribution générale d’eau et d’électricité au cours de la période de la foire. Toutefois certains exposants dont l’utilisation dépasse la norme doivent remplir un formulaire suite auquel l’installation leur sera faite conformément à leur besoin. Les frais supplémentaires seront payés par l’exposant."
                    "\n\nDÉCORATION FLORALE\n\n"
                    "Le Centre Togolais des Expositions et Foires de Lomé « TOGO 2000 » mettra à la disposition des exposants qui désirent en louer pour la durée de la Foire, des plantes et fleurs de toute nature aux prix suivants :"
                    "\nPlantes en pot : 10.000 F CFA//16Euros ;"
                    "\nBac garni de 50 x 22 x 30 : 20 000 F CFA soit 31Euros ;"
                    "\nBac garni de 80 x 22 x 30 : 24 000 F CFA//34Euro"
                    "\n\nLES VIGNETTES ET LES BADGES\n\n"
                    "L’inscription à la 14ème Foire Internationale de Lomé donne droit à un badge et une vignette pour un module de 9 m² ou un stand non couvert de 25 m². Le coût d’un badge supplémentaire est de trois mille cinq cents (3 500) F CFA//6Euros."
                    "\n\nIl est recommandé d’envoyer sa demande de participation accompagnée de photos de l’exposant."
                    "Un module de 9m2 donne droit à un(01) badge + vignette exposant"
                    "Un module de 18m2 donne droit à deux(02) badges + vignette exposant"
                    "\n\nPour les commandes supplémentaires :"
                    "Un badge supplémentaire : 5 000 F CFA//6Euro"
                    "Une vignette supplémentaire : 10 000 F CFA//16Euros"
                    "\n\nIl est à noter que la vignette sur le véhicule n’autorise que l’entrée du chauffeur et du véhicule sur le site. Les autres passagers doivent porter leur badge ou à défaut payer le ticket à l’entrée principale de la foire."
                    "\n\nTout exposant doit noter que les véhicules sont interdits le long du mur de la foire sauf dans le parking désigné par les organisateurs pour l’occasion.",
                trimLines: 5,
                style: TextStyle(
                    fontSize: 18.0
                ),
                postDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400,
                ),
                preDataTextStyle: TextStyle(
                    color: kDeepOrangeSelf,
                    fontWeight: FontWeight.w400
                ),
                trimMode: TrimMode.Line,
                trimCollapsedText: '  Lire plus',
                trimExpandedText: '   Réduire',
                moreStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
                lessStyle: TextStyle(
                  color: kDeepOrangeSelf,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
