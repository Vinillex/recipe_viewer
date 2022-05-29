import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

import 'meal_item.dart';

class FavouriteScreen extends StatelessWidget {
  final List<Meal> mealList;
  FavouriteScreen(this.mealList);

  @override
  Widget build(BuildContext context) {
    if(mealList.isEmpty){
      return Center(
        child: Text('You dont have any favourites yet'),
      );
    }else{
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: mealList[index].id,
            title: mealList[index].title,
            imageUrl: mealList[index].imageUrl,
            duration: mealList[index].duration,
            complexity: mealList[index].complexity,
            affordability: mealList[index].affordability,
          );
        },
        itemCount: mealList.length,
      );
    }

  }
}

