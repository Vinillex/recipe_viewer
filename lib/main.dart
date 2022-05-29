import 'package:flutter/material.dart';
import 'package:meals_app/categories_page.dart';
import 'package:meals_app/category_meals_screen.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/filter_screen.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/tabs_screen.dart';

import 'meal_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool> _filters = {
    'gluten' : false,
    'vegan' : false,
    'vegetarian' : false,
    'lactose' : false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouritedMeals = [];

  void _setFilters(Map<String,bool> filterData){
    setState((){
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal){
        if(_filters['gluten'] as bool && !meal.isGlutenFree){
          return false;
        }
        if(_filters['vegan'] as bool && !meal.isVegan){
          return false;
        }
        if(_filters['vegetarian'] as bool && !meal.isVegetarian){
          return false;
        }
        if(_filters['lactose'] as bool && !meal.isLactoseFree){
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourites(String mealId){
    final existingIndex = _favouritedMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0){
      setState(() {
        _favouritedMeals.removeAt(existingIndex);
      });
    }
    else {
      setState(() {
        _favouritedMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavourite(String id){
    return _favouritedMeals.any((meal) => meal.id == id);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amberAccent,
        canvasColor: const Color.fromRGBO(250, 250, 250, 1),
      ),
      routes: {
        '/': (ctx) => TabsScreen(_favouritedMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailsScreen.routeName: (ctx) => MealDetailsScreen(_toggleFavourites,_isMealFavourite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters,_setFilters),
      },
    );
  }
}

