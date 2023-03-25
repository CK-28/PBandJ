//import 'package:app/SearchPage/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';


class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
    void createAccount() async {
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
        );

        try {
            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: "email@emailAddress.com",
                password: "password",
            );
        } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
                print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
        }
        } catch (e) {
            print(e);
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
                children: [
                    Text("Register"),
                    ElevatedButton(
                        child: Text("Register"),
                        onPressed: () {
                            createAccount();
                        }
                    )
                ]
            )
        );
    }
}