import 'package:flutter/material.dart';

class SearchFieldWidget extends StatefulWidget {
  const SearchFieldWidget({super.key});

  @override
  State<StatefulWidget> createState() => SearchFieldState();
}

class SearchFieldState extends State<SearchFieldWidget> {

  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(10),
        color: Colors.amber,
        child: Column(
          children:[
            TextField(
              obscureText: false,
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
                fillColor: Colors.white,
                filled: true,
                suffixIcon: IconButton(
                    onPressed: () => {_controller.clear()},
                    icon: Icon(Icons.search),
                ),
              ),
            ),
            Container(
              alignment: FractionalOffset.centerRight,
              child: TextButton(
                onPressed: () => {},
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                child: const Text("filter"),
              ),
            )
          ],
      ),
    );
  }
}