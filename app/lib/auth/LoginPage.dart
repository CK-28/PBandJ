import 'package:app/SearchPage/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

import './RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
    void login() async {
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
        );

        try {
            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: "email@emailaddress.com",
                password: "password"
            );
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
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Color(0xFFEC4686),
                title: Text("PB & J",
                    style: TextStyle(
                        fontSize: 25,
                    ),
                ),
            ),
            body: Column(
                children:[
                    Text("Login"),
                    ElevatedButton(
                        child: Text("Login"),
                        onPressed: () {
                            login();
                        }
                    ),
                    ElevatedButton(
                        child: Text("Create Account"),
                        onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                        }
                    )
                ]
            )
        );
    }
}