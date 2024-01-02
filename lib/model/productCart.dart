import 'package:AdsaxShop/model/category.dart';
import 'package:AdsaxShop/model/imageMD.dart';

class ProductCart {
  final int id;
  final String name;
  final String description;
  final int price;
  final int categoryId;
  final int views;
  final int isdeleted;
  final Category category;
  final List<Image> images;

  ProductCart({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.views,
    required this.isdeleted,
    required this.category,
    required this.images,
  });

  factory ProductCart.fromJson(Map<String, dynamic> json) {
    return ProductCart(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      categoryId: json['category_id'],
      views: json['views'],
      isdeleted: json['is_deleted'],
      category: Category.fromJson(json['category']),
      images: (json['images'] as List<dynamic>)
          .map((image) => Image.fromJson(image))
          .toList(),
    );
  }
}
