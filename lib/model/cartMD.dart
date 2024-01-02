import 'package:AdsaxShop/model/productCart.dart';
import 'package:AdsaxShop/model/variantMD.dart';

class Cart {
  final int id;
  final int productId;
  final int variantId;
  late int quantity;
  final int price;
  final int paymentId;
  final int userId;
  final Variant variant;
  final ProductCart product;

  Cart({
    required this.id,
    required this.productId,
    required this.variantId,
    required this.quantity,
    required this.price,
    required this.paymentId,
    required this.userId,
    required this.variant,
    required this.product,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      productId: json['product_id'],
      variantId: json['variant_id'],
      quantity: json['quantity'],
      price: json['price'],
      paymentId: json['payment_id'] ?? 123,
      userId: json['user_id'],
      variant: Variant.fromJson(json['variant']),
      product: ProductCart.fromJson(json['product']),
    );
  }
}
// import 'package:flutter_application_20/model/productCart.dart';
// import 'package:flutter_application_20/model/variantMD.dart';

// class Cart {
//   final int id;
//   final int productId;
//   final int variantId;
//   late int quantity;
//   final int price;
//   final int paymentId;
//   final int userId;
//   final Variant variant;
//   final ProductCart product;

//   Cart({
//     required this.id,
//     required this.productId,
//     required this.variantId,
//     required this.quantity,
//     required this.price,
//     required this.paymentId,
//     required this.userId,
//     required this.variant,
//     required this.product,
//   });

//   Cart copyWith({
//     int? id,
//     int? productId,
//     int? variantId,
//     int? quantity,
//     int? price,
//     int? paymentId,
//     int? userId,
//     Variant? variant,
//     ProductCart? product,
//   }) {
//     return Cart(
//       id: id ?? this.id,
//       productId: productId ?? this.productId,
//       variantId: variantId ?? this.variantId,
//       quantity: quantity ?? this.quantity,
//       price: price ?? this.price,
//       paymentId: paymentId ?? this.paymentId,
//       userId: userId ?? this.userId,
//       variant: variant ?? this.variant,
//       product: product ?? this.product,
//     );
//   }

//   factory Cart.fromJson(Map<String, dynamic> json) {
//     return Cart(
//       id: json['id'],
//       productId: json['product_id'],
//       variantId: json['variant_id'],
//       quantity: json['quantity'],
//       price: json['price'],
//       paymentId: json['payment_id'] ?? 123,
//       userId: json['user_id'],
//       variant: Variant.fromJson(json['variant']),
//       product: ProductCart.fromJson(json['product']),
//     );
//   }
// }
