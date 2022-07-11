// import 'dart:html';

import 'package:flutter/material.dart';

import 'components.dart';
import '../models/models.dart';

class FriendPostTile extends StatelessWidget {
  final Post post;

  const FriendPostTile({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Note: There’s no height restriction on FriendPostTile. That means the
    //text can expand to many lines as long as it’s in a scroll view! This is
    //like iOS’s dynamic table views and autosizing TextViews in Android.
    return Row(
      // Create a Row to arrange the widgets horizontally.
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleImage(
          imageProvider: AssetImage(post.profileImageUrl),
          imageRadius: 20,
        ),
        const SizedBox(width: 16),
        Expanded(
          // Create Expanded, which makes the children fill the rest of the
          //container.
          child: Column(
            // Establish a Column to arrange the widgets vertically.
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.comment),
              Text(
                '${post.timestamp} mins ago',
                style: const TextStyle(fontWeight: FontWeight.w700),
              )
            ],
          ),
        )
      ],
    );
  }
}
