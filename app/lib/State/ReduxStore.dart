
import 'package:flutter/material.dart';

enum Actions {
  UpdateSearch,
  AddPlatform,
  RemovePlatform,
  ToggleAgeRestriction,
}

class DataAction {
  final Actions action;
  final data;

  DataAction(this.action, this.data);
}

@immutable
class AppState {
  final String search;
  final List<String> platforms;
  final bool isRestricted;
  AppState(this.search, this.platforms, this.isRestricted);

  static AppState initialState() {
    return AppState("", [], false);
  }
}

AppState reducer(AppState prevState, action) {
  switch(action.action) {
    case Actions.UpdateSearch:
      return AppState(action.data, prevState.platforms, prevState.isRestricted);
    case Actions.AddPlatform:
      var platforms = List<String>.from(prevState.platforms);
      platforms.add(action.data);
      return AppState(prevState.search, platforms, prevState.isRestricted);
    case Actions.RemovePlatform:
      var platforms = List<String>.from(prevState.platforms);
      platforms.remove(action.data);
      return AppState(prevState.search, prevState.platforms, prevState.isRestricted);
    case Actions.ToggleAgeRestriction:
      return AppState(prevState.search, prevState.platforms, !prevState.isRestricted);
    default:
      return prevState;
  }
}