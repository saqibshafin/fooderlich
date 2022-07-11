import 'package:flutter/material.dart';

import 'components.dart';
import '../models/models.dart';

class FriendPostListView extends StatelessWidget {
  final List<Post> friendPosts;

  const FriendPostListView({
    Key? key,
    required this.friendPosts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 0,
      ),
      child: Column(
        // Create a Column to position the Text followed by the posts in a
        //vertical layout.
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Create the Text widget header.
          Text(
            'Social Chefs 👩‍🍳',
            style: Theme.of(context).textTheme.headline1,
          ),
          // Apply a spacing of 16 points vertically.
          const SizedBox(height: 16),
          //
          // List view of the friends' posts
          ListView.separated(
            // 'ListView.separated' widget creates two 'IndexedWidgetBuilders'
            //callbacks- itemBuilder & seperatorBuilder.
            primary: false,
            //?? Since you’re nesting two list views, it’s a good idea to set
            //primary to false. That lets Flutter know that this isn’t the
            //primary scroll view.
            physics: const NeverScrollableScrollPhysics(),
            //?? Set the scrolling physics to NeverScrollableScrollPhysics. Even
            //though you set primary to false, it’s also a good idea to disable
            //the scrolling for this list view. That will propagate up to the
            //parent list view.
            shrinkWrap: true,
            // Set shrinkWrap to true to create a fixed-length scrollable list
            //of items. This gives it a fixed height. If this were false, you’d
            //get an unbounded height error.
            // Especially in a nested list view, remember to set shrinkWrap to
            //true so you can give the scroll view a fixed height for all the
            //items in the list.
            //?? But is the height visible? what is it's size?
            scrollDirection: Axis.vertical,
            itemCount: friendPosts.length,
            itemBuilder: (context, index) {
              // For every item in the list, create a FriendPostTile.
              final post = friendPosts[index];
              return FriendPostTile(
                post: post,
              );
            },
            separatorBuilder: (context, index) {
              // For every item, also create a SizedBox to space each item by 16
              //points.
              return const SizedBox(
                height: 16,
              );
            },
          ),
          // Leave some padding at the end of the list.
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
