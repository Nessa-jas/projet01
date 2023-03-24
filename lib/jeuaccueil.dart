import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet01/like.dart';
import 'package:projet01/whishlist.dart';

class Jeuaccueil extends StatefulWidget {
const Jeuaccueil({Key? key}) : super(key: key);

@override
_JeuaccueilState createState() => _JeuaccueilState();
}

class _JeuaccueilState extends State<Jeuaccueil> {
@override
Widget build(BuildContext context) {
return Container(
child: Scaffold(
backgroundColor: Color(0xFF1c2325),
appBar: AppBar(
backgroundColor: Color(0xFF1c2325),
title : Text ("Détail du jeu",
style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'GoogleSans'),),

actions: [
new IconButton(
icon: new SvgPicture.asset('assets/like.svg',
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
}
),
new IconButton(
icon: new SvgPicture.asset('assets/whishlist.svg',
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
height: 250,
alignment: Alignment(-0.95,0.95),
decoration: BoxDecoration(
color: const Color(0xff7c94b6),
image: const DecorationImage(
image: AssetImage('assets/backgnd.png'),
fit: BoxFit.cover,
),
),

),


  Container(
    height: 100,
    width: 500,
    margin: EdgeInsets.only(top:200),
    alignment: Alignment(-0.95,0.95),
    decoration: BoxDecoration(
      color: const Color(0xff7c94b6),
      image: const DecorationImage(
        image: AssetImage('assets/pochette.png',

        ),
      ),
    ),
  ),

  Container(
    margin: EdgeInsets.only(top:330),
    alignment: Alignment.topLeft,
    child: ElevatedButton(
      child: Text("Description",
          style: TextStyle(
            fontFamily: 'GoogleSans',
          )),
      onPressed: () {
//ajouter la page du jeu coder en dur *************
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF616af6),
          fixedSize: const Size(685, 30)
      ),
    ),
  ),

  Container(
    margin: EdgeInsets.only(top:330),
    alignment: Alignment.topRight,
    child: ElevatedButton(
      child: Text("Avis",
          style: TextStyle(
            fontFamily: 'GoogleSans',
          )),
      onPressed: () {
//ajouter la page du jeu coder en dur *************
      },
      style: ElevatedButton.styleFrom(
          side: const BorderSide(color:Color(0xFF616af6)),
          fixedSize: const Size(685, 30),
        backgroundColor: Colors.transparent,
      ),
    ),
  ),

Container(
margin: EdgeInsets.only(left:10, top:390),
alignment: Alignment.topLeft,
child: const Text("Hogwarts Legacy : L'Héritage de Poudlard est un RPG d'action-aventure immersif en monde ouvert"
    "qui se déroule dans l’univers des livres Harry Potter.\n "
    "Pour la première fois, découvrez Poudlard dans les années 1800.\n"
    "Vous incarnez une élève détenant la clé d'un ancien secret qui menace de déchirer le monde des sorciers.\n"
    "Vous pouvez maintenant prendre le contrôle de l'action et être au centre de votre propre aventure dans le monde des sorciers.\n"
    "Votre héritage vous appartient.",
style: TextStyle(
color: Colors.white, fontFamily: 'GoogleSans',
fontSize: 12,
),),
)
],
),
),
);
}
}
