import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:projet01/jeuaccueil.dart';
import 'package:projet01/like.dart';
import 'package:projet01/whishlist.dart';
import 'package:projet01/infoJeu.dart';
import 'package:projet01/recherche.dart';

/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataFromAPI(),
    );
  }
}*/

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  TextEditingController _searchController = TextEditingController();

  Future getGameData() async {
    String name = "";
    String prix = "";
    String editeur = "";
    String image = "";

    var response = await http.get(Uri.parse(
        'https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/?'));
    //.get(Uri.parse('https://steamcommunity.com/actions/SearchApps/pine'));
    //var jsonData = jsonDecode(response.body);
    Map<String, dynamic> jsonData =
        new Map<String, dynamic>.from(json.decode(response.body));
    //print(jsonData["response"]["ranks"]);
    List<GameMostPlayed> games = [];

    int compteur = 0;

    for (var u in jsonData["response"]["ranks"]) {
      if (compteur > 4) {
        break;
      }

      int id = u["appid"];

      String url = 'https://store.steampowered.com/api/appdetails?appids=$id';
      var responseID = await http.get(Uri.parse(url));
      Map<String, dynamic> jsonDataID =
          new Map<String, dynamic>.from(json.decode(responseID.body));

      print(id);

      name = jsonDataID[id.toString()]["data"]["name"];

      editeur = jsonDataID[id.toString()]["data"]["developers"][0];

      if (jsonDataID[id.toString()]["data"]["is_free"] == true) {
        prix = "gratuit";
      } else {
        if (jsonDataID[id.toString()]["data"]["price_overview"]
                ["final_formatted"] !=
            null) {
          prix = jsonDataID[id.toString()]["data"]["price_overview"]
              ["final_formatted"];
        } else {
          prix = "N/A";
        }
      }
      image = jsonDataID[id.toString()]["data"]["header_image"];

      GameMostPlayed game =
          GameMostPlayed(name, editeur, prix, image, id.toString());

      games.add(game);
      compteur = compteur + 1;
    }
    print(games.length);
    return games;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1c2325),
      appBar: AppBar(
        backgroundColor: Color(0xFF1c2325),
        title: Text(
          "Accueil",
          style:
              TextStyle(fontWeight: FontWeight.bold, fontFamily: 'GoogleSans'),
        ),
        automaticallyImplyLeading: false,
        actions: [
          new IconButton(
              icon: new SvgPicture.asset(
                'assets/like.svg',
                height: 20.0,
                width: 20.0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Like(),
                  ),
                );
              }),
          new IconButton(
            icon: new SvgPicture.asset(
              'assets/whishlist.svg',
              height: 20.0,
              width: 20.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Whishlist(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 1100,
            height: 5,
            color: Color(0xFF111518),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                TextField(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Recherche()),
                    );
                  },
                  controller: _searchController,
                  decoration: InputDecoration(
                    fillColor: Color(0xFF1e262c),
                    filled: true,
                    hintText: 'Rechercher un jeu...',
                    hintStyle: TextStyle(
                        color: Colors.white, fontFamily: 'GoogleSans'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Color(0xFF5960d7),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 350,
            margin: EdgeInsets.only(top: 80),
            alignment: Alignment(-0.95, 0.95),
            decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
              image: const DecorationImage(
                image: AssetImage('assets/hogwart.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: ElevatedButton(
              child: Text("En savoir plus"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataFromAPIDetails(
                      passedId: "990080",
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF616af6),
                  fixedSize: const Size(150, 30)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 460),
            alignment: Alignment.topLeft,
            child: const Text(
              "Les meilleures ventes",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'GoogleSans',
                fontSize: 20,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 250),
            alignment: Alignment.topLeft,
            child: const Text(
              "Hogwarts Legacy: L'Héritage de Poudlard",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 300),
            alignment: Alignment.topLeft,
            child: const Text(
              "Hogwarts Legacy : L'Héritage de Poudlard est\n "
              "un RPG d'action-aventure immersif en monde ouvert\n"
              " qui se déroule dans l'univers des livres Harry Potter.",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'GoogleSans',
                fontSize: 12,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 0, top: 500),
            alignment: Alignment.topLeft,
            child: Card(
              child: FutureBuilder(
                future: getGameData(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      color: Color(0xFF1e262c),
                      child: Center(
                        child: Text(
                          "chargement...",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      color: Color(0xFF1e262c),
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return Card(
                            color: Color(0xFF1e262c),
                            child: Column(
                              children: [
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        leading: Image(
                                          image: NetworkImage(
                                              snapshot.data[i].image),
                                        ),
                                        title: Text(
                                          snapshot.data[i].nom,
                                          style: TextStyle(
                                            color: Colors
                                                .white, // Couleur du texte
                                          ),
                                        ),
                                        subtitle: Text(
                                          snapshot.data[i].editeur +
                                              "\nPrix: " +
                                              snapshot.data[i].prix,
                                          style: TextStyle(
                                            color: Colors
                                                .white, // Couleur du texte
                                          ),
                                        ),
                                        isThreeLine: true,
                                      ),
                                    ),
                                    ElevatedButton(
                                      child: const Text('En savoir plus'),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DataFromAPIDetails(
                                                    passedId:
                                                        snapshot.data[i].id),
                                          ),
                                        );
                                        // Fonction appelée lorsqu'on appuie sur le bouton ACHETER
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF616af6),
                                          fixedSize: const Size(70, 100)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GameMostPlayed {
  final String nom, editeur, prix, image, id;
  GameMostPlayed(this.nom, this.editeur, this.prix, this.image, this.id);
}
