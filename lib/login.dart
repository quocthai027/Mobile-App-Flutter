// UsePaypal(
//                         sandboxMode: true,
//                         clientId:
//                             "AUjMCnOm2baWNJPP-TEv_1beOKQsDJAhFukUAqOnoFJwhChUdaY-er5tDs_V94cLzX3ApoY3Z-7XPaCu",
//                         secretKey:
//                             "ELtAIhNg0gMaUpPaW1rPNn5QOXykO8hKQHP3otVM7DwSiW1SW0bVmraVVTIDOxd9FjjF1ipN_lMGg3_W",
//                         returnURL: "https://samplesite.com/return",
//                         cancelURL: "https://samplesite.com/cancel",
//                         transactions: [
//                           {
//                             "amount": {
//                               "total": 23,
//                               "currency": "USD",
//                               "details": const {
//                                 "subtotal": 15,
//                                 "shipping": 10,
//                                 "shipping_discount": 2
//                               }
//                             },
//                             "description":
//                                 "The payment transaction description.",
//                             // "payment_options": {
//                             //   "allowed_payment_method":
//                             //       "INSTANT_FUNDING_SOURCE"
//                             // },
//                             "item_list": {
//                               "items": [
//                                 {
//                                   "name": "A demo product",
//                                   "quantity": 2,
//                                   "price": 5,
//                                   "currency": "USD"
//                                 },
//                                 {
//                                   "name": "A demo product",
//                                   "quantity": 1,
//                                   "price": 5,
//                                   "currency": "USD"
//                                 }
//                               ],

//                               // shipping address is not required though
//                               "shipping_address": const {
//                                 "recipient_name": "Thai chu ai",
//                                 "line1": "91 duong 45",
//                                 "line2": "",
//                                 "city": "Hồ Chí Minh",
//                                 "country_code": "VN",
//                                 //     "postal_code": "20022",
//                                 "phone": "+00000000",
//                                 "state": "0358450027"
//                               },
//                             }
//                           }
//                         ],
//                         note: "Contact us for any questions on your order.",
//                         onSuccess: (Map params) async {
//                           print("onSuccess: $params");
//                           // String transactionId = params['paymentId'];
//                           // String payerId = params['payerID'];
//                           // print("test: $transactionId");
//                           //  await savePaymentInfo(transactionId, payerId);
//                           // Navigator.push(
//                           //   _context,
//                           //   MaterialPageRoute(
//                           //     builder: (_context) => ThanhToan(
//                           //       payerId: payerId,
//                           //     ),
//                           //   ),
//                           // );
//                         },
//                         onError: (error) {
//                           print("onError: $error");
//                         },
//                         onCancel: (params) {
//                           print('cancelled: $params');
//                         }),
//  SizedBox(height: 8),
//           TextField(
//             controller: nameController,
//             decoration: InputDecoration(
//               labelText: 'Tên',
//               prefixIcon: Icon(Icons.account_circle_sharp),
//               labelStyle: TextStyle(color: Colors.grey),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blue),
//               ),
//               contentPadding:
//                   EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//             ),
//           ),
//           SizedBox(height: 8),
//           TextField(
//             controller: addressController,
//             decoration: InputDecoration(
//               labelText: 'Địa chỉ',
//               prefixIcon: Icon(Icons.home_work_outlined),
//               labelStyle: TextStyle(color: Colors.grey),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blue),
//               ),
//               contentPadding:
//                   EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//             ),
//           ),
//           SizedBox(height: 8),
//           TextField(
//             controller: cityController,
//             decoration: InputDecoration(
//               labelText: 'Thành phố',
//               labelStyle: TextStyle(color: Colors.grey),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blue),
//               ),
//               contentPadding:
//                   EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//               prefixIcon: Icon(Icons.location_city),
//             ),
//           ),
//           SizedBox(height: 8),
//           TextField(
//             keyboardType: TextInputType.phone,
//             controller: phoneNumberController,
//             decoration: InputDecoration(
//               labelText: 'Số điện thoại',
//               prefixIcon: Icon(Icons.phone),
//               labelStyle: TextStyle(color: Colors.grey),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blue),
//               ),
//               contentPadding:
//                   EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//             ),
//           ),
//           SizedBox(height: 8),
//           ElevatedButton(
//             onPressed: () {
//               // Lấy thông tin từ các TextField
//               String name = nameController.text;
//               String address = addressController.text;
//               String city = cityController.text;
//               String phoneNumber = phoneNumberController.text;

//               // Thực hiện thanh toán PayPal và xử lý callbacks với thông tin đã lấy được
//               // ...
//             },
//             child: Text('Thanh toán qua PayPal'),
//           ),
// import 'package:flutter/material.dart';
// import '../model/cartMD.dart';
// import 'use_paypal.dart'; // Import the file containing the UsePaypal widget

// class PaymentPage extends StatefulWidget {
//   final List<Cart> cartItems;
//   final double totalPrice;
//   const PaymentPage({required this.cartItems, required this.totalPrice});

//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   // ... Existing code ...

//   @override
//   Widget build(BuildContext context) {
//     // ... Existing code ...

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Thanh toán'),
//       ),
//       body: Column(
//         children: [
//           // ... Existing code ...

          // Add the UsePaypal widget and pass the necessary values
          // UsePaypal(
          //   sandboxMode: true,
          //   clientId: "AUjMCnOm2baWNJPP-TEv_1beOKQsDJAhFukUAqOnoFJwhChUdaY-er5tDs_V94cLzX3ApoY3Z-7XPaCu",
          //   secretKey: "ELtAIhNg0gMaUpPaW1rPNn5QOXykO8hKQHP3otVM7DwSiW1SW0bVmraVVTIDOxd9FjjF1ipN_lMGg3_W",
          //   returnURL: "https://samplesite.com/return",
          //   cancelURL: "https://samplesite.com/cancel",
          //   transactions: [
          //     {
          //       "amount": {
          //         "total": widget.totalPrice + totalShippingFee,
          //         "currency": "USD",
          //         "details": const {
          //           "subtotal": widget.totalPrice,
          //           "shipping": shipping,
          //           "shipping_discount": shippingFee * totalQuantity - totalShippingFee,
          //         },
          //       },
          //       "description": "The payment transaction description.",
          //       "item_list": {
          //         "items": widget.cartItems.map((cart) {
          //           return {
          //             "name": cart.product.name,
          //             "quantity": cart.quantity,
          //             "price": cart.price,
          //             "currency": "USD",
          //           };
          //         }).toList(),
          //         "shipping_address": const {
          //           "recipient_name": "Thai chu ai",
          //           "line1": "91 duong 45",
          //           "line2": "",
          //           "city": "Hồ Chí Minh",
          //           "country_code": "VN",
          //           "phone": "+00000000",
          //           "state": "0358450027",
          //         },
          //       },
          //     },
          //   ],
          //   note: "Contact us for any questions on your order.",
          //   onSuccess: (Map params) async {
          //     print("onSuccess: $params");
          //     // String transactionId = params['paymentId'];
          //     // String payerId = params['payerID'];
          //     // print("test: $transactionId");
          //     //  await savePaymentInfo(transactionId, payerId);
          //     // Navigator.push(
          //     //   _context,
          //     //   MaterialPageRoute(
          //     //     builder: (_context) => ThanhToan(
          //     //       payerId: payerId,
          //     //     ),
          //     //   ),
          //     // );
          //   },
          //   onError: (error) {
          //     print("onError: $error");
          //   },
          //   onCancel: (params) {
          //     print('cancelled: $params');
          //   },
          // ),
//         ],
//       ),
//     );
//   }
// }
// {
//     "success": "Danh sách payment của user",
//     "payments": [
//         {
//             "id": 87,
//             "user_id": 8,
//             "recipient_name": "yvt",
//             "address": "fvfv",
//             "phone": 2828,
//             "note": "fvvr",
//             "receive_date": "2023-06-27",
//             "total_price": 19,
//             "status": 0,
//             "payment_status": "Chờ Shop xác nhận",
//             "carts": [
//                 {
//                     "id": 176,
//                     "product_id": 31,
//                     "variant_id": 57,
//                     "quantity": 1,
//                     "price": 6,
//                     "payment_id": 87,
//                     "user_id": 8,
//                     "product": {
//                         "id": 31,
//                         "name": "Áo thun nam ngắn tay",
//                         "description": "Áo thun nam ngắn tay sọc ngang cao cấp thời trang ATN07",
//                         "price": 6,
//                         "category_id": 1,
//                         "views": 18,
//                         "images": [
//                             {
//                                 "id": 58,
//                                 "product_id": 31,
//                                 "image": "Ao05_1.jpg",
//                                 "image_path": "http://45.32.19.162/shopping-api/public/img/Ao05_1.jpg"
//                             },
//                             {
//                                 "id": 85,
//                                 "product_id": 31,
//                                 "image": "Ao05_1.jpg",
//                                 "image_path": "http://45.32.19.162/shopping-api/public/img/Ao05_1.jpg"
//                             },
//                             {
//                                 "id": 86,
//                                 "product_id": 31,
//                                 "image": "Ao05_2.jpg",
//                                 "image_path": "http://45.32.19.162/shopping-api/public/img/Ao05_2.jpg"
//                             },
//                             {
//                                 "id": 87,
//                                 "product_id": 31,
//                                 "image": "Ao05_3.jpg",
//                                 "image_path": "http://45.32.19.162/shopping-api/public/img/Ao05_3.jpg"
//                             },
//                             {
//                                 "id": 88,
//                                 "product_id": 31,
//                                 "image": "Ao05_4.jpg",
//                                 "image_path": "http://45.32.19.162/shopping-api/public/img/Ao05_4.jpg"
//                             }
//                         ]
//                     },
//                     "variant": {
//                         "id": 57,
//                         "product_id": 31,
//                         "color": "Black",
//                         "size": "L",
//                         "quantity": 50
//                     }
//                 }
//             ]
//         },
       
//     ]
// }
//  SharedPreferences pref = await SharedPreferences.getInstance();
//   String? token2 = pref.getString('login');

//   final response = await http.get(
//     Uri.parse('http://45.32.19.162/shopping-api/payment/list-by-user.php'),
//     headers: {
//       'Authorization': 'Bearer $token2',
//     },
//   );
