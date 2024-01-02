import '../cartMD.dart';
import 'cartpayment.dart';

class Payment {
  int id;
  int userId;
  String recipientName;
  String address;
  int phone;
  String note;
  String receiveDate;
  String totalPrice;
  int status;
  String paymentStatus;
  List<CartPayment> carts;

  Payment({
    required this.id,
    required this.userId,
    required this.recipientName,
    required this.address,
    required this.phone,
    required this.note,
    required this.receiveDate,
    required this.totalPrice,
    required this.status,
    required this.paymentStatus,
    required this.carts,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    var cartList = json['carts'] as List;
    List<CartPayment> carts =
        cartList.map((item) => CartPayment.fromJson(item)).toList();

    return Payment(
      id: json['id'],
      userId: json['user_id'],
      recipientName: json['recipient_name'],
      address: json['address'],
      phone: json['phone'],
      note: json['note'],
      receiveDate: json['receive_date'],
      totalPrice: json['total_price'],
      status: json['status'],
      paymentStatus: json['payment_status'],
      carts: carts,
    );
  }
}
