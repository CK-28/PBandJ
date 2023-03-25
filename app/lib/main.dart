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

void initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() {
  initializeFirebase();

  final store = Store<AppState>(
    reducer,
    initialState: AppState.initialState(),
  );
  runApp(StoreProvider(store: store, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameModel(),
        child: MaterialApp(
          title: 'Flutter Demo',
          home: LoginPage(),
          // MainScaffold(),
        ),
    );
  }
}
