class ImagePayment {
  int id;
  int productId;
  String image;
  String imagePath;

  ImagePayment({
  required  this.id,
 required   this.productId,
  required  this.image,
 required   this.imagePath,
  });

  factory ImagePayment.fromJson(Map<String, dynamic> json) {
    return ImagePayment(
      id: json['id'],
      productId: json['product_id'],
      image: json['image'],
      imagePath: json['image_path'],
    );
  }
}