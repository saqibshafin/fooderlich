// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/models.dart';
import '../screens/screens.dart';
import 'app_link.dart';

class AppRouterGoRouter {
  // @override
  // final GlobalKey<NavigatorState> navigatorKey;

  // final appStateManager = AppStateManager();
  // final groceryManager = GroceryManager();
  // final profileManager = ProfileManager();
  final AppStateManager appStateManager;
  final GroceryManager groceryManager;
  final ProfileManager profileManager;

// late List<Listenable> listenables;
  late final mergedListenables;
  // late Listenable.merge(<Listenable> mergedListenables);

  // AppRouterGoRouter({
  //   required this.appStateManager,
  //   required this.groceryManager,
  //   required this.profileManager,
  // }) : navigatorKey = GlobalKey<NavigatorState>() {
  //   appStateManager.addListener(notifyListeners);
  //   groceryManager.addListener(notifyListeners);
  //   profileManager.addListener(notifyListeners);
  // }
  AppRouterGoRouter({
    required this.appStateManager,
    required this.groceryManager,
    required this.profileManager,
    required this.mergedListenables,
  });

//   @override
//   void dispose() {
//     appStateManager.removeListener(notifyListeners);
//     groceryManager.removeListener(notifyListeners);
//     profileManager.removeListener(notifyListeners);
//     super.dispose();
//   }
// }

  // final mergedListenables = Listenable.merge(
  //       <Listenable>[appStateManager, profileManager, groceryManager]);

  int count = 0;
  // final loginInfo = LoginInfo();

  // final List<Listenable> listenables = [appStateManager];
  // Listenable.merge(
  // _FooderlichState.merge(List<Listenable?> listenables // = [appStateManager]
  //     );
// factory Listenable.merge(List<Listenable?> listenables) = _MergingListenable;

  // var x = appStateManager.getSelectedTab;
  // error-The instance member 'appStateManager' can't be accessed in an
  //initializer. Try replacing the reference to the instance member with a
  //different expression.
  var x = 0;

  // late final GoRouter router;
  // late final _router = GoRouter(
  late final router = GoRouter(
    // router = GoRouter(
    // initialLocation: '/page0',
    // urlPathStrategy: UrlPathStrategy.path,  //??
    // refreshListenable: appStateManager,
    // refreshListenable: appStateManager, profileManager,
    // refreshListenable: listenables,
    refreshListenable: mergedListenables,
    redirect: (state) {
      count++;
      // final loggedIn = loginInfo.isLoggedIn;

      // checking if the user is headed for the login page
      final isLogging = state.location == '/login';
      final isInitializing = state.location == '/0';
      final isOnboarding = state.location == '/onboarding';
      // final isOnboarding = state.location == '/';

      final isGoingProfilePage = state.location == '/profile';

      // final y = groceryManager.selectedIndex;

      print('${appStateManager.isLoggedIn}--${isLogging}++$count');

      // // if (!loggedIn && !isLogging) return '/login';
      // if (!appStateManager.isLoggedIn && !isLogging) {
      //   return '/login';
      //   // return '/';
      // }
      // if (appStateManager.isLoggedIn && isLogging) return '/page2';

      // if (true) return '/login';
      // if (!appStateManager.isInitialized) return '/page2';
      // if (!appStateManager.isLoggedIn && !isLogging)
      // if (!appStateManager.isLoggedIn) return '/login';
      // if (appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete)
      //   // else if (!appStateManager.isOnboardingComplete && isLogging)
      //   return '/onboarding';
      // if (appStateManager.isOnboardingComplete &&
      //     !appStateManager.isInitialized) return '/0';

      // if (!appStateManager.isInitialized && !isInitializing) return '/0';
      if (!appStateManager.isInitialized) return isInitializing ? null : '/0';
      // if (!loggedIn) return isLogging ? null : '/login';
      if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
        return isLogging ? null : '/login';
      // if the user is logged in but still on the login page, send them to
      //the home page
      // if (isLogging) return '/onboarding';
      // the user is logged in and headed to /login, no need to login again
      // if (appStateManager.isLoggedIn && isLogging) return '/onboarding';
      if (appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete)
        return isOnboarding ? null : '/onboarding';
      //
      // final x = appStateManager.getSelectedTab;
      x = appStateManager.getSelectedTab;
      final isGoingHome =
          // state.location == '/home/tab=${appStateManager.getSelectedTab}';
          state.location == '/home/tab/${x}';
      //
      if (appStateManager.isOnboardingComplete &&
          !profileManager.didSelectUser &&
          !groceryManager.isCreatingNewItem &&
          !(groceryManager.selectedIndex != -1))
        // return '/home/tab/:${x}';
        return isGoingHome
            ? null
            // : '/home/tab/${appStateManager.getSelectedTab}';
            : '/home/tab/${x}';
      //
      // if (appStateManager.isOnboardingComplete && (isLogging || isOnboarding))
      //   return '/home/tab/${x}';
//** modify this part when you want to work with navigating using the browser
//address bar.

      // /*if (!appStateManager.isInitialized)
      //   // SplashScreen.page();
      //   return '/0';
      // else*/
      // if (!appStateManager.isLoggedIn)
      //   // LoginScreen.page();
      //   return '/login';
      // else if (!appStateManager.isOnboardingComplete)
      //   // OnboardingScreen.page();
      //   return '/onboarding';
      // // ] else ...[
      // //   Home.page(appStateManager.getSelectedTab),
      // //   if (groceryManager.isCreatingNewItem)
      // //     GroceryItemScreen.page(onCreate: (item) {
      // //       groceryManager.addItem(item);
      // //     }, onUpdate: (item, index) {
      // //       // No update
      // //     }),
      // // ]

      final isGoingToCreate = state.location == '/home/tab/2/newitem';
      // Create new item
      // 1
      if (groceryManager.isCreatingNewItem)
        // // 2
        // GroceryItemScreen.page(
        //   onCreate: (item) {
        //     // 3
        //     groceryManager.addItem(item);
        //   },
        //   onUpdate: (item, index) {
        //     // 4 No update
        //   },
        // );
        // Here’s how this block lets you navigate to a new grocery item:
        //   1. Checks if the user is creating a new grocery item.
        //   2. If so, shows the Grocery Item screen.
        //   3. Once the user saves the item, updates the grocery list.
        //   4. onUpdate only gets called when the user updates an existing item.
        //   ??So where does onUpdate get executed?
        //?? I didn't get how this 'if' block worked
        return isGoingToCreate ? null : '/home/tab/${x}/newitem';
      //
      final z = groceryManager.selectedIndex;
      print('---$z---');
      final isViewingExistingItem =
          state.location == '/home/tab/2/item/${groceryManager.selectedIndex}';
      // state.location == '/home/tab/2/item/1';
      // Select GroceryItemScreen
      // 1
      if (groceryManager.selectedIndex != -1)
        //   // 2
        //   GroceryItemScreen.page(
        //       item: groceryManager.selectedGroceryItem,
        //       index: groceryManager.selectedIndex,
        //       onUpdate: (item, index) {
        //         // 3
        //         groceryManager.updateItem(item, index);
        //       },
        //       onCreate: (_) {
        //         // '(_)' what is this for?
        //         // 4 No create
        //       });
        // // Here’s how the code works:
        // //  1. Checks to see if a grocery item is selected.
        // //  2. If so, creates the Grocery Item screen page.
        // //  3. When the user changes and saves an item, it updates the item at the current index.
        // //  4. onCreate only gets called when the user adds a new item.
        // //?? I didn't get how this 'if' block worked
        return isViewingExistingItem
            ? null
            : '/home/tab/2/item/${groceryManager.selectedIndex}';
      // : '/home/tab/2/item/1';

      if (profileManager.didSelectUser)
        // ProfileScreen.page(profileManager.getUser);
        return isGoingProfilePage ? null : '/profile';
      // This checks the profile manager to see if the user selected their
      //profile. If so, it shows the Profile screen.
      //
      // Add WebView Screen
      // if (profileManager.didTapOnRaywenderlich)
      //   //
      //   WebViewScreen.page();
      //!! tf why doesn't this work...how does the app then launch the web link!

      return null;
    },
    // redirectLimit: 20,
    // Auto redirection (executes the redirect block automatically and goes to
    //the preprogrammed route by if/else)
    routes: [
      GoRoute(
        path: '/0',
        name: 'splashScreen',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/login',
        name: 'loginScreen',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const LoginScreen(),
          // child: LoginScreen(isLoggedIn: loginInfo.isLoggedIn),
          // child: LoginScreen(isLoggedIn: isLoggedInn),
          // child: LoginScreen.page(isLoggedIn: loginInfo.isLoggedIn),
          // child: LoginScreen.page(isLoggedInn: true),
          // child: LoginScreen.page(isLoggedIn: loginInfoo),
          // child: LoginScreen.page(),
        ),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboardingScreen',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const OnboardingScreen(),
        ),
      ),
//       GoRoute(
//         // path: '/',
//         // path: '/home/tab/${appStateManager.getSelectedTab}',
//         path: '/home/tab/:${x}',
//         name: 'home',
//         pageBuilder: (context, state) => MaterialPage<void>(
//           key: state.pageKey,
//           // child: const Scaffold(
//           //   body: Center(
//           //     child: Text('home page'),
//           //   ),
//           // ),
//           child:
//               // Home.page(appStateManager.getSelectedTab),
//               // const Home(currentTab: appStateManager.getSelectedTab),
// //! error-A value of type 'Null' can't be assigned to a parameter of type 'int'
// //in a const constructor. Try using a subtype, or removing the keyword 'const'.
//               Home(currentTab: appStateManager.getSelectedTab),
//           // Home(currentTab: appStateManager.selectedTab),
//           // Home(currentTab: 0),
//         ),
//       ),
      GoRoute(
        // path: '/home/tab/:${x}',
        path: '/home/tab/:z', //?? will work?. yes. it does.
        // path: '/home/tab/:${appStateManager.getSelectedTab}',
        builder: (context, state) =>
            // Home(currentTab: appStateManager.getSelectedTab),
            Home(
          currentTab:
              // int.parse('${state.params[appStateManager.getSelectedTab]}'),
              // int.parse('${state.params['${x}']}'),
              int.parse('${state.params['z']}'), // string to int
        ),
        routes: [
          GoRoute(
            // Create new item
            path: 'newitem', // not '/newitem'
            name: 'newitem',
            builder: (context, state) => GroceryItemScreen(
              onCreate: (groceryItem) {
                groceryManager.addItem(groceryItem);
              },
              onUpdate: (groceryItem, index) {},
            ),
          ),
          GoRoute(
            // Update existing item
            // path: 'item/:${groceryManager.selectedIndex}',
            // path: 'item/${groceryManager.selectedIndex}',
            path: 'item/:y',
            builder: (context, state) {
              final selectedIndex = groceryManager.selectedIndex;
              // groceryManager.groceryItemTapped(-1); // = -1;
              return GroceryItemScreen(
                originalItem: groceryManager.selectedGroceryItem,
                // index: groceryManager.selectedIndex,
                index: selectedIndex,
                onUpdate: (groceryItem, index) {
                  // 3
                  groceryManager.updateItem(groceryItem, index);
                },
                onCreate: (_) {
                  // '(_)' what is this for?
                  // 4 No create
                },
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/profile',
        name: 'profilePage',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          // child: ProfileScreen(user: getUser),
          // child: ProfileScreen(user: user),
          child: ProfileScreen(user: profileManager.getUser),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(
            state.error.toString(),
          ),
        ),
      ),
    ),

    // log diagnostic info for your routes
    debugLogDiagnostics: true,
  );
}
