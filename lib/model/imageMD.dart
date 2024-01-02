class Image {
  final int id;
  final int productId;
  final String image;
  final String imagePath;

  Image({
    required this.id,
    required this.productId,
    required this.image,
    required this.imagePath,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      productId: json['product_id'],
      image: json['image'],
      imagePath: json['image_path'],
    );
  }
}