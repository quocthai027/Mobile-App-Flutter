import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:AdsaxShop/homepage/thanhtoan.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cartMD.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'homepage.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> carts = [];
  bool isLoading = true;
  double totalPrice = 0;
  Set<Cart> selectedItems = {};
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : carts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/carttrong.png'),
                      Text(
                        'Không có gì trong giỏ hàng',
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
                            elevation: 0, // Loại bỏ đường viền bóng của nút
                          ),
                          child: Text(
                            'Mua sắm ngay',
                            style: TextStyle(
                              color: Colors.white, // Màu chữ trắng cho nút
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                height: 150,
                                child:
                                    Image.asset('assets/giamgiavanchuyen.png'),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Giảm giá 50% phí vận chuyển',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Khi mua từ 3 sản phẩm trở lên',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: carts.length,
                        itemBuilder: (context, index) {
                          Cart cart = carts[index];

                          return Card(
                            elevation: 10,
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            child: ListTile(
                              leading: Image.network(
                                cart.product.images[0].imagePath,
                                width: 60,
                                height: 60,
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
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Giá:',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Colors.red,
                                            decorationStyle:
                                                TextDecorationStyle.double,
                                            letterSpacing: 1.5,
                                            wordSpacing: 2.0,
                                            shadows: [
                                              Shadow(
                                                color: Colors.grey,
                                                offset: Offset(2, 2),
                                                blurRadius: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '  \$${cart.product.price * cart.quantity}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor: Colors.grey,
                                            decorationStyle:
                                                TextDecorationStyle.dotted,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black,
                                                offset: Offset(1, 1),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Màu:',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Colors.red,
                                            decorationStyle:
                                                TextDecorationStyle.double,
                                            letterSpacing: 1.5,
                                            wordSpacing: 2.0,
                                            shadows: [
                                              Shadow(
                                                color: Colors.grey,
                                                offset: Offset(2, 2),
                                                blurRadius: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextSpan(
                                          text: '  ${cart.variant.color}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor: Colors.grey,
                                            decorationStyle:
                                                TextDecorationStyle.dotted,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black,
                                                offset: Offset(1, 1),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Size:',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Colors.red,
                                            decorationStyle:
                                                TextDecorationStyle.double,
                                            letterSpacing: 1.5,
                                            wordSpacing: 2.0,
                                            shadows: [
                                              Shadow(
                                                color: Colors.grey,
                                                offset: Offset(2, 2),
                                                blurRadius: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextSpan(
                                          text: '  ${cart.variant.size}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor: Colors.grey,
                                            decorationStyle:
                                                TextDecorationStyle.dotted,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black,
                                                offset: Offset(1, 1),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Trạng thái: ' +
                                        (cart.product.isdeleted == 0
                                            ? 'Còn hàng'
                                            : 'Hết hàng'),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        color: Colors.orange,
                                        onPressed: () {
                                          setState(() {
                                            if (cart.quantity > 1) {
                                              cart.quantity = cart.quantity - 1;
                                              updateCart(cart);
                                            }
                                          });
                                        },
                                      ),
                                      Text(
                                        '${cart.quantity}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        color: Colors.orange,
                                        onPressed: () {
                                          setState(() {
                                            if (cart.quantity <
                                                cart.variant.quantity) {
                                              cart.quantity = cart.quantity + 1;
                                              updateCart(cart);
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.grey,
                                    onPressed: () {
                                      removeCart(cart);
                                    },
                                  ),
                                  Checkbox(
                                    value: selectedItems.contains(cart),
                                    activeColor: Colors.orange,
                                    checkColor: Colors.white,
                                    onChanged: (value) {
                                      if (cart.product.isdeleted == 0) {
                                        setState(() {
                                          if (value!) {
                                            selectedItems.add(cart);
                                          } else {
                                            selectedItems.remove(cart);
                                          }
                                          calculateTotalPrice();
                                        });
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Thông báo'),
                                              content:
                                                  Text('Sản phẩm đã hết hàng.'),
                                              actions: [
                                                TextButton(
                                                  child: Text('Đóng'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Checkbox(
                            value: selectAll,
                            activeColor: Colors.orange,
                            onChanged: (value) {
                              setState(() {
                                selectAll = value!;
                                if (selectAll) {
                                  selectedItems.addAll(carts.where(
                                      (cart) => cart.product.isdeleted == 0));
                                } else {
                                  selectedItems.removeWhere(
                                      (cart) => cart.product.isdeleted == 0);
                                }
                                calculateTotalPrice();
                              });
                            },
                          ),
                          Text('Tất cả'),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            'Tổng tiền:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '\$$totalPrice',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange, // Màu chủ đạo cam
                            ),
                          ),
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
                        borderRadius: BorderRadius.circular(
                            8), // Đặt bo góc cho Container
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedItems.isEmpty) {
                            _showNoItemSelectedDialog();
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentPage(
                                  cartItems: selectedItems.toList(),
                                  totalPrice: totalPrice,
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .transparent, // Đặt màu nền trong suốt cho nút
                          elevation: 0, // Loại bỏ đường viền bóng của nút
                        ),
                        child: Text(
                          'Thanh toán giỏ hàng',
                          style: TextStyle(
                            color: Colors.white, // Màu chữ trắng cho nút
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  void _showNoItemSelectedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lỗi'),
          content: Text('Chọn ít nhất một sản phẩm để thanh toán.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  Future<void> removeCart(Cart cart) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận'),
          content:
              Text('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
                removeFromCart(cart); // Xóa sản phẩm khỏi giỏ hàng
              },
              child: Text('Xóa'),
            ),
          ],
        );
      },
    );
  }

  Future<void> removeFromCart(Cart cart) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token2 = pref.getString('login');
    final token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbG9jYWxob3N0L3Nob3BwaW5nLWFwaSIsImF1ZCI6IkQ6XFxzb2Z0XFx4YW1wcFxcaHRkb2NzXFxzaG9wcGluZy1hcGkiLCJpYXQiOjE2ODcwOTg2MzYsIm5iZiI6MTY4NzA5ODY0NiwiZXhwIjoxNjg5NjkwNjM2LCJkYXRhIjp7ImlkIjo0LCJuYW1lIjoicXVhbmcifX0.aq595RF9b7NU2jFlhTGCytMmobD9fGxsIkM-BHZdN2g";

    final url = Uri.parse(
        'http://45.32.19.162/shopping-api/cart/remove-to-cart.php?cart_id=${cart.id}');
    final body = {
      'cart_id': cart.id.toString(),
    };

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token2',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      // Xóa thành công, xử lý kết quả response nếu cần
      print('Item removed from cart successfully');
      setState(() {
        carts.remove(cart); // Xóa mục khỏi danh sách giỏ hàng
      });
    } else {
      // Xử lý khi có lỗi trong quá trình xóa mục trong giỏ hàng
    }
  }

  Future<void> fetchCartData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token2 = pref.getString('login');
    print('token 2 ne $token2');

    final response = await http.get(
      Uri.parse('http://45.32.19.162/shopping-api/cart/list.php'),
      headers: {
        'Authorization': 'Bearer $token2',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> cartList = data['carts'];
      setState(() {
        carts = cartList.map((cart) => Cart.fromJson(cart)).toList();
        isLoading = false;
        calculateTotalPrice();
      });
    } else {
      // Xử lý khi có lỗi trong quá trình lấy dữ liệu từ API
    }
  }

  void calculateTotalPrice() {
    // totalPrice = 0;
    // for (var cart in carts) {
    //   totalPrice += cart.price * cart.quantity;
    // }

    totalPrice = 0;
    for (var cart in selectedItems) {
      totalPrice += cart.price * cart.quantity;
    }
  }

  Future<void> updateCart(Cart cart) async {
    setState(() {
      calculateTotalPrice(); // Cập nhật tổng tiền
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token2 = pref.getString('login');
    final token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbG9jYWxob3N0L3Nob3BwaW5nLWFwaSIsImF1ZCI6IkQ6XFxzb2Z0XFx4YW1wcFxcaHRkb2NzXFxzaG9wcGluZy1hcGkiLCJpYXQiOjE2ODcwOTg2MzYsIm5iZiI6MTY4NzA5ODY0NiwiZXhwIjoxNjg5NjkwNjM2LCJkYXRhIjp7ImlkIjo0LCJuYW1lIjoicXVhbmcifX0.aq595RF9b7NU2jFlhTGCytMmobD9fGxsIkM-BHZdN2g";

    final url =
        Uri.parse('http://45.32.19.162/shopping-api/cart/update-cart.php');
    final body = {
      'cart_id': cart.id.toString(),
      'quantity': cart.quantity.toString(),
      'price': (cart.price * cart.quantity).toString(),
    };
    print('tien là ${totalPrice}');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token2',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      // Cập nhật thành công, xử lý kết quả response nếu cần
      print('Cart updated successfully');
    } else {
      // Xử lý khi có lỗi trong quá trình cập nhật giỏ hàng
    }
  }
}
