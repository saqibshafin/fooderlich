import 'package:flutter/material.dart';

import 'components.dart';
import '../models/models.dart';

class TodayRecipeListView extends StatelessWidget {
  final List<ExploreRecipe> recipes;

  const TodayRecipeListView({
    Key? key,
    required this.recipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        // bottom: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recipes of the Day 🍳',
            style: Theme.of(context).textTheme.headline1,
          ),
          //
          const SizedBox(height: 16), //, width: 16),
          //
          Container(
            height: 400,
            // color: Colors.grey,
            //
            color: Colors.transparent,
            // 2
            child: ListView.separated(
              // Create 'ListView.separated'. Remember, this widget creates two
              //'IndexedWidgetBuilders'- itemBuilder & seperatorBuilder.
              scrollDirection: Axis.horizontal,
              // Set the scroll direction to the horizontal axis.
              itemCount: recipes.length,
              // Set the number of items in the list view.
              itemBuilder: (context, index) {
                // Create the itemBuilder callback, which will go through every
                //item in the list.
                //
                // Get the recipe for the current index and build the card.
                final recipe = recipes[index];
                return buildCard(recipe);
              },
              separatorBuilder: (context, index) {
                // Create the separatorBuilder callback, which will go through
                //every item in the list.
                //
                return const SizedBox(width: 16);
                // For every item, you create a SizedBox to space every item 16
                //points apart.
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget buildCard(ExploreRecipe recipe) {
  if (recipe.cardType == RecipeCardType.card1) {
    return Card1(recipe: recipe);
  } else if (recipe.cardType == RecipeCardType.card2) {
    return Card2(recipe: recipe);
  } else if (recipe.cardType == RecipeCardType.card3) {
    return Card3(recipe: recipe);
  } else {
    throw Exception('This card doesn\'t exist yet');
  }
}
