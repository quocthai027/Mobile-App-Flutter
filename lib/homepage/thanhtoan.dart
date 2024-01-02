import 'package:flutter/material.dart';
import 'package:AdsaxShop/homepage/thanhtoanfail.dart';
import 'package:AdsaxShop/homepage/thanhtoansuccess.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/63tinhthanh.dart';
import '../model/cartMD.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  final List<Cart> cartItems;

  final double totalPrice;
  const PaymentPage({required this.cartItems, required this.totalPrice});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late BuildContext _context;
  final formKey = GlobalKey<FormState>();
  String? selectedCity;

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  double shippingFee = 3.0;
  double discountPercentage =
      0.5; // Phần trăm giảm giá khi mua từ 3 sản phẩm trở lên
  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    phoneNumberController.dispose();
    noteController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalQuantity = 0; // Tính tổng số lượng sản phẩm trong giỏ hàng
    _context = context;
    for (var cart in widget.cartItems) {
      totalQuantity += cart.quantity;
    }
    double shipping = shippingFee * totalQuantity; // Tính tổng phí vận chuyển
    double totalShippingFee = shipping; // Giá trị phí vận chuyển ban đầu
    double tongtien;
    if (totalQuantity >= 3) {
      tongtien = widget.totalPrice + totalShippingFee * 0.5;
    } else {
      tongtien = widget.totalPrice + totalShippingFee;
    }
    String tongtienString = tongtien.toStringAsFixed(2);
    if (totalQuantity >= 3) {
      // Nếu mua từ 3 sản phẩm trở lên, áp dụng giảm giá
      totalShippingFee *= (1 - discountPercentage);
    }
    print('Độ dài của danh sách cartItems: ${widget.cartItems.length}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Đặt màu nền trong suốt cho AppBar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.orange],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: Text('Thanh toán'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 8),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tên không được bỏ trống';
                  }
                  if (value.contains(RegExp(r'\d'))) {
                    return 'Tên không được chứa số';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Tên',
                  prefixIcon: Icon(Icons.account_circle_sharp),
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: addressController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Địa chỉ không được bỏ trống';
                  }
                  // bool emailValid =
                  //     RegExp(r'^.+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$')
                  //         .hasMatch(value);

                  // if (emailValid) {
                  //   return null;
                  // } else {
                  //   return 'Email không đúng định dạng';
                  // }
                },
                decoration: InputDecoration(
                  labelText: 'Địa chỉ',
                  prefixIcon: Icon(Icons.home_work_outlined),
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                ),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                  value: selectedCity,
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Vui lòng chọn thành phố';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Thành phố',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    prefixIcon: Icon(Icons.location_city),
                  ),
                  items: dropdownItems),
              SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneNumberController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Số điện thoại không được bỏ trống';
                  }
                  if (value.length < 10) {
                    return 'Số điện thoại phải từ 10-11 số';
                  }
                  if (!RegExp(r'^0\d{9,10}$').hasMatch(value)) {
                    return 'Số điện thoại không hợp lệ';
                  }
                  // bool emailValid =
                  //     RegExp(r'^.+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$')
                  //         .hasMatch(value);

                  // if (emailValid) {
                  //   return null;
                  // } else {
                  //   return 'Email không đúng định dạng';
                  // }
                },
                decoration: InputDecoration(
                  labelText: 'Số điện thoại',
                  prefixIcon: Icon(Icons.phone),
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: noteController,
                decoration: InputDecoration(
                  labelText: 'Ghi chú (lưu ý cho chúng tôi)',
                  prefixIcon: Icon(Icons.note_alt_outlined),
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: MediaQuery.of(context).size.height * 0.32,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.cartItems.length,
                  itemBuilder: (context, index) {
                    Cart cart = widget.cartItems[index];
                    return Card(
                      elevation: 10,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Image.network(
                          cart.product.images[0].imagePath,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          cart.product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Text(
                              'Giá: \$${cart.price * cart.quantity}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Màu: ${cart.variant.color}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Size: ${cart.variant.size}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Số lượng: ${cart.quantity}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 4),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Tiền sản phẩm:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${widget.totalPrice}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Phí vận chuyển: ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              if (totalQuantity >= 3)
                                TextSpan(
                                  text: '\$${shipping}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.red,
                                  ),
                                ),
                              TextSpan(
                                text: '\$${totalShippingFee}',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Tổng tiền:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${widget.totalPrice + totalShippingFee}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.orange],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius:
                      BorderRadius.circular(8), // Đặt bo góc cho Container
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:
                        Colors.transparent, // Đặt màu nền trong suốt cho nút
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      String name = nameController.text.toString();
                      String address = addressController.text.toString();
                      String city = cityController.text.toString();
                      String phoneNumber =
                          phoneNumberController.text.toString();
                      String note = noteController.text.toString();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => UsePaypal(
                              sandboxMode: true,
                              clientId:
                                  "AUjMCnOm2baWNJPP-TEv_1beOKQsDJAhFukUAqOnoFJwhChUdaY-er5tDs_V94cLzX3ApoY3Z-7XPaCu",
                              secretKey:
                                  "ELtAIhNg0gMaUpPaW1rPNn5QOXykO8hKQHP3otVM7DwSiW1SW0bVmraVVTIDOxd9FjjF1ipN_lMGg3_W",
                              returnURL: "https://samplesite.com/return",
                              cancelURL: "https://samplesite.com/cancel",
                              transactions: [
                                {
                                  "amount": {
                                    "total":
                                        widget.totalPrice + totalShippingFee,
                                    "currency": "USD",
                                    "details": {
                                      "subtotal": widget.totalPrice,
                                      "shipping": shipping,
                                      "shipping_discount":
                                          shippingFee * totalQuantity -
                                              totalShippingFee,
                                    },
                                  },
                                  "description": note,
                                  // "payment_options": {
                                  //   "allowed_payment_method":
                                  //       "INSTANT_FUNDING_SOURCE"
                                  // },
                                  "item_list": {
                                    "items": widget.cartItems.map((cart) {
                                      return {
                                        "name": cart.product.name,
                                        "quantity": cart.quantity,
                                        "price": cart.price,
                                        "currency": "USD",
                                      };
                                    }).toList(),
                                    "shipping_address": {
                                      "recipient_name": name,
                                      "line1": address,
                                      "line2": "",
                                      "city": selectedCity,
                                      "country_code": "VN",
                                      "phone": "+00000000",
                                      "state": phoneNumber,
                                    },
                                  },
                                }
                              ],
                              note:
                                  "Contact us for any questions on your order.",
                              onSuccess: (Map params) async {
                                List<String> idCartds = [];
                                for (var cart in widget.cartItems) {
                                  idCartds.add(cart.id.toString());
                                }
                                String cartIdsString = idCartds.join(',');
                                // String cartIdsString = idCartds.join(',');
                                String currentDate = getCurrentDate();
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                String? token2 = pref.getString('login');
                                // print("onSuccess: $params");

                                print('cartIdsString la ${cartIdsString}');
                                Map<String, dynamic> apiParams = {
                                  'recipient_name': name,
                                  'address': address + ' ' + selectedCity!,
                                  'phone': phoneNumber,
                                  'note': note,
                                  'receive_date': currentDate,
                                  'total_price': tongtienString,
                                  'cart_ids': cartIdsString,
                                };
                                final url = Uri.parse(
                                    'http://45.32.19.162/shopping-api/payment/add-payment.php');

                                final response = await http.post(
                                  url,
                                  headers: {
                                    'Authorization': 'Bearer $token2',
                                    'Content-Type':
                                        'application/x-www-form-urlencoded',
                                  },
                                  body: apiParams,
                                );
                                if (response.statusCode == 200) {
                                  // Xóa thành công, xử lý kết quả response nếu cần
                                  print('Dat hang thanh cong roi');
                                  Navigator.push(
                                    _context,
                                    MaterialPageRoute(
                                      builder: (_context) => ThanhToanSuccess(),
                                    ),
                                  );
                                } else {
                                  print('Dat hang that bai roi');
                                  Navigator.push(
                                    _context,
                                    MaterialPageRoute(
                                      builder: (_context) => ThanhToanFail(),
                                    ),
                                  );
                                }
                              },
                              onError: (error) {
                                print("onError: $error");
                              },
                              onCancel: (params) {
                                print('cancelled: $params');
                              }),
                        ),
                      );
                    }
                    // Lấy thông tin từ các TextField
                  },
                  child: Text('Thanh toán qua PayPal'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate =
        '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    return formattedDate;
  }
}
