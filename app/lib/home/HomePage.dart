import 'package:flutter/material.dart';

import './GameGrid.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
            GameGrid(
                heading: "Playing"
            ),
            GameGrid(
                heading: "Backlog"
            ),
            GameGrid(
                heading: "Ongoing"
            ),
        ]
    );
  }
}