// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

import '../components/components.dart';
import '../models/models.dart';

class RecipesGridView extends StatelessWidget {
  // 1
  final List<SimpleRecipe> recipes;
  // RecipesGridView requires a list of recipes to display in a grid.

  const RecipesGridView({
    Key? key,
    required this.recipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 2
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      // 3
      child: GridView.builder(
        // Create a GridView.builder, which displays only the items visible
        //onscreen.
        //
        // Tell the grid view how many items will be in the grid.
        itemCount: recipes.length,
        // scrollDirection: Axis.horizontal,
        // if scrollDirection isn't defined, the default scroll direction is
        //vertical
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        // Add SliverGridDelegateWithFixedCrossAxisCount and set the
        //crossAxisCount to 2. That means that there will be only two
        //columns.
        itemBuilder: (context, index) {
          // For every index, fetch the recipe and create a corresponding
          //RecipeThumbnail.
          final simpleRecipe = recipes[index];
          return RecipeThumbnail(recipe: simpleRecipe);
        },
      ),
    );
  }
}
