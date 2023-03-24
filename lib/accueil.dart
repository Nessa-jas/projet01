import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet01/jeuaccueil.dart';
import 'package:projet01/like.dart';
import 'package:projet01/whishlist.dart';

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Container(



      child: Scaffold(
        backgroundColor: Color(0xFF1c2325),
        appBar: AppBar(
          backgroundColor: Color(0xFF1c2325),
          title : Text ("Accueil",
          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'GoogleSans'),),
          automaticallyImplyLeading: false,

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
              padding: EdgeInsets.only(left: 10, right:10, top: 20),
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        fillColor: Color(0xFF1e262c),
                        filled: true,
                        hintText: 'Rechercher un jeu...',
          hintStyle: TextStyle( color: Colors.white,fontFamily: 'GoogleSans'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10) ),
                      suffixIcon: Icon(Icons.search, color: Color(0xFF5960d7),),
                    ),
                  ),
                ],
              ),
            ),

            Container(
               height: 350,
                margin: EdgeInsets.only(top:80),
                alignment: Alignment(-0.95,0.95),
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
                      //ajouter la page du jeu coder en dur ************
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Jeuaccueil(),
                        ),
                      );
                    },
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Color(0xFF616af6),
                     fixedSize: const Size(150, 30)
                 ),

                ),
            ),

            Container(
              margin: EdgeInsets.only(left:10, top:460),
              alignment: Alignment.topLeft,
              child: const Text("Les meilleures ventes",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'GoogleSans',
                fontSize: 20,
                decoration: TextDecoration.underline,

              ),),
            ),

            Container(
              margin: EdgeInsets.only(left:10, top:250),
              alignment: Alignment.topLeft,
              child: const Text("Hogwarts Legacy: L'Héritage de Poudlard",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'GoogleSans',
                  fontWeight: FontWeight.bold,
                ),),

            ),
            Container(
              margin: EdgeInsets.only(left:10, top:300),
              alignment: Alignment.topLeft,
              child: const Text("Hogwarts Legacy : L'Héritage de Poudlard est\n "
                  "un RPG d'action-aventure immersif en monde ouvert\n"
                  " qui se déroule dans l'univers des livres Harry Potter.",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'GoogleSans',
                  fontSize: 12,
                ),),
            )
          ],
        ),
      ),
    );
  }
}
