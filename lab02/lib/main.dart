import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';
import 'screens/meals_by_category_screen.dart';
import 'screens/meal_detail_screen.dart';

void main() {
  runApp(const MealApp());
}

class MealApp extends StatelessWidget {
  const MealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      initialRoute: '/',
      routes: {
        '/': (context) => const CategoriesScreen(),
        MealsByCategoryScreen.routeName: (context) => const MealsByCategoryScreen(),
        MealDetailScreen.routeName: (context) => const MealDetailScreen(),
      },
    );
  }
}
