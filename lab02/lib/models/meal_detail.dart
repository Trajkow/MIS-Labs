class MealDetail {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final String youtube;
  final Map<String, String> ingredients;

  MealDetail({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.youtube,
    required this.ingredients,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    // parse ingredients (up to 20)
    Map<String, String> ing = {};
    for (int i = 1; i <= 20; i++) {
      final ingKey = 'strIngredient\$i';
      final measureKey = 'strMeasure\$i';
      final ingredient = json[ingKey];
      final measure = json[measureKey];
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ing[ingredient.toString()] = measure?.toString() ?? '';
      }
    }

    return MealDetail(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      category: json['strCategory'] as String? ?? '',
      area: json['strArea'] as String? ?? '',
      instructions: json['strInstructions'] as String? ?? '',
      thumbnail: json['strMealThumb'] as String? ?? '',
      youtube: json['strYoutube'] as String? ?? '',
      ingredients: ing,
    );
  }
}
