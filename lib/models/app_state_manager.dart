// app_state_manager.dart: Depends on AppCache to check the user login and
//onboarding status. When the app calls initializeApp(), it checks the app cache
//to update the appropriate state. -->

import 'dart:async';

import 'package:flutter/material.dart';

import 'app_cache.dart';

class FooderlichTab {
  static const int explore = 0;
  static const int recipes = 1;
  static const int toBuy = 2;
}

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;
  bool _loggedIn = false;
  bool _onboardingComplete = false;
  int _selectedTab = FooderlichTab.explore;
  //!! Don't forget to make _selectedTab private again

  final _appCache = AppCache();

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get getSelectedTab => _selectedTab;

  // AppStateManager({
  //   // required this._selectedTab,
  //   required this._selectedTab,
  //   // required this.getSelectedTab,
  // });

  // set isLoggedIn(bool value) {
  //   _loggedIn = value;
  //   notifyListeners();
  // }

  void initializeApp() async {
    _loggedIn = await _appCache.isUserLoggedIn();
    // _loggedIn = false; // to check who gets called after _isloggedIn
    _onboardingComplete = await _appCache.didCompleteOnboarding();
    // _onboardingComplete = false;

    Timer(
      const Duration(milliseconds: 2000),
      () {
        _initialized = true;
        notifyListeners();
      },
    );
  }

  void login(String username, String password) async {
    _loggedIn = true;
    await _appCache.cacheUser();
    notifyListeners();
  }

  void completeOnboarding() async {
    _onboardingComplete = true;
    await _appCache.completeOnboarding();
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToRecipes() {
    _selectedTab = FooderlichTab.recipes;
    notifyListeners();
  }

  void logout() async {
    _initialized = false;
    _selectedTab = 0;
    await _appCache.invalidate();

    initializeApp();
    notifyListeners();
  }
}
