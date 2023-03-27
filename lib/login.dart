import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet01/accueil.dart';
import 'package:projet01/signup.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Init firebase app
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MyLogin();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  //login function
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("Aucun utilisateur trouvé pour cet email");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('background.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, top: 30),
              child: Text(
                'Bienvenue !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                  fontFamily: 'GoogleSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 70),
              child: Text(
                "\nVeuillez vous connecter ou\ncréer un nouveau compte\npour utiliser l\'application.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'GoogleSans',
                    fontSize: 17),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3,
                  right: 35,
                  left: 35),
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        fillColor: Color(0xFF1e262c),
                        filled: true,
                        hintText: 'E-mail',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'GoogleSans',
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.transparent),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _passwordController,
                    textAlign: TextAlign.center,
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: Color(0xFF1e262c),
                        filled: true,
                        hintText: 'Mot de passe',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'GoogleSans',
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.transparent),
                        )),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          child: Text(
                            ' Se connecter',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'GoogleSans',
                                fontStyle: FontStyle.italic),
                          ),
                          style: TextButton.styleFrom(
                              // padding: const EdgeInsets.symmetric(horizontal: 600, vertical: 15),
                              backgroundColor: Color(0xFF636af6),
                              fixedSize: const Size(50, 50)),
                          onPressed: () async {
                            //test
                            User? user = await loginUsingEmailPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                                context: context);
                            print(user);
                            if (user != null) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => Accueil(),
                                ),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: TextButton(
                        child: Text(
                          ' Créer un nouveau compte',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'GoogleSans',
                              fontStyle: FontStyle.italic),
                        ),
                        style: TextButton.styleFrom(
                            //padding: const EdgeInsets.symmetric(horizontal: 485, vertical: 15),
                            backgroundColor: Colors.transparent,
                            side: BorderSide(color: Color(0xFF4d53bc)),
                            fixedSize: const Size(50, 50)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ),
                          );
                        },
                      ))
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
