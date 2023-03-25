import 'package:app/SearchPage/SearchPage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

import './home/HomePage.dart';
import './auth/LoginPage.dart';

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
        
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) => LoginPage()), (Route<dynamic> route) => false);
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
        return (Text("Profile page"));
      default:
        return (Text("Something has gone very wrong"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF875632),
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
      ),
      resizeToAvoidBottomInset: false,
      body: _loadContent(),
      endDrawer: Drawer(
        // color: Color(0xFF875632),
        child: Column(
          // Important: Remove any padding from the ListView
          children: [
            Column(
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  child: const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xFF875632),
                    ),
                    child: Text('Settings'),
                  ),
                ),
                ListTile(
                  trailing: Icon(Icons.switch_left),
                  title: const Text('Light/Dark Mode'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Account'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Notifications'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Platform'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Age Rating'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Divider(),
                      ElevatedButton(
                        child: Text("Logout"),
                        onPressed: () {
                          signOut();
                          //Navigator.pop(context);
                        },
                      )
                    ],
                  )),
            )),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFEC4686),
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
      ),
    );
  }
}
