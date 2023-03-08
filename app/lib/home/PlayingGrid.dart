import 'package:flutter/material.dart';

class PlayingGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
            ),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
                return Card(
                    color: Colors.amber,
                    child: Center(child: Text('$index')),
                );
            }
        )
    );
  }
}