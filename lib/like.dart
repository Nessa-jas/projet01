import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet01/accueil.dart';

class Like extends StatefulWidget {
  const Like({Key? key}) : super(key: key);

  @override
  _LikeState createState() => _LikeState();
}

class _LikeState extends State<Like> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xFF1c2325),
        appBar: AppBar(
          backgroundColor: Color(0xFF1c2325),

          title :
          Text (
            "Mes likes",
            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'GoogleSans',),),
          leading:
            new IconButton(
              icon: new SvgPicture.asset('assets/close.svg',
                height: 20.0,
                width: 20.0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Accueil(),
                  ),
                );
              },
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
              margin: EdgeInsets.only(top:130),
              alignment: Alignment.center,
              child: Column(
                children: [
                new SvgPicture.asset('assets/empty_likes.svg',
                  height: 150.0,
                  width: 150.0,)
                ],
              ),
            ),

            Container(
              alignment: Alignment.center,
              child: const Text("Vous n'avez encore pas liké de contenu.\n"
                  "Cliquez sur le coeur pour en rajouter.",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'GoogleSans',
                  fontSize: 20,
                ),),
            )
          ],
        ),
      ),
    );
  }
}
