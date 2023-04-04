import 'package:app/State/ReduxStore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './models/GameModel.dart';
import './MainScaffold.dart';
import './auth/LoginPage.dart';

import 'package:app/themes/theme_provider.dart';
import './themes/light_theme.dart';

void main() {
  final store = Store<AppState>(
    reducer,
    initialState: AppState.initialState(),
  );
  runApp(StoreProvider(
      store: store,
      child: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider())
      ], child: MyApp())));
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key}); **ask andrew about this
  bool auth = false;

  Future<void> authenticate() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        auth = true;
      }
    });
  }

  bool getAuth() {
    authenticate();
    print(auth);
    return auth;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: getAuth() ? MainScaffold() : LoginPage(),
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).themeData,
      ),
    );
  }
}
