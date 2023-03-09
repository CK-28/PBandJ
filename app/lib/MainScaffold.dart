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
                return(Text("Browse page"));
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
            backgroundColor: Color(0xFFCE9164),
            title: Text("PB & J", style: TextStyle(
              // color: Color(0xFFEC4686),
            ),),
        ),
        body: _loadContent(),
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
            selectedItemColor: Color(0xFFFFFFFF),
            onTap: _onItemTapped,
        ),
        );
    }
}