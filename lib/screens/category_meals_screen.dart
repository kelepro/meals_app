import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMelas;
  var _loadedInitDate = false;

  @override
  void initState() {
    //..
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitDate) {
      final routeArguments =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArguments['title'];
      final categoryId = routeArguments['id'];
      displayedMelas = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
    }
    _loadedInitDate = true;
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMelas.removeWhere((meal) => meal.id == mealId);
    });
  }

  // final String categoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMelas[index].id,
            title: displayedMelas[index].title,
            imageUrl: displayedMelas[index].imageUrl,
            duration: displayedMelas[index].duration,
            affordability: displayedMelas[index].affordability,
            complexity: displayedMelas[index].complexity,
            //removeItem: _removeMeal,
          );
        },
        itemCount: displayedMelas.length,
      ),
    );
  }
}
