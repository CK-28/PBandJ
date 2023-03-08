import 'package:flutter/material.dart';

class GameGrid extends StatelessWidget {
    final String heading;

    const GameGrid({
        required this.heading
    });

    @override
    Widget build(BuildContext context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(heading,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    )
                ),
                SizedBox(
                    height: 300,
                    child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                        ),
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                            return Card(
                                color: Colors.amber,
                                child: Center(
                                    child: Text('$index')
                                ),
                            );
                        }
                    )
                )
            ]
        );
    }
}