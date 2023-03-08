import 'package:flutter/material.dart';

import './PlayingGrid.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
            PlayingGrid(),
            Text("Backlog"),
            Text("Ongoing")
        ]
    );
  }
}