import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';
import 'app_link.dart';

// ignore: todo
// class AppRouter extends RouterDelegate //TODO: Add <AppLink>
class AppRouter extends RouterDelegate<AppLink>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
// Remember that AppLink encapsulates all the route information. The code above
//sets the RouterDelegate’s user-defined data type to AppLink.

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;
  final GroceryManager groceryManager;
  final ProfileManager profileManager;

  AppRouter({
    required this.appStateManager,
    required this.groceryManager,
    required this.profileManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appStateManager.isInitialized) ...[
          SplashScreen.page(),
        ] else if (!appStateManager.isLoggedIn) ...[
          LoginScreen.page(),
        ] else if (!appStateManager.isOnboardingComplete) ...[
          OnboardingScreen.page(),
        ] else ...[
          Home.page(appStateManager.getSelectedTab),
          if (groceryManager.isCreatingNewItem)
            GroceryItemScreen.page(onCreate: (item) {
              groceryManager.addItem(item);
            }, onUpdate: (item, index) {
              // No update
            }),
          if (groceryManager.selectedIndex != -1)
            GroceryItemScreen.page(
                item: groceryManager.selectedGroceryItem,
                index: groceryManager.selectedIndex,
                onCreate: (_) {
                  // No create
                },
                onUpdate: (item, index) {
                  groceryManager.updateItem(item, index);
                }),
          if (profileManager.didSelectUser)
            ProfileScreen.page(profileManager.getUser),
          if (profileManager.didTapOnRaywenderlich) WebViewScreen.page(),
        ]
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == FooderlichPages.onboardingPath) {
      appStateManager.logout();
    }

    if (route.settings.name == FooderlichPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(-1);
    }

    if (route.settings.name == FooderlichPages.profilePath) {
      profileManager.tapOnProfile(false);
    }

    if (route.settings.name == FooderlichPages.raywenderlich) {
      profileManager.tapOnRaywenderlich(false);
    }

    return true;
  }

  //
  //

  // Convert app link(URL) to an app state:
  // 1
  @override
  Future<void> setNewRoutePath(AppLink newLink) async {
    //?? Where tf is "await"?

    // 2
    switch (newLink.location) {
      // 3
      case AppLink.kProfilePath:
        profileManager.tapOnProfile(true);
        break;
      // 4
      case AppLink.kItemPath:
        // 5
        final itemId = newLink.itemId;
        if (itemId != null) {
          groceryManager.setSelectedGroceryItem(itemId);
        } else {
          // 6
          groceryManager.createNewItem();
        }
        // 7
        profileManager.tapOnProfile(false);
        break;
      // 8
      case AppLink.kHomePath:
        // 9
        appStateManager.goToTab(newLink.currentTab ?? 0); //?? tf is "?? 0" ?
        // 10
        profileManager.tapOnProfile(false);
        groceryManager.groceryItemTapped(-1);
        break;
      // 11
      default:
        break;
    }
  }
  /*
  Here’s how you convert your app link to an app state:
    1 You call setNewRoutePath() when a new route is pushed. It passes along an 
    AppLink. This is your navigation configuration.
    2 Use a switch to check every location.
    3 If the new location is /profile, show the Profile screen.
    4 Check if the new location starts with /item.
    5 If itemId is not null, set the selected grocery item and show the Grocery 
    Item screen.
    6 If itemId is null, show an empty Grocery Item screen.
    7 Hide the Profile screen.
    8 If the new location is /home.
    9 Set the currently selected tab.
    10 Make sure the Profile screen and Grocery Item screen are hidden.
    11 If the location does not exist, do nothing.
  */

  // Apply configuration helper for converting app state to applink(URL):
  @override
  AppLink get currentConfiguration => getCurrentPath();
  // Accessing currentConfiguration calls the helper function below,
  //getCurrentPath(), which checks the app state and returns the right app link
  //configuration.

  // Convert app state to applink(URL):
  // This is a helper function that converts the app state to an AppLink object.
  AppLink getCurrentPath() {
    // 1
    if (!appStateManager.isLoggedIn) {
      return AppLink(location: AppLink.kLoginPath);
      // 2
    } else if (!appStateManager.isOnboardingComplete) {
      return AppLink(location: AppLink.kOnboardingPath);
      // 3
    } else if (profileManager.didSelectUser) {
      return AppLink(location: AppLink.kProfilePath);
      // 4
    } else if (groceryManager.isCreatingNewItem) {
      return AppLink(location: AppLink.kItemPath);
      // 5
    } else if (groceryManager.selectedGroceryItem != null) {
      final id = groceryManager.selectedGroceryItem?.id;
      return AppLink(location: AppLink.kItemPath, itemId: id);
      // 6
    } else {
      return AppLink(
          location: AppLink.kHomePath,
          currentTab: appStateManager.getSelectedTab);
    }
  }
  /*
  This is a helper function that converts the app state to an AppLink object. 
  Here’s how it works:
    1. If the user hasn’t logged in, return the app link with the login path.
    2. If the user hasn’t completed onboarding, return the app link with the 
    onboarding path.
    3. If the user taps the profile, return the app link with the profile path.
    4. If the user taps the + button to create a new grocery item, return the 
    app link with the item path.
    5. If the user selected an existing item, return an app link with the item 
    path and the item’s id.
    6. If none of the conditions are met, default by returning to the home path 
    with the selected tab.
  */
}

// Testing Deep Links on Android
// ~/Library/Android/sdk/platform-tools/adb shell am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d 'fooderlich://raywenderlich.com/home?tab=1'
// For Windows: C:\Users\disaster\AppData\Local\Android\Sdk\platform-tools\adb shell am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d 'fooderlich://raywenderlich.com/home?tab=1'
