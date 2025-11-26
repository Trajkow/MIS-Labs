import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';
import 'meals_by_category_screen.dart';
import '../widgets/search_input.dart';
import '../models/meal_detail.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ApiService api = ApiService();
  List<CategoryModel> _all = [];
  List<CategoryModel> _filtered = [];
  bool _loading = true;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final cats = await api.fetchCategories();
      setState(() {
        _all = cats;
        _filtered = cats;
      });
    } catch (e) {
      // handle error
    } finally {
      setState(() => _loading = false);
    }
  }

  void _onSearch(String q) {
    setState(() {
      _query = q;
      _filtered = _all.where((c) => c.name.toLowerCase().contains(q.toLowerCase())).toList();
    });
  }

  Future<void> _showRandom() async {
    try {
      final MealDetail m = await api.randomMeal();
      if (!mounted) return;
      Navigator.pushNamed(context, '/mealDetail', arguments: m);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load random meal')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(onPressed: _showRandom, icon: const Icon(Icons.casino)),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _load,
        child: Column(
          children: [
            SearchInput(onChanged: _onSearch, hint: 'Search categories'),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.78,
                ),
                itemCount: _filtered.length,
                itemBuilder: (ctx, i) {
                  final c = _filtered[i];
                  return CategoryCard(
                    category: c,
                    onTap: () => Navigator.pushNamed(context, MealsByCategoryScreen.routeName, arguments: c.name),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
