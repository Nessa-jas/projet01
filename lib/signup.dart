import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet01/accueil.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _MySignUpState createState() => _MySignUpState();
}

class _MySignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context){
    return Container(

      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.png'), fit: BoxFit.cover)
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              padding: EdgeInsets.only(left:20,top: 30),

              child: Text(
                'Inscription',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 33,
                    fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.bold ),
              ),

            ),
            Container(
              padding: EdgeInsets.only(left:25,top: 90),

              child: Text(
                'Veuillez saisir ces différentes informations,\nafin que vos listes soient sauvegardées.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'GoogleSans',
                    fontSize: 17 ),
              ),

            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3, right: 35, left: 35),
              child: Column(
                children: [
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        fillColor: Color(0xFF1e262c),
                        filled: true,
                        hintText: 'Nom d\'utilisateur',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'GoogleSans',),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide( color:Colors.transparent),)
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        fillColor: Color(0xFF1e262c),
                        filled: true,
                        hintText: 'E-mail',
                        hintStyle: TextStyle(color: Colors.white,fontFamily: 'GoogleSans'),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide( color:Colors.transparent),)
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: Color(0xFF1e262c),
                        filled: true,
                        hintText: 'Mot de passe',
                        hintStyle: TextStyle(color: Colors.white,fontFamily: 'GoogleSans'),
                        enabledBorder : OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide( color:Color(0xFFcb0c46))),
                      suffixIcon:  InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: new SizedBox(
                            child:  SvgPicture.asset('assets/warning.svg'),
                          ),),
                      )

                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: Color(0xFF1e262c),
                        filled: true,
                        hintText: 'Vérification du mot de passe',
                        hintStyle: TextStyle(color: Colors.white,fontFamily: 'GoogleSans'),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide( color:Colors.transparent),)
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child : TextButton(
                          child: Text(
                            ' S\'inscrire',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'GoogleSans',
                                fontStyle: FontStyle.italic
                            ),
                          ),
                          style: TextButton.styleFrom(
                            // padding: const EdgeInsets.symmetric(horizontal: 600, vertical: 15),
                            backgroundColor: Color(0xFF636af6),
                            fixedSize: const Size(50, 50)
                          ),
                          onPressed: ()  {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Accueil(),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}