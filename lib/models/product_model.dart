import 'dart:convert';
import 'package:lab_project_4cs1/models/category_model.dart';
import 'package:lab_project_4cs1/models/unit_model.dart';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromMap(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Product {
  final int productId;
  final String productName;
  final int quantity;
  final int price;
  final int salePrice;
  final int categoryId;
  final int unitId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Category category;
  final Unit unit;

  Product({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.salePrice,
    required this.categoryId,
    required this.unitId,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.unit,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        productName: json["product_name"],
        quantity: json["quantity"],
        price: json["price"],
        salePrice: json["sale_price"],
        categoryId: json["category_id"],
        unitId: json["unit_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        category: Category.fromMap(json["category"]),
        unit: Unit.fromMap(json["unit"]),
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "product_name": productName,
        "quantity": quantity,
        "price": price,
        "sale_price": salePrice,
        "category_id": categoryId,
        "unit_id": unitId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "category": category.toMap(),
        "unit": unit.toMap(),
      };
}
