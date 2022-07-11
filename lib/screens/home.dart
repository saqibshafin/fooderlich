import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'explore_screen.dart';
import 'grocery_screen.dart';
import 'recipes_screen.dart';

class Home extends StatefulWidget {
  // Home MaterialPage Helper
  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: FooderlichPages.home,
      key: ValueKey(FooderlichPages.home),
      child: Home(
        currentTab: currentTab,
      ),
    );
  } // Here, you’ve created a static MaterialPage helper with the current tab to
  //display on the Home screen.

  const Home({
    // Home({
    Key? key,
    required this.currentTab,
    // this.currentTab,
  }) : super(key: key);

  final int currentTab;
  // int currentTab;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<Widget> pages = <Widget>[
    const ExploreScreen(),
    RecipesScreen(),
    const GroceryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Wrap Consumer for AppStateManager

    return Consumer<AppStateManager>(
      // Consumer allows us to access the state variables like those of
      //AppStateManager etc. Because we have wrapped the scaffold widget with a
      //consumer, we dont need to use Provider.of, instead,
      //appStateManager.'whateverthefunction' will do.
      builder: (context, appStateManager, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Fooderlich',
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: [
              profileButton(),
            ],
          ),
          body: IndexedStack(index: widget.currentTab, children: pages),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            currentIndex: widget.currentTab,
            // currentIndex: appStateManager.getSelectedTab,
            onTap: (index) {
              // Update user's selected tab
              // Provider.of<AppStateManager>(context, listen: false)
              //     .goToTab(index);
              appStateManager.goToTab(index); // Using the Consumer.
            },
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Recipes',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'To Buy',
              ),
            ],
          ),
        );
      },
    );
    // You’ve just wrapped your entire widget inside a Consumer. Consumer will
    //listen for app state changes and rebuild its inner widget accordingly.
  }

  Widget profileButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            'assets/profile_pics/person_stef.jpeg',
          ),
        ),
        onTap: () {
          // home -> profile
          Provider.of<ProfileManager>(context, listen: false)
              .tapOnProfile(true);
          // This triggers tapOnProfile() whenever the user taps the Profile
          //button.
        },
      ),
    );
  }
}
