import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/modellistpayment/oderMD.dart';
import 'homepage.dart';

class PaymentDetailsScreen extends StatefulWidget {
  @override
  _PaymentDetailsScreenState createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  List<Payment> payments = [];
  int selectedStatus = 1;
  bool isLoading = false; // Thêm biến isLoading
  @override
  void initState() {
    super.initState();
    fetchData();
    selectedStatus = 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Danh sách đơn hàng của bạn',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueGrey,
        elevation: 0, // Remove shadow
        toolbarHeight: 50, // Adjust the height as needed
        centerTitle: true,
        titleSpacing: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
        // Customize other properties like leading, actions, etc. if needed
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: selectedStatus == 0
                          ? Colors.grey[700]
                          : Colors.orange[700],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextButton(
                      onPressed: () => changeStatus(0),
                      child: Text(
                        'Chờ xác nhận',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0), // Khoảng cách giữa các Container
                  Container(
                    decoration: BoxDecoration(
                      color: selectedStatus == 1
                          ? Colors.grey[700]
                          : Colors.orange[700],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextButton(
                      onPressed: () => changeStatus(1),
                      child: Text(
                        'Đang giao hàng',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0), // Khoảng cách giữa các Container
                  Container(
                    decoration: BoxDecoration(
                      color: selectedStatus == 2
                          ? Colors.grey[700]
                          : Colors.orange[700],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextButton(
                      onPressed: () => changeStatus(2),
                      child: Text(
                        'Đơn hoàn thành',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? Center(
                    child:
                        CircularProgressIndicator(), // Hiển thị CircularProgressIndicator khi đang tải dữ liệu
                  )
                : payments.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/carttrong.png'),
                            Text(
                              'Bạn chưa có đơn hàng nào',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.orange, // Màu chủ đạo cam
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.purple, Colors.orange],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(
                                    8), // Đặt bo góc cho Container
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Xử lý khi nhấn nút Mua sắm ngay
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()),
                                    (route) => false,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors
                                      .transparent, // Đặt màu nền trong suốt cho nút
                                  elevation:
                                      0, // Loại bỏ đường viền bóng của nút
                                ),
                                child: Text(
                                  'Mua sắm ngay',
                                  style: TextStyle(
                                    color:
                                        Colors.white, // Màu chữ trắng cho nút
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          itemCount: payments.length,
                          itemBuilder: (context, index) {
                            final payment = payments[index];
                            final cartItems = payment.carts.map((cart) {
                              return Container(
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.symmetric(vertical: 5.0),
                                decoration: BoxDecoration(
                                  color:
                                      Colors.orange[200], // Màu nền container
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Image.network(
                                        cart.product.images[0].imagePath,
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Sản phẩm: ${cart.product.name}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text('Giá sản phẩm: \$${cart.price}'),
                                          Text('Màu: ${cart.variant.color}'),
                                          Text('Size: ${cart.variant.size}'),
                                          Text('Số lượng: ${cart.quantity}'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList();

                            return Container(
                              margin: EdgeInsets.all(10.0),
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Mã đơn hàng: ${payment.id}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        'Trạng thái: ${payment.paymentStatus}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red
                                            // Màu chữ trạng thái
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    'Tổng tiền: \$${payment.totalPrice}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    'Danh sách sản phẩm:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  ...cartItems,
                                ],
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true; // Bắt đầu tải dữ liệu
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token2 = pref.getString('login');

    if (token2 != null) {
      final response = await http.get(
        Uri.parse('http://45.32.19.162/shopping-api/payment/list-by-user.php'),
        headers: {
          'Authorization': 'Bearer $token2',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final paymentData = jsonData['payments'];

        List<Payment> paymentList = List<Payment>.from(
            paymentData.map((data) => Payment.fromJson(data)));

        setState(() {
          payments = paymentList;
          isLoading = false; // Dừng tải dữ liệu khi hoàn thành
        });
      } else {
        // Xử lý khi có lỗi trong quá trình lấy dữ liệu từ API
        setState(() {
          isLoading = false; // Dừng tải dữ liệu khi có lỗi
        });
      }
    } else {
      // Xử lý khi giá trị của token2 là null
    }
  }

  Future<void> fetchDataStatus(int status) async {
    setState(() {
      isLoading = true; // Bắt đầu tải dữ liệu
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token2 = pref.getString('login');

    if (token2 != null) {
      final response = await http.get(
        Uri.parse(
            'http://45.32.19.162/shopping-api/payment/list-by-user.php?status=$status'),
        headers: {
          'Authorization': 'Bearer $token2',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final paymentData = jsonData['payments'];

        List<Payment> paymentList = List<Payment>.from(
            paymentData.map((data) => Payment.fromJson(data)));

        setState(() {
          payments = paymentList;
          isLoading = false; // Dừng tải dữ liệu khi hoàn thành
        });
      } else {
        // Xử lý khi có lỗi trong quá trình lấy dữ liệu từ API
        setState(() {
          isLoading = false; // Dừng tải dữ liệu khi có lỗi
        });
      }
    } else {
      // Xử lý khi giá trị của token2 là null
    }
  }

  void changeStatus(int status) {
    setState(() {
      selectedStatus = status;
    });
    fetchDataStatus(selectedStatus); // Gọi API khi thay đổi trạng thái
  }
}
