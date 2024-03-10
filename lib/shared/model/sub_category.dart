class SubCategory {
  final int id;
  final String name;
  final String imagePath;
  final int section;

  SubCategory(
    this.id,
    this.name,
    this.imagePath,
    this.section,
  );

  @override
  String toString() {
    return 'SubCategory{id: $id, name: $name, imagePath: $imagePath, section: $section}';
  }

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(
      map['id'],
      map['name'],
      map['image_path'],
      map['section'],
    );
  }
}
