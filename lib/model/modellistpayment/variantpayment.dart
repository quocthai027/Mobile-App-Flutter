class VariantPayment {
  int id;
  int productId;
  String color;
  String size;
  int quantity;

  VariantPayment({
  required  this.id,
 required   this.productId,
  required  this.color,
 required   this.size,
 required   this.quantity,
  });

  factory VariantPayment.fromJson(Map<String, dynamic> json) {
    return VariantPayment(
      id: json['id'],
      productId: json['product_id'],
      color: json['color'],
      size: json['size'],
      quantity: json['quantity'],
    );
  }
}
