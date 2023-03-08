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
                break;
            case 1:
                return(Text("Browse page"));
                break;
            case 2:
                return(Text("Profile page"));
                break;
            default:
                return(Text("Something has gone very wrong"));
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            title: Text("PB & J"),
        ),
        body: _loadContent(),
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