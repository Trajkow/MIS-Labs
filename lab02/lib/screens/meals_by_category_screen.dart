import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import '../widgets/search_input.dart';
import 'meal_detail_screen.dart';

class MealsByCategoryScreen extends StatefulWidget {
  static const routeName = '/mealsByCategory';

  const MealsByCategoryScreen({Key? key}) : super(key: key);

  @override
  State<MealsByCategoryScreen> createState() => _MealsByCategoryScreenState();
}

class _MealsByCategoryScreenState extends State<MealsByCategoryScreen> {
  final ApiService api = ApiService();
  List<Meal> _all = [];
  List<Meal> _filtered = [];
  bool _loading = true;
  String _category = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)!.settings.arguments;
    if (arg is String) {
      _category = arg;
      _load();
    }
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final meals = await api.fetchMealsByCategory(_category);
      setState(() {
        _all = meals;
        _filtered = meals;
      });
    } catch (e) {
    } finally {
      setState(() => _loading = false);
    }
  }

  void _onSearch(String q) async {
    if (q.trim().isEmpty) {
      setState(() => _filtered = _all);
      return;
    }
    setState(() => _loading = true);
    try {
      final results = await api.searchMeals(q);
      final list = results.where((m) => true).toList();
      final names = _all.map((e) => e.name.toLowerCase()).toSet();

      setState(() {
        _filtered = list
            .where((x) => names.contains(x.name.toLowerCase()))
            .toList();
      });
    } catch (e) {
      setState(() => _filtered = []);
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_category)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SearchInput(
                  onChanged: _onSearch,
                  hint: 'Search meals in category',
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.78,
                          ),
                      itemCount: _filtered.length,
                      itemBuilder: (ctx, i) {
                        final m = _filtered[i];
                        return SizedBox(
                          child: MealCard(
                            meal: m,
                            onTap: () => Navigator.pushNamed(
                              context,
                              MealDetailScreen.routeName,
                              arguments: m.id,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
