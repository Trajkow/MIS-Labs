import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal_detail.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = '/mealDetail';
  const MealDetailScreen({Key? key}) : super(key: key);

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final ApiService api = ApiService();
  MealDetail? _meal;
  bool _loading = true;
  String? _mealIdOrArg;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)!.settings.arguments;
    if (arg is String) {
      _mealIdOrArg = arg;
      _loadById(arg);
    } else if (arg is MealDetail) {
      _meal = arg;
      setState(() => _loading = false);
    }
  }

  Future<void> _loadById(String id) async {
    setState(() => _loading = true);
    try {
      final m = await api.lookupMeal(id);
      setState(() => _meal = m);
    } catch (e) {
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_meal?.name ?? 'Recipe')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _meal == null
          ? const Center(child: Text('Not found'))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_meal!.thumbnail.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(_meal!.thumbnail, fit: BoxFit.cover),
              ),
            const SizedBox(height: 12),
            Text(_meal!.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('${_meal!.category} • ${_meal!.area}'),
            const SizedBox(height: 12),
            const Text('Instructions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(_meal!.instructions),
            const SizedBox(height: 12),
            const Text('Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            ..._meal!.ingredients.entries.map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Text('- \${e.key} : \${e.value}'),
            )),
            const SizedBox(height: 12),
            if (_meal!.youtube.isNotEmpty)
              ElevatedButton.icon(
                onPressed: () async {
                  final url = _meal!.youtube.replaceFirst('watch?v=', 'embed/');
                },
                icon: const Icon(Icons.video_library),
                label: const Text('Watch on YouTube'),
              ),
          ],
        ),
      ),
    );
  }
}
