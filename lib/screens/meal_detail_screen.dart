import 'package:flutter/material.dart';

import '../dummy_data.dart';
import 'package:mealapp/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final accentColor = Theme.of(context).accentColor;
    final mealId = ModalRoute.of(context)!.settings.arguments as String;

    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    bool isLandScabe =
        MediaQuery.of(context).orientation == Orientation.landscape;

    var liSteps = ListView.builder(
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('# ${(index + 1)}'),
            ),
            title: Text(
              selectedMeal.steps[index],
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider()
        ],
      ),
      itemCount: selectedMeal.steps.length,
    );
    var liIngredients = ListView.builder(
      itemBuilder: (ctx, index) => Card(
        color: accentColor,
        child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Text(
              selectedMeal.ingredients[index],
              style: TextStyle(color: Colors.black),
            )),
      ),
      itemCount: selectedMeal.ingredients.length,
    );

    Widget buildContainer(Widget child) {
      var dw = MediaQuery.of(context).size.width;
      var dh = MediaQuery.of(context).size.height;

      bool isLandScabe =
          MediaQuery.of(context).orientation == Orientation.landscape;
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: isLandScabe ? (dw * 0.5) : (dw * 0.5),
        width: isLandScabe ? (dw * 0.5 - 30) : (dw),
        child: child,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: size.height*0.3,
              width: double.infinity,
              child: Hero(
                tag: mealId,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (isLandScabe)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      buildSectionTitle(context, 'Ingredients'),
                      buildContainer(liIngredients),
                    ],
                  ),
                  Column(
                    children: [
                      buildSectionTitle(context, 'Steps'),
                      buildContainer(liSteps),
                    ],
                  ),
                ],
              ),
            if (!isLandScabe) buildSectionTitle(context, 'Ingredients'),
            if (!isLandScabe) buildContainer(liIngredients),
            if (!isLandScabe) buildSectionTitle(context, 'Steps'),
            if (!isLandScabe) buildContainer(liSteps),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Provider.of<MealProvider>(context, listen: true)
                  .isMealFavorite(mealId)
              ? Icons.star
              : Icons.star_border,
        ),
        onPressed: () => Provider.of<MealProvider>(context, listen: false)
            .toggleFavorite(mealId),
      ),
    );
  }
}
