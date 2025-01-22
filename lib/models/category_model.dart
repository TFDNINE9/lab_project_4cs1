import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromMap(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Category {
  final int categoryId;
  final String categoryName;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
