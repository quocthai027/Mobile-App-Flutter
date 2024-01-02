import 'imagepayment.dart';

class ProductPayment {
  int id;
  String name;
  String description;
  double price;
  int categoryId;
  int views;
  List<ImagePayment> images;

  ProductPayment({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.views,
    required this.images,
  });

  factory ProductPayment.fromJson(Map<String, dynamic> json) {
    var imageList = json['images'] as List;
    List<ImagePayment> images =
        imageList.map((item) => ImagePayment.fromJson(item)).toList();

    return ProductPayment(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      categoryId: json['category_id'],
      views: json['views'],
      images: images,
    );
  }
}
