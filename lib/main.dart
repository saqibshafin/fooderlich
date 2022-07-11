// Refactored by seperating the GoRouter code from main.dart

// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'navigation/app_router_gorouter.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'fooderlich_theme.dart';
import 'models/models.dart';
// import 'navigation/app_router.dart';
// import 'navigation/app_route_parser.dart';
// import '/screens/screens.dart';

void main() {
  runApp(
    const Fooderlich(),
  );
}

class Fooderlich extends StatefulWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  // State<Fooderlich> createState() => _FooderlichState();
  // Alternatively:
  _FooderlichState createState() => _FooderlichState();
  // same as "State<Fooderlich> createState() => _FooderlichState();"
}

class _FooderlichState extends State<Fooderlich> {
  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  final _appStateManager = AppStateManager();

  // static AppStateManager appStateManager = AppStateManager(); //
  // static AppStateManager? appStateManager; //
  // final appStateManager = AppStateManager();
  // // late AppStateManager appStateManager;
  // final groceryManager = GroceryManager();
  // final profileManager = ProfileManager();
  //! To make it easy to access these state managers info wherever they're
  //needed in the app, consider using a state management option like provider to
  //put theese manager info into the widget tree

  late AppRouterGoRouter _appRouter;
  late final _router = _appRouter.router;

  // Initialize RouteInformationParser
  // final routeParser = AppRouteParser();

  // static late User user;
  // var userr;

  // static final loginInfo = LoginInfo();
  // final loginInfo = LoginInfo();
  // final isLoggedInn = loginInfo.isLoggedIn;
  // static late LoginInfo loginInfo; //
  // static LoginInfo? loginInfo; //

  // static User get getUser => User(
  // static User user = User(
  //   firstName: 'Stef',
  //   lastName: 'Patt',
  //   role: 'Flutterista',
  //   profileImageUrl: 'assets/profile_pics/person_stef.jpeg',
  //   points: 100,
  //   darkMode: false,
  // );

// late List<Listenable> listenables;
  late final _mergedListenables;
  // final _mergedListenables =  Listenable.merge(
  //       <Listenable>[_appStateManager, _profileManager, _groceryManager]);

  @override
  void initState() {
    _mergedListenables = Listenable.merge(
        <Listenable>[_appStateManager, _profileManager, _groceryManager]);

    // _appRouter = AppRouter(
    //   appStateManager: _appStateManager,
    //   groceryManager: _groceryManager,
    //   profileManager: _profileManager,
    // );
    _appRouter = AppRouterGoRouter(
      appStateManager: _appStateManager,
      groceryManager: _groceryManager,
      profileManager: _profileManager,
      mergedListenables: _mergedListenables,
    );
    //
    // user = User(
    //   firstName: 'Stef',
    //   lastName: 'Patt',
    //   role: 'Flutterista',
    //   profileImageUrl: 'assets/profile_pics/person_stef.jpeg',
    //   points: 100,
    //   darkMode: false,
    // );
    // userr = user;
    //
    // loginInfo = LoginInfo(); //
    // appStateManager = AppStateManager(); //
    // appStateManager = AppStateManager(selectedTab: 0); //

    // listenables = [appStateManager, profileManager, groceryManager];
    // _mergedListenables = Listenable.merge(
    //     <Listenable>[_appStateManager, _profileManager, _groceryManager]);
    // merged = Listenable.merge(
    //     <Listenable> listenables);
/*
  1 Listener leak when using Listenable.merge with an AnimationController #25163
    https://github.com/flutter/flutter/issues/25163
  2 Fix Listenable.merge to not leak #26313
    https://github.com/flutter/flutter/pull/26313
  **maybe it's not a leak anymore...**

  3 How do I support multiple refreshListenables? #189 
    https://github.com/csells/go_router/discussions/189
  4 https://api.flutter.dev/flutter/foundation/Listenable/Listenable.merge.html
  5 https://api.flutter.dev/flutter/foundation/Listenable-class.html
*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStateManager>.value(
          value: _appStateManager,
        ),
        ChangeNotifierProvider<GroceryManager>.value(
          value: _groceryManager,
        ),
        ChangeNotifierProvider<ProfileManager>.value(
          value: _profileManager,
        ),
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = FooderlichTheme.dark();
          } else {
            theme = FooderlichTheme.light();
          }

          // return MaterialApp(
          //   theme: theme,
          //   title: 'Fooderlich',
          //   home: Router(
          //     routerDelegate: _appRouter,
          //     backButtonDispatcher: RootBackButtonDispatcher(),
          //   ),
          // );

          // Replace with Material.router
          return MaterialApp.router(
            theme: theme,
            title: 'Fooderlich',
            // backButtonDispatcher: RootBackButtonDispatcher(),
            //
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate,
            //
            debugShowCheckedModeBanner: false,
            //!! when to use it?
          );
          // You’ve created a MaterialApp that initializes an internal router.
        },
      ),
    );
  }
}

// class LoginInfo {
//   var isLoggedIn = false;
// }
