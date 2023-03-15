import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../State/ReduxStore.dart';
import '../State/Actions.dart' as act;

class SearchFieldWidget extends StatefulWidget {
  const SearchFieldWidget({super.key});

  @override
  State<StatefulWidget> createState() => SearchFieldState();
}

class SearchFieldState extends State<SearchFieldWidget> {

  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Function(DataAction action)>(
        converter: (Store<AppState> store) => (action) => {store.dispatch(action)},
        builder: (storeContext, callback) {
          return Container(
          margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.all(10),
          child: Column(
              children:[
                TextField(
                  obscureText: false,
                  controller: _controller,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    callback(DataAction(act.Actions.UpdateSearch, value));
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () => callback(DataAction(act.Actions.UpdateSearch, _controller.text)),
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          );
      }
    );
  }
}