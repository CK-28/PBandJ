import 'package:app/State/ReduxStore.dart';
import 'package:app/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './models/GameModel.dart';
import './MainScaffold.dart';
import './theme/LightTheme.dart';

void main() {
  final store = Store<AppState>(
    reducer,
    initialState: AppState.initialState(),
  );

  runApp(StoreProvider(
      store: store,
      child: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider())
      ], child: const MyApp())));
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
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).themeData,
        home: MainScaffold(),
      ),
    );
  }
}
