import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/meal_detail.dart';

class ApiService {
  static const _base = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<CategoryModel>> fetchCategories() async {

    final url = Uri.parse('$_base/categories.php');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List cats = data['categories'] ?? [];
      return cats.map((c) => CategoryModel.fromJson(c)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Meal>> fetchMealsByCategory(String category) async {
    final url = Uri.parse('$_base/filter.php?c=$category');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List meals = data['meals'] ?? [];
      return meals.map((m) => Meal.fromJson(m)).toList();
    } else {
      throw Exception('Failed to load meals for category');
    }
  }

  Future<List<Meal>> searchMeals(String query) async {
    final url = Uri.parse('$_base/search.php?s=$query');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List? meals = data['meals'];
      if (meals == null) return [];
      return (meals).map((m) => Meal.fromJson(m)).toList();
    } else {
      throw Exception('Search failed');
    }
  }

  Future<MealDetail> lookupMeal(String id) async {
    final url = Uri.parse('$_base/lookup.php?i=$id');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List meals = data['meals'] ?? [];
      if (meals.isEmpty) throw Exception('Meal not found');
      return MealDetail.fromJson(meals[0]);
    } else {
      throw Exception('Lookup failed');
    }
  }

  Future<MealDetail> randomMeal() async {
    final url = Uri.parse('\$_base/random.php');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List meals = data['meals'] ?? [];
      return MealDetail.fromJson(meals[0]);
    } else {
      throw Exception('Random fetch failed');
    }
  }
}
