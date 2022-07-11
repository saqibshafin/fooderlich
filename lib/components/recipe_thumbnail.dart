import 'package:flutter/material.dart';

import '../models/models.dart';

class RecipeThumbnail extends StatelessWidget {
  final SimpleRecipe recipe;
  // This class requires a SimpleRecipe as a parameter. That helps configure
  //your widget.

  const RecipeThumbnail({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        // Use a Column to apply a vertical layout.

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            // The first element of the column is Expanded, which widget holds
            //on to an Image. You want the image to fill the remaining space.
            child: ClipRRect(
              // The Image is within the ClipRRect, which clips the image to
              //make the borders rounded.
              child: Image.asset(
                '${recipe.dishImage}',
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          // 6
          const SizedBox(height: 10),
          // 7
          Text(
            recipe.title,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            recipe.duration,
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}
