import 'package:fono_terapia/shared/model/sub_category.dart';

class Category {
  final int id;
  final String name;
  final List<SubCategory> subCategoriesList;

  Category(
    this.id,
    this.name,
    this.subCategoriesList,
  );
}
