import 'package:flutter/material.dart';
import 'package:meals_app/categories_page.dart';
import 'package:meals_app/favourite_screen.dart';
import 'package:meals_app/main_drawer.dart';

import 'models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  TabsScreen(this.favouriteMeals);
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String,Object>> _pages;

  @override
  initState(){
    _pages = [
      {'page': CategoriesPage(),'title': 'Categories'},
      {'page': FavouriteScreen(widget.favouriteMeals),'title': 'Favourites'},
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState((){
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title'] as String),
        ),
        drawer: MainDrawer(),
        body: _pages[_selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectedPage,
          currentIndex: _selectedPageIndex,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), label: 'Favourites'),
          ],
        ),
      ),
    );
  }
}
