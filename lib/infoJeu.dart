import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

class DataFromAPIDetails extends StatefulWidget {
  final String passedId;

  DataFromAPIDetails({required this.passedId});

  @override
  _DataFromAPIDetailsState createState() => _DataFromAPIDetailsState();
}

class _DataFromAPIDetailsState extends State<DataFromAPIDetails> {
  Future getGameData() async {
    String name = "";
    String prix = "";
    String editeur = "";
    String image = "";
    String description = "";

    List<GameDetails> games = [];

    String url = 'https://store.steampowered.com/api/appdetails?appids=' +
        widget.passedId;
    var responseID = await http.get(Uri.parse(url));
    Map<String, dynamic> jsonDataID =
        new Map<String, dynamic>.from(json.decode(responseID.body));

    name = jsonDataID[widget.passedId]["data"]["name"];

    editeur = jsonDataID[widget.passedId]["data"]["developers"][0];

    if (jsonDataID[widget.passedId]["data"]["is_free"] == true) {
      prix = "gratuit";
    } else {
      if (jsonDataID[widget.passedId]["data"]["price_overview"]
              ["final_formatted"] !=
          null) {
        prix = jsonDataID[widget.passedId]["data"]["price_overview"]
            ["final_formatted"];
      } else {
        prix = "N/A";
      }
    }
    image = jsonDataID[widget.passedId]["data"]["header_image"];

    description = jsonDataID[widget.passedId]["data"]["detailed_description"];

    print(description);

    GameDetails game = GameDetails(name, editeur, prix, image, description);

    games.add(game);

    return games;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1c2325),
      appBar: AppBar(
        backgroundColor: Color(0xFF1c2325),
        title: Text(
          "Détail du jeu",
          style:
              TextStyle(fontWeight: FontWeight.bold, fontFamily: 'GoogleSans'),
        ),
        actions: [
          new IconButton(
              icon: new SvgPicture.asset(
                'assets/like.svg',
                height: 20.0,
                width: 20.0,
              ),
              onPressed: () {
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Like(),
                  ),
                );
              */
              }),
          new IconButton(
            icon: new SvgPicture.asset(
              'assets/whishlist.svg',
              height: 20.0,
              width: 20.0,
            ),
            onPressed: () {
              /*
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Whishlist(),
                ),
              );
            */
            },
          ),
        ],
      ),
      body: Container(
        child: Container(
          child: FutureBuilder(
            future: getGameData(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("chargement..."),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return Transform.translate(
                      offset: Offset(0, 10.0 * i),
                      child: Column(
                        //alignment: Alignment.topCenter,
                        children: [
                          Container(
                            width: 1100,
                            height: 5,
                            color: Color(0xFF111518),
                          ),
                          Container(
                            height: 250,
                            alignment: Alignment(-0.95, 0.95),
                            decoration: BoxDecoration(
                              color: const Color(0xff7c94b6),
                              image: const DecorationImage(
                                image: AssetImage('assets/backgnd.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Card(
                            color: Color(0xFF1e262c),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: Image(
                                    image: NetworkImage(snapshot.data[i].image),
                                  ),
                                  title: Text(
                                    snapshot.data[i].nom,
                                    style: TextStyle(
                                      color: Colors.white, // Couleur du texte
                                    ),
                                  ),
                                  subtitle: Text(
                                    snapshot.data[i].editeur +
                                        "\nPrix: " +
                                        snapshot.data[i].prix,
                                    style: TextStyle(
                                      color: Colors.white, // Couleur du texte
                                    ),
                                  ),
                                  isThreeLine: true,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            //margin: EdgeInsets.only(top: 0),
                            //alignment: Alignment.topLeft,
                            children: [
                              ElevatedButton(
                                child: Text("Description",
                                    style: TextStyle(
                                      fontFamily: 'GoogleSans',
                                    )),
                                onPressed: () {
//ajouter la page du jeu coder en dur *************
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF616af6),
                                    fixedSize: const Size(200, 30)),
                              ),
                              ElevatedButton(
                                child: Text("Avis",
                                    style: TextStyle(
                                      fontFamily: 'GoogleSans',
                                    )),
                                onPressed: () {
//ajouter la page du jeu coder en dur *************
                                },
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Color(0xFF616af6)),
                                  fixedSize: const Size(192, 30),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              snapshot.data[i].description,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'GoogleSans',
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class GameDetails {
  final String nom, editeur, prix, image, description;
  GameDetails(this.nom, this.editeur, this.prix, this.image, this.description);
}
