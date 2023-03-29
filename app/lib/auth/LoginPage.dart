import 'package:app/SearchPage/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

import './RegisterPage.dart';
import '../MainScaffold.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
    void login(BuildContext context) async {
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
        );

        try {
            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: "email@emailaddress.com",
                password: "password"
            );
            
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) => MainScaffold()), (Route<dynamic> route) => false);
        } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
                print('No user found for that email.');
            } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
            }
        }
    }

    @override
    Widget build(BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;

        return Scaffold(
            appBar: AppBar(
                backgroundColor: Color(0xFFEC4686),
                title: Text("PB & J",
                    style: TextStyle(
                        fontSize: 25,
                    ),
                ),
            ),
            body: 
              Container(alignment: Alignment.center,
              color: Color(0xFFF8D5BC),
              child:
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                        SizedBox(
                          width: height/4, 
                          height:height/4,
                          child: Image.asset("assets/logo/logo.png",),
                          ),
                        Text("PB & J",style: TextStyle(fontSize: 40,),),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width/5, vertical: 8),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Username:',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width/5, vertical: 8),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Password:',
                            ),
                          ),
                        ),
                        //Text("Login"),
                        SizedBox(
                              width: width/3,
                              height: height/20,
                              child:
                                ElevatedButton(
                                    child: Text("Login"),
                                    onPressed: () {
                                        login(context);
                                    }
                                ),
                        ),
                        SizedBox(
                              width: width/3,
                              height: height/20,
                              child:
                                ElevatedButton(
                                    child: Text("Create Account"),
                                    onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => RegisterPage()));
                                    }
                                )
                        ),
                        Text("Forgot Password?",style: TextStyle(decoration: TextDecoration.underline),),
                    ]
                )              
              )

        );
    }
}