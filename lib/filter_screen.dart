import 'package:flutter/material.dart';
import 'package:meals_app/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter-screen';
  final Function appliedFilters;
  final Map<String,bool> initFilter;

  FilterScreen(this.initFilter,this.appliedFilters);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  bool _lactoseFree = false;

  @override
  initState(){
    _glutenFree = widget.initFilter['gluten'] as bool;
    _vegan = widget.initFilter['vegan'] as bool;
    _vegetarian = widget.initFilter['vegetarian'] as bool;
    _lactoseFree = widget.initFilter['lactose'] as bool;
    super.initState();
  }

  Widget _buildSwitchTile(String title,
      String subtitle,
      bool filter,
      Function updateValue,) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      onChanged: updateValue as Function(bool),
      value: filter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Filter'),
          actions: [
              IconButton(onPressed: () {
                final selectedFilters = {
                  'gluten' : _glutenFree,
                  'vegan' : _vegan,
                  'vegetarian' : _vegetarian,
                  'lactose' : _lactoseFree,
                };
                widget.appliedFilters(selectedFilters);
                },
                icon: Icon(Icons.save),
              ),
            ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Filter Your Meal',
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchTile(
                      'Gluten-Free',
                      'Gluten free meals will be shown',
                      _glutenFree, (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  }),
                  _buildSwitchTile('Vegan', 'Vegan meals will be shown', _vegan,
                          (newValue) {
                        setState(() {
                          _vegan = newValue;
                        });
                      }),
                  _buildSwitchTile(
                      'Vegetarian',
                      'Vegetarian meals will be shown',
                      _vegetarian, (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  }),
                  _buildSwitchTile(
                      'Lactose-Free',
                      'Lactose free meals will be shown',
                      _lactoseFree, (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  }),
                ],
              ),
            ),
          ],
        ));
  }
}
