import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/product.dart';
import 'chitiethinhanh.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({required this.product});

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  int currentIndex = 0;
  List<bool> isPressedList = [];
  int quantitySelectUser = 1;
  int selectedVariantIndex = -1;

  @override
  void initState() {
    super.initState();
    // Khởi tạo danh sách trạng thái ban đầu cho các container
    isPressedList = List<bool>.filled(widget.product.variants.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: false,
                      viewportFraction: 1,
                      height: 200,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                    items: widget.product.images.asMap().entries.map((entry) {
                      int index = entry.key;
                      String imageUrl = entry.value;
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhotoDetailScreen(
                                    images: widget.product.images,
                                    initialIndex: index,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  imageUrl,
                                  //fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          widget.product.images.asMap().entries.map((entry) {
                        int index = entry.key;
                        return Container(
                          width: 7.0,
                          height: 7.0,
                          margin: EdgeInsets.symmetric(horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentIndex == index
                                ? Colors.deepOrange
                                : Colors.grey,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mô tả sản phẩm',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.red,
                      decorationStyle: TextDecorationStyle.double,
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
                  SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      letterSpacing: 1.0,
                      wordSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Giá',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.red,
                      decorationStyle: TextDecorationStyle.double,
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
                  SizedBox(height: 8),
                  Text(
                    '\$${widget.product.price.toString()}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.grey,
                      decorationStyle: TextDecorationStyle.dotted,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),

                  // Text('Size ${widget.product.variants[0]['size']}'),
                  // Text('Mau ${widget.product.variants[0]['color']}'),
                  // Text('So luong  ${widget.product.variants[0]['quantity']}')

                  SizedBox(height: 8),

                  ListView.builder(
                    //   physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.product.variants.length,
                    itemBuilder: (context, index) {
                      final variant = widget.product.variants[index];
                      final quantity = variant['quantity'];
                      final color = variant['color'];
                      final size = variant['size'];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            setState(() {
                              if (selectedVariantIndex == index) {
                                // Nếu container đã được chọn trước đó, hủy chọn và đặt lại selectedVariantIndex là -1
                                selectedVariantIndex = -1;
                              } else {
                                // Nếu container chưa được chọn, gán selectedVariantIndex là chỉ số của container được chọn
                                selectedVariantIndex = index;
                              }
                            });
                            // Nếu container đã được chọn, đặt lại trạng thái và số lượng
                            if (isPressedList[index]) {
                              isPressedList[index] = false;
                              quantitySelectUser = 1;
                            } else {
                              // Đảo ngược trạng thái nhấn của container tại index
                              for (int i = 0; i < isPressedList.length; i++) {
                                isPressedList[i] = false;
                                quantitySelectUser = 1;
                              }
                              // Đặt giá trị true cho container được chọn tại index
                              isPressedList[index] = true;
                            }
                          });
                          print(
                              'Giá trị của container: $quantity, $color, $size');
                        },
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: isPressedList[index]
                                ? Colors.deepOrange
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kho: $quantity',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 16.0),
                              Text(
                                'Size: $size',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 16.0),
                              Text(
                                'Color: $color',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: selectedVariantIndex != -1
                      ? () {
                          setState(() {
                            if (quantitySelectUser > 1) {
                              quantitySelectUser--;
                            }
                          });
                        }
                      : null,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    quantitySelectUser.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: selectedVariantIndex != -1
                      ? () {
                          setState(() {
                            final selectedVariant =
                                widget.product.variants[selectedVariantIndex];
                            final variantQuantity = selectedVariant['quantity'];
                            if (quantitySelectUser < variantQuantity) {
                              quantitySelectUser++;
                            }
                          });
                        }
                      : null,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
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
                    onPressed: () {
                      if (selectedVariantIndex != -1) {
                        // Có giá trị đã được chọn, tiến hành thêm vào giỏ hàng
                        final selectedVariant =
                            widget.product.variants[selectedVariantIndex];
                        final productId = widget.product.id;
                        final variantId = selectedVariant['id'];
                        final quantity = quantitySelectUser;
                        final price = widget.product.price;
                        final quantityVariant =
                            widget.product.variants[selectedVariantIndex];
                        final variantQuantity = quantityVariant['quantity'];
                        if (variantQuantity == 0) {
                          // Hiển thị thông báo số lượng tồn kho đã hết
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Số lượng tồn kho đã hết'),
                                content: Text('Vui lòng chọn lựa chọn khác.'),
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
                        } else if (quantity > 0) {
                          // Gửi dữ liệu đến API
                          addToCart(productId, variantId, quantity, price);
                        }
                      } else {
                        // Hiển thị thông báo yêu cầu chọn giá trị
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Yêu cầu chọn giá trị'),
                              content: Text(
                                  'Vui lòng chọn một giá trị trước khi thêm vào giỏ hàng.'),
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
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      onPrimary: Colors.white,
                      elevation: 0, // Loại bỏ đường viền bóng của nút
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Thêm vào giỏ hàng',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addToCart(int productId, int variantId, int quantity, int price) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token2 = pref.getString('login');
    final token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbG9jYWxob3N0L3Nob3BwaW5nLWFwaSIsImF1ZCI6IkQ6XFxzb2Z0XFx4YW1wcFxcaHRkb2NzXFxzaG9wcGluZy1hcGkiLCJpYXQiOjE2ODcwOTg2MzYsIm5iZiI6MTY4NzA5ODY0NiwiZXhwIjoxNjg5NjkwNjM2LCJkYXRhIjp7ImlkIjo0LCJuYW1lIjoicXVhbmcifX0.aq595RF9b7NU2jFlhTGCytMmobD9fGxsIkM-BHZdN2g";
    final url = 'http://45.32.19.162/shopping-api/cart/add-to-cart.php';

    // Tạo request body
    final requestBody = {
      'product_id': productId.toString(),
      'variant_id': variantId.toString(),
      'quantity': quantity.toString(),
      'price': price.toString(),
    };

    final response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token2',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: requestBody);
    // Xử lý response từ API (nếu cần)
    print(response.statusCode);
    print(response.body);
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['success'].toString())));
      });
    } else {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['error'].toString())));
      });
    }
  }
}
