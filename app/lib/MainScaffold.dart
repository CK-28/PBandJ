import 'package:app/SearchPage/SearchPage.dart';
import 'package:app/State/ReduxStore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../firebase_options.dart';

import './home/HomePage.dart';
import './auth/LoginPage.dart';
import './AccountPage/AccountPage.dart';

import 'package:provider/provider.dart';
import 'package:app/themes/theme_provider.dart';

import 'package:redux/redux.dart';
import '../State/Actions.dart' as act;

class MainScaffold extends StatefulWidget {
  @override
  State<MainScaffold> createState() => _BottomTabBarScaffoldState();
}

class _BottomTabBarScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  void signOut() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    try {
      await FirebaseAuth.instance.signOut();

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Loads page content based on
  Widget _loadContent() {
    switch (_selectedIndex) {
      case 0:
        return (HomePage());
      case 1:
        return (SearchPage());
      case 2:
        return (AccountPage());
      default:
        return (Text("Something has gone very wrong"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        resizeToAvoidBottomInset: false,
        body: _loadContent(),
        endDrawer: _buildDrawer(),
        bottomNavigationBar: _buildNavBar());
  }

  PreferredSizeWidget _buildAppBar() {
    return (AppBar(
      //backgroundColor: Color(0xFF875632),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          "assets/logo/logo.png",
        ),
      ),
      actions: [
        Builder(builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.settings_outlined,
            ),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          );
        })
      ],
    ));
  }

  Widget _buildNavBar() {
    return (BottomNavigationBar(
      //backgroundColor: Color(0xFFEC4686),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Browse",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: "Profile",
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      onTap: _onItemTapped,
    ));
  }

  Widget _buildDrawer() {
    return StoreConnector<AppState, Function(DataAction action)>(
      converter: (Store<AppState> store) =>
          (action) => {store.dispatch(action)},
      builder: (storeContext, callback) {
        return (Drawer(
            child: Container(
          color: Provider.of<ThemeProvider>(context).themeData.primaryColorDark,
          child: ListView(
            // Important: Remove any padding from the ListView
            //color: Color(0xFF875632),
            children: [
              Container(
                  height: 60,
                  width: double.infinity,
                  color: Provider.of<ThemeProvider>(context)
                      .themeData
                      .primaryColorDark,
                  child: Center(
                    child: Text("Settings",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20)),
                  )),
              Container(
                height: 1000,
                color: Provider.of<ThemeProvider>(context).themeData.cardColor,
                child: Column(
                  children: [
                    ListTile(
                      trailing: Icon(Icons.switch_left),
                      title: const Text('Light/Dark Mode'),
                      onTap: () {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                      },
                    ),
                    ListTile(
                      title: const Text('Age Rating'),
                      onTap: () {
                        callback(
                            DataAction(act.Actions.ToggleAgeRestriction, ""));
                      },
                    ),
                    ElevatedButton(
                      child: Text("Logout"),
                      onPressed: () {
                        signOut();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        )));
      },
    );
  }
}
