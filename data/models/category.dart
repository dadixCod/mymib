
class Category {
  final int? id;
  final String category;
  Category({
    this.id,
    required this.category,
  });

  Category copyWith({
    int? id,
    String? category,
  }) {
    return Category(
      id: id ?? this.id,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'category': category,
    };
  }

  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      category: map['category'],
    );
  }

  @override
  String toString() => 'Category(id: $id, category: $category)';

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id && other.category == category;
  }

  @override
  int get hashCode => id.hashCode ^ category.hashCode;
}
