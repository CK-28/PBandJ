
import 'package:flutter/material.dart';
import 'package:app/data/Game.dart';
import 'package:transparent_image/transparent_image.dart';

class GridGameWidget extends StatelessWidget {
  final Game game;
  const GridGameWidget({Key? key, required this.game}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    var title =  Text(
      game.name,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );

    var developer = Text(
      game.developer(),
      style: const TextStyle(color: Colors.deepOrangeAccent),
    );


    return Container(
      // width: 190,
      // height: 128,
      child: FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: NetworkImage((game.image == null)? "https://" : "https:${game.image}"),
        // fit: BoxFit.contain,
      )
    );
  }
}

// return Card(
//       color: Colors.blueGrey,
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,

//           children: [
//               Column(
//                 children: [
//                   Center(
//                     child: FadeInImage(
//                         placeholder: MemoryImage(kTransparentImage),
//                         image: NetworkImage((game.image == null)? "https://" : "https:${game.image}"),
//                         width: 90,
//                         height: 128,
//                         // fit: BoxFit.contain,
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         )
//       )
//     );



