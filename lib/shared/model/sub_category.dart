import 'package:fono_terapia/shared/model/category.dart';

class SubCategory {
  final int id;
  final String name;
  final String imagePath;
  final int section;
  final Category? category;

  SubCategory(
    this.id,
    this.name,
    this.imagePath,
    this.section,
    this.category,
  );

  // Construtor sem o parâmetro category
  SubCategory.withoutCategory(
    this.id,
    this.name,
    this.imagePath,
    this.section,
  ) : category = null; // Inicializa category como null

  @override
  String toString() {
    return 'SubCategory{id: $id, name: $name, imagePath: $imagePath, section: $section, category: $category}';
  }
}
