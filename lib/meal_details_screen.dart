import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/favourite_screen.dart';

class MealDetailsScreen extends StatefulWidget {
  static const routeName = '/meal-details';
  final Function toggleFavourite;
  final Function isFavourite;
  MealDetailsScreen(this.toggleFavourite,this.isFavourite);

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {

  buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  buildContainer(BuildContext context, Widget child) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedItem = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedItem.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedItem.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              context,
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Colors.yellow,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        selectedItem.ingredients[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: selectedItem.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              context,
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(selectedItem.steps[index]),
                    leading: CircleAvatar(
                      child: Text('#${index + 1}'),
                    ),
                  );
                },
                itemCount: selectedItem.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() => widget.toggleFavourite(mealId),
        child: Icon(widget.isFavourite(mealId) ? Icons.star: Icons.star_border),
      ),
    );
  }

}
