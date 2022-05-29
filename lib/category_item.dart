import 'package:flutter/material.dart';
import 'package:meals_app/categories_page.dart';
import 'package:meals_app/meal_details_screen.dart';
import '../models/category.dart';
import 'category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  String id;
  String title;
  Color color;

  CategoryItem(this.id, this.title, this.color, {Key? key}) : super(key: key);

  void selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {
        'title': title,
        'id': id,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Text(title),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
