import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//code from lab 4 attraction_model.dart

class GameModel extends ChangeNotifier {
    // final List<Attraction> itemsToBuy = [];
    // final List<Attraction> items = [...GuelphAttractions.guelphAttractions];

    void addItem() {
        // itemsToBuy.add(name);
        notifyListeners();
    }
}