
import 'package:flutter/material.dart';
import 'Actions.dart' as act;

class DataAction {
  final act.Actions action;
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
    case act.Actions.UpdateSearch:
      return AppState(action.data, prevState.platforms, prevState.isRestricted);
    case act.Actions.AddPlatform:
      var platforms = List<String>.from(prevState.platforms);
      platforms.add(action.data);
      return AppState(prevState.search, platforms, prevState.isRestricted);
    case act.Actions.RemovePlatform:
      var platforms = List<String>.from(prevState.platforms);
      platforms.remove(action.data);
      return AppState(prevState.search, prevState.platforms, prevState.isRestricted);
    case act.Actions.ToggleAgeRestriction:
      return AppState(prevState.search, prevState.platforms, !prevState.isRestricted);
    default:
      return prevState;
  }
}