import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:projet01/infoJeu.dart';
import 'package:projet01/accueil.dart';
import 'package:projet01/game.dart';

class Recherche extends StatefulWidget {
  @override
  _RechercheState createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  List<Game> gamesAff = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future getGameData(String jeuAChercher, int i) async {
    String name = "";
    String prix = "";
    String editeur = "";
    String image = "";

    gamesAff = [];

    var response = await http.get(Uri.parse(
        'https://steamcommunity.com/actions/SearchApps/' + jeuAChercher));
    //.get(Uri.parse('https://steamcommunity.com/actions/SearchApps/pine'));
    var jsonData = jsonDecode(response.body);

    print(jsonData);
    //print(jsonData["response"]["ranks"]);
    List<Game> games = [];
    print(gamesAff);

    for (var u in jsonData) {
      String id = u["appid"];
      name = u["name"];
      image = u["logo"];

      print(name);

      String url = 'https://store.steampowered.com/api/appdetails?appids=$id';
      var responseID = await http.get(Uri.parse(url));
      Map<String, dynamic> jsonDataID =
          new Map<String, dynamic>.from(json.decode(responseID.body));

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

      Game game = Game(name, editeur, prix, image, id);

      games.add(game);
    }
    for (int i = 0; i < gamesAff.length; i++) {
      print(gamesAff[i].id);
      print(gamesAff[i].nom);
    }
    //print(games.length);

    gamesAff = games;

    return games;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1c2325),
      appBar: AppBar(
        leading: IconButton(
          icon: new SvgPicture.asset('assets/close.svg'),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Accueil(),
              ),
            );
          },
        ),
        backgroundColor: Color(0xFF1c2325),
        title: Text(
          "Recherche",
          style:
              TextStyle(fontWeight: FontWeight.bold, fontFamily: 'GoogleSans'),
        ),
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
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 0, top: 90),
            alignment: Alignment.topLeft,
            child: Card(
              child: FutureBuilder(
                future: getGameData(_searchText, 1),
                builder: (context, snapshot) {
                  if ((gamesAff.length == 0 || gamesAff == null) &&
                      _searchText == "") {
                    return Container(
                      color: Color(0xFF1e262c),
                      child: Center(
                        child: Text(
                          "Aucune recherche",
                          style: TextStyle(
                            color: Colors.white, // Couleur du texte
                          ),
                        ),
                      ),
                    );
                  } else if (gamesAff.length == 0 || gamesAff == null) {
                    return Container(
                      color: Color(0xFF1e262c),
                      child: Center(
                        child: Text(
                          "Recherche...",
                          style: TextStyle(
                            color: Colors.white, // Couleur du texte
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      color: Color(0xFF1e262c),
                      child: ListView.builder(
                        itemCount: gamesAff.length,
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
                                          image:
                                              NetworkImage(gamesAff[i].image),
                                        ),
                                        title: Text(
                                          gamesAff[i].nom,
                                          style: TextStyle(
                                            color: Colors
                                                .white, // Couleur du texte
                                          ),
                                        ),
                                        subtitle: Text(
                                          gamesAff[i].editeur +
                                              "\nPrix: " +
                                              gamesAff[i].prix,
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
                                                    passedId: gamesAff[i].id),
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
