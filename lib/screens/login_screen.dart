import 'package:flutter/material.dart';
// import 'package:fooderlich/main.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../models/models.dart';

// class LoginScreen extends StatelessWidget {
class LoginScreen extends StatelessWidget {
  // LoginScreen MaterialPage Helper
  static MaterialPage page() {
    // static MaterialPage page({isLoggedInn}) {
    return MaterialPage(
      name: FooderlichPages.loginPath,
      key: ValueKey(FooderlichPages.loginPath),
      child: const LoginScreen(),
      // child: LoginScreen(isLoggedIn: isLoggedIn),
      // child: LoginScreen(isLoggedIn: isLoggedInn),
    );
  } // Here, you define a static method 'page' that creates a MaterialPage, sets
  //a unique key and creates LoginScreen.

  final String? username;
  // final LoginInfo loginInfo;
  // bool isLoggedIn;

  const LoginScreen({
    // LoginScreen({
    Key? key,
    this.username,
    // required this.isLoggedIn,
    // required this.loginInfo,
  }) : super(key: key);

  final Color rwColor = const Color.fromRGBO(64, 143, 77, 1);
  final TextStyle focusedStyle = const TextStyle(color: Colors.green);
  final TextStyle unfocusedStyle = const TextStyle(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
                child: Image(
                  image: AssetImage(
                    'assets/fooderlich_assets/rw_logo.png',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              buildTextfield(username ?? '🍔 username'),
              const SizedBox(height: 16),
              buildTextfield('🎹 password'),
              const SizedBox(height: 16),
              buildButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return SizedBox(
      height: 55,
      child: MaterialButton(
        color: rwColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        // onPressed: () async {
        //   // // Login -> Navigate to home
        //   // Provider.of<AppStateManager>(context, listen: false)
        //   //     .login('mockUsername', 'mockPassword');
        //   // // This uses AppStateManager to call a function that updates the
        //   // //user’s login status.
        //   print(isLoggedIn);
        //   isLoggedIn = true;
        //   print(isLoggedIn);
        //   // Provider.of<AppStateManager>(context, listen: false)
        //   //     .login('mockUsername', 'mockPassword');
        //   GoRouter.of(context).go('/');
        //   // context.go('/');
        //   // context.goNamed('home');
        // },
        // onPressed: () => GoRouter.of(context).go('/page2'),
        onPressed: () {
          context.read<AppStateManager>().login('mockUsername', 'mockPassword');
          // context.go('/'); // Manual redirection
        },
      ),
    );
  }

  Widget buildTextfield(String hintText) {
    return TextField(
      cursorColor: rwColor,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red, //?? where is it's effect?
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(height: 0.5),
      ),
    );
  }
}
