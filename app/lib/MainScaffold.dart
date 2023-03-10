import 'package:app/SearchPage/SearchPage.dart';
import 'package:flutter/material.dart';

import './home/HomePage.dart';

class MainScaffold extends StatefulWidget {
  @override
  State<MainScaffold> createState() => _BottomTabBarScaffoldState();
}

class _BottomTabBarScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

    // Loads page content based on 
    Widget _loadContent() {
        switch (_selectedIndex) {
            case 0:
                return(HomePage());
            case 1:
                return(SearchPage());
            case 2:
                return(Text("Profile page"));
            default:
                return(Text("Something has gone very wrong"));
        }
     }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PB & J"),
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
      body: _loadContent(),
      endDrawer: Drawer(
        child: Column(
          // Important: Remove any padding from the ListView
          children: [
            Expanded(
                child: Column(
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  child: const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text('Settings'),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.switch_left),
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
            )),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Divider(),
                      ElevatedButton(
                        child: Text("Logout"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )),
            )),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
