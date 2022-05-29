import 'package:flutter/material.dart';
import 'package:meals_app/categories_page.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/meal_item.dart';
import 'package:meals_app/models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-screen';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  bool _loadedInitState = false;


  @override
  void initState() {

  }

  @override
  void didChangeDependencies(){
    if(!_loadedInitState){
      final routeArg =
      ModalRoute
          .of(context)
          ?.settings
          .arguments as Map<String, String>;
      categoryTitle = routeArg['title'] as String;
      final categoryId = routeArg['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      super.didChangeDependencies();
      _loadedInitState = true;
    }

  }

  void _removeMeals(String mealId){
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              complexity: displayedMeals[index].complexity,
              affordability: displayedMeals[index].affordability,
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
