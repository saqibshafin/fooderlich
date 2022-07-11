import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class SplashScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: FooderlichPages.splashPath,
      key: ValueKey(FooderlichPages.splashPath),
      child: const SplashScreen(), //?? how can a static method call a class
      //that it is part of?
    );
  } // Here, you define a static method 'page' to create a MaterialPage that
  //sets the appropriate unique identifier and creates SplashScreen.

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    // Provider.of<AppStateManager>(context, listen: false).initializeApp();
    // // Here, you use the current context to retrieve the AppStateManager to
    // //initialize the app.
    // // Here, you use Provider.of() to access the model object, AppStateManager.
    // //initializeApp() initializes the app.
    context.read<AppStateManager>().initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              height: 200,
              image: AssetImage('assets/fooderlich_assets/rw_logo.png'),
            ),
            const Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}
