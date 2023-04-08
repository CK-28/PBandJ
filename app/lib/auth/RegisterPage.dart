//import 'package:app/SearchPage/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase_options.dart';
import '../MainScaffold.dart';



class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
    final userController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      userController.dispose();
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }

    void login(BuildContext context, email, password) async {
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
        );
        print(email);
        print(password);

        try {
            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email,
                password: password
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

    void createAccount(username, email, password) async {
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
        );

        // Create a new user with a first and last name
        final user = <String, dynamic>{
          "username": username,
        };

        try {
            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email,
                password: password,
            );

            // Initialize database instance
             FirebaseFirestore db = FirebaseFirestore.instance;
            // Add a new document with a generated ID
            db.collection("users").add(user).then((DocumentReference doc) =>
              print('DocumentSnapshot added with ID: ${doc.id}')
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
        login(context, email, password);
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
                            controller: userController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Username:',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width/5, vertical: 8),
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Password:',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width/5, vertical: 8),
                          child: TextField(
                            controller: emailController,
                            onSubmitted: (_) => createAccount(userController.text, emailController.text, passwordController.text),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Email:',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width/3,
                          height: height/20,
                          child:
                            ElevatedButton(
                                child: Text("Register"),
                                onPressed: () {
                                    createAccount(userController.text, emailController.text, passwordController.text);
                                }
                            )
                        ),
                    ]
                )             
            )
        );
    }
}