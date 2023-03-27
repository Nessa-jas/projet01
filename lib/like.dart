import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:projet01/game.dart';
import 'package:projet01/infoJeu.dart';

class Like extends StatefulWidget {
  const Like({Key? key}) : super(key: key);

  @override
  _LikeState createState() => _LikeState();
}

class _LikeState extends State<Like> {
  String? _userId;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    //getGameData();
  }

  Future<void> _getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });
    }
  }

  //Methode permettant de recupéré les id des jeux de la Likelist de l'utilisateur
  Future<List<String>> getGameLike() async {
    List<String> results = [];
    _getCurrentUser();
    String? user = _userId;
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("like")
          .where("username", isEqualTo: user)
          .get();
      List<QueryDocumentSnapshot> list = querySnapshot.docs;

      for (int i = 0; i < list.length; i++) {
        results.add(list[i].get("appid"));
      }
    } catch (e) {
      print("Error getting data from like: $e");
    }
    return results;
  }

  //Methode permettant de recupérer les données des jeux graces aux id recupérés precedamment
  Future getGameDataLike() async {
    String name = "";
    String prix = "";
    String editeur = "";
    String image = "";

    List<Game> games = [];
    List<String> idGames = await getGameLike();

    for (var u in idGames) {
      String url = 'https://store.steampowered.com/api/appdetails?appids=' + u;
      var responseID = await http.get(Uri.parse(url));
      Map<String, dynamic> jsonDataID =
          new Map<String, dynamic>.from(json.decode(responseID.body));

      name = jsonDataID[u]["data"]["name"];

      editeur = jsonDataID[u]["data"]["developers"][0];

      if (jsonDataID[u]["data"]["is_free"] == true) {
        prix = "gratuit";
      } else {
        if (jsonDataID[u]["data"]["price_overview"]["final_formatted"] !=
            null) {
          prix = jsonDataID[u]["data"]["price_overview"]["final_formatted"];
        } else {
          prix = "N/A";
        }
      }
      image = jsonDataID[u]["data"]["header_image"];

      Game game = Game(name, editeur, prix, image, u);

      games.add(game);
    }
    print(games.length);
    return games;
  }

  /****************************************************
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   *
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1c2325),
      appBar: AppBar(
        backgroundColor: Color(0xFF1c2325),
        title: Text(
          "Ma liste de souhaits",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'GoogleSans',
          ),
        ),
        leading: new IconButton(
          icon: new SvgPicture.asset(
            'assets/close.svg',
            height: 20.0,
            width: 20.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
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
            alignment: Alignment.topLeft,
            child: Card(
              color: Color(0xFF1c2325),
              child: FutureBuilder(
                future: getGameDataLike(),
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data.length == 0) {
                    return Container(
                      margin: EdgeInsets.only(left: 0, top: 90),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 130),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                new SvgPicture.asset(
                                  'assets/empty_likes.svg',
                                  height: 150.0,
                                  width: 150.0,
                                )
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "Vous n'avez encore pas liké de contenu.\n"
                              "Cliquez sur le coeur pour en rajouter.",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'GoogleSans',
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.only(left: 0, top: 30),
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
