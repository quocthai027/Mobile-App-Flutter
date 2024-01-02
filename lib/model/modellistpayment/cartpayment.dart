import 'productpayment.dart';
import 'variantpayment.dart';

class CartPayment {
  int id;
  int productId;
  int variantId;
  int quantity;
  double price;
  int paymentId;
  int userId;
  ProductPayment product;
  VariantPayment variant;

  CartPayment({
   required this.id,
   required this.productId,
   required this.variantId,
 required   this.quantity,
   required this.price,
 required   this.paymentId,
 required   this.userId,
 required   this.product,
  required  this.variant,
  });

  factory CartPayment.fromJson(Map<String, dynamic> json) {
    return CartPayment(
      id: json['id'],
      productId: json['product_id'],
      variantId: json['variant_id'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      paymentId: json['payment_id'],
      userId: json['user_id'],
      product: ProductPayment.fromJson(json['product']),
      variant: VariantPayment.fromJson(json['variant']),
    );
  }
}