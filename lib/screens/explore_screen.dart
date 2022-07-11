// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

import '../api/mock_fooderlich_service.dart';
import '../models/models.dart';
import '../components/components.dart';

// class ExploreScreen extends StatelessWidget {

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final mockService = MockFooderlichService();
  // A MockFooderlichService, to mock server responses.

  // Flutter : let’s know the ScrollController and ScrollNotification
  //https://medium.com/@diegoveloper/flutter-lets-know-the-scrollcontroller-and-scrollnotification-652b2685a4ac
  //! Also check other people's code at the bottom
  String message = '';
  late ScrollController _controller; // see below for 'late'.
  // Non-nullable instance field '_controller' must be initialized. Try adding
  //an initializer expression, or a generative constructor that initializes it,
  //or mark it 'late'.

  @override
  void initState() {
    // Create an instance of ScrollController in the initState().
    _controller = ScrollController();
    // Add a scroll listener to the scroll controller.
    _controller.addListener(_scrollListener);
    // Now we are listening to the Scroll events
    //
    super.initState(); //?? tf does this line do?
  }

  // Dispose your scroll scrollListener()/_scrollListener().
  @override
  void dispose() {
    _controller.removeListener(_scrollListener);

    super.dispose();
  }
  // Getting scrolling events using ScrollController
  //https://developermemos.com/posts/scrolling-events-scroll-controller
  // https://api.flutter.dev/flutter/widgets/ScrollController/dispose.html
  // https://github.com/flutter/flutter/blob/18116933e77adc82f80866c928266a5b4f1ed645/packages/flutter/lib/src/widgets/scroll_controller.dart#L196

  //
  // ExploreScreen({Key? key}) : super(key: key); //??

  // @override
  // Widget build(BuildContext) {
  //   // return const Center(
  //   //   child: Text('123'),
  //   // );

  //   return FutureBuilder(
  //     // Within the widget’s build(), you create a FutureBuilder.
  //     //Use a FutureBuilder to wait for an asynchronous task to complete.

  //     future: mockService.getExploreData(),
  //    // ?? The FutureBuilder takes in a Future as a parameter. getExploreData()
  //     //creates a future(which one exactly is the future?) that will, in turn,
  //     //return an ExploreData instance. That instance will contain two lists,
  //     //todayRecipes and friendPosts.
  //     builder: (context, AsyncSnapshot<ExploreData> snapshot) {
  //       // Check the state of the future within the builder callback.
  //       //Within builder, you use snapshot to check the current state of the
  //       //Future.

  //       //?? Now, the Future is complete and you can extract the data to pass to
  //       //your widget. How is the Future complete?
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         final recipes = snapshot.data?.todayRecipes ?? [];
  //         // snapshot.data returns ExploreData, from which you extract
  //         //'todayRecipes' to pass to the list view.

  //         // return Center(
  //         //   child: Container(
  //         //     child: const Text('Show TodayRecipeListView'),
  //         //   ),
  //         // );

  //         return TodayRecipeListView(recipes: recipes);
  //       } else {
  //         // The future is still loading, so you show a spinner to let the user
  //         //know something is happening.
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // building the nested ListView --> "FutureBuilder()"

    // return Container(  //!! wanted to display the "message" properly
    return FutureBuilder(
      // Use a FutureBuilder to wait for an asynchronous task to complete.

      // child: FutureBuilder(
      future: mockService.getExploreData(),
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        // Check the state of the future within the builder callback.
        //
        // Check if the future is complete.
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            // When the future is complete, return the primary ListView. This
            //holds an explicit list of children. In this scenario, the primary
            //ListView will hold the other two ListViews as children.
            scrollDirection: Axis.vertical,
            // Set the scroll direction to vertical, although that’s the default
            //value.
            //
            controller: _controller,
            // With this we have our ListView connected with our
            //ScrollController
            children: [
              //!! This container is to show the scroll status. Find a proper
              //way to display this container.
              // Container(
              //   height: 50.0,
              //   color: Colors.green,
              //   child: Center(
              //     child: Text(message),
              //   ),
              // ),

              // The first item in children is TodayRecipeListView. You pass in
              //the list of todayRecipes from ExploreData.
              TodayRecipeListView(recipes: snapshot.data?.todayRecipes ?? []),
              const SizedBox(height: 26),
              // Add a 16-point vertical space so the lists aren’t too close to
              //each other.

              // Container(
              //   height: 400,
              //   color: Colors.green,
              // )
              FriendPostListView(friendPosts: snapshot.data?.friendPosts ?? []),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // Create scrollListener() to listen to the scroll position.
  void _scrollListener() {
    // But how we can know if the scroll reached the top or bottom? We just have
    //to add these validations:
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('I am at the bottom!');
      // setState(() {
      //   message = 'Reached the bottom';
      // });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      print('I am at the top!');
      // setState(() {
      //   message = 'Reached the top';
      // });
    }
  }
}

// -----------------------------Other people's code-----------------------------

// Regarding Scrollcontroller
/*
https://forums.raywenderlich.com/t/why-using-a-statefulwidget-to-implement-the-first-challenge-solution-in-chapter-5/154595/7

Is there any reason to use a StatefullWidget to implement the solution for the
first challenge in Chapter 5?

I have simply used a local variable for ScrollController in the build() method 
of the ExploreScreen StatelessWidget and it worked perfectly, but as I’m new to 
Flutter I’m not sure of the tradeoffs of this solution compared to the book 
solution.

Could anyone give an explanation, please?

this is how my solution look:

  class ExploreScreen extends StatelessWidget {
    final fooderlichService = MockFooderlichService();

    ExploreScreen({Key? key}) : super(key: key);

    @override

    Widget build(BuildContext context) {
      final scrollController = ScrollController();
      scrollController.addListener(() {
        final minPos = scrollController.position.minScrollExtent;
        final maxPos = scrollController.position.maxScrollExtent;
        if (scrollController.offset == minPos) {
          print("I'm at the top");
        }
        if (scrollController.offset == maxPos) {
          print("I'm at the bottom");
        }
      });

      return FutureBuilder(
        future: fooderlichService.getExploreData(),
        builder: (context, AsyncSnapshot<ExploreData> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final recipes = snapshot.data?.todayRecipes ?? [];
            final posts = snapshot.data?.friendPosts ?? [];
            return ListView(
              controller: scrollController,
              children: [
                TodayRecipeListView(recipes: recipes),
                FriendPostListView(posts: posts),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }
*/