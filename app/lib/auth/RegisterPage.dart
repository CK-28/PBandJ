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
                email: "email12@emailAddress.com",
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width/5, vertical: 8),
                          child: TextField(
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
                                        createAccount();
                                    }
                                )
                        ),
                    ]
                )             
            )
        );
    }
}