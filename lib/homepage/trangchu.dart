import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/category.dart';
import '../model/product.dart';
import 'chitiet.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productsMain = [];
  List<Category> categories = [];
  bool isLastPage = false;
  int page = 1;
  bool isLoadingMore = false;
  bool isLoading = false;

  CarouselController carouselController =
      CarouselController(); // Controller cho CarouselSlider
  int currentIndex = 0;
  TextEditingController searchproductcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchProducts(page);
    fetchCategories();
  }

  Future<void> fetchProducts(int page) async {
    setState(() {
      isLoading = true; // Đánh dấu đang tải dữ liệu
    });
    final response = await http.get(Uri.parse(
        'http://45.32.19.162/shopping-api/products/list.php?page=$page&limit=6'));
    if (response.statusCode == 200) {
      final jsonResult = json.decode(response.body);
      final productList = jsonResult['products'] as List<dynamic>;
      final bool apiIsLastPage = jsonResult['is_last_page'];
      final bool hasMoreData = (productList.length > 0);
      print('gia tri page $page');
      setState(() {
        isLastPage = apiIsLastPage;
        isLoading = false;
        productsMain = productList
            .map((item) => Product(
                  id: item['id'],
                  name: item['name'],
                  description: item['description'],
                  price: item['price'],
                  images: List<String>.from(item['images_list']),
                  variants: List<Map<String, dynamic>>.from(item['variants']),
                  views: item['views'],
                ))
            .toList();
      });
      isLoadingMore = false;
      if (!hasMoreData) {
        isLastPage = true;
      }
    } else {
      throw Exception('Failed to fetch products');
      // Handle errors
    }
  }

  Future<void> fetchProductsTopView() async {
    final response = await http.get(Uri.parse(
        'http://45.32.19.162/shopping-api/products/top-10.php?order_by=views'));
    if (response.statusCode == 200) {
      final jsonResult = json.decode(response.body);
      final productList = jsonResult['products'] as List<dynamic>;
      setState(() {
        page = 0;
        productsMain = productList
            .map((item) => Product(
                  id: item['id'],
                  name: item['name'],
                  description: item['description'],
                  price: item['price'],
                  images: List<String>.from(item['images_list']),
                  variants: List<Map<String, dynamic>>.from(item['variants']),
                  views: item['views'],
                ))
            .toList();
      });
    } else {
      throw Exception('Failed to fetch products top view');
      // Handle errors
    }
  }

  Future<void> SearchProduct() async {
    final textserch = searchproductcontroller.text;
    final response = await http.get(Uri.parse(
        'http://45.32.19.162/shopping-api/products/list.php?search=$textserch&limit=6'));
    if (response.statusCode == 200) {
      final jsonResult = json.decode(response.body);
      final productList = jsonResult['products'] as List<dynamic>;
      setState(() {
        productsMain = productList
            .map((item) => Product(
                  id: item['id'],
                  name: item['name'],
                  description: item['description'],
                  price: item['price'],
                  images: List<String>.from(item['images_list']),
                  variants: List<Map<String, dynamic>>.from(item['variants']),
                  views: item['views'],
                ))
            .toList();
      });
    } else {
      throw Exception('Failed to fetch products search');
      // Handle errors
    }
  }

  Future<List<Category>> fetchCategories() async {
    final response = await http
        .get(Uri.parse('http://45.32.19.162/shopping-api/categories/list.php'));
    if (response.statusCode == 200) {
      final jsonResult = json.decode(response.body);
      final jsonCategories = jsonResult['categories'] as List<dynamic>;
      return jsonCategories.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  Future<List<Product>> fetchProductsByCategory(Category category) async {
    final response = await http.get(Uri.parse(
        'http://45.32.19.162/shopping-api/products/product-by-category.php?category_id=${category.id}&page=-1'));
    if (response.statusCode == 200) {
      final jsonResult = json.decode(response.body);

      final productList = jsonResult['products'] as List<dynamic>;
      print('dsadsa $productList');
      print(' ${category.id}');
      // Lọc danh sách sản phẩm chỉ lấy những sản phẩm thuộc danh mục cụ thể
      final filteredProducts = productList
          .where((item) => item['category_id'] == category.id)
          .toList();

      return filteredProducts
          .map((item) => Product(
                id: item['id'],
                name: item['name'],
                description: item['description'],
                price: item['price'],
                images: List<String>.from(item['images_list']),
                variants: List<Map<String, dynamic>>.from(item['variants']),
                views: item['views'],
              ))
          .toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> temporaryItems = [
      Image.network(
        'http://45.32.19.162/shopping-api/public/img/bn1.jpg',
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
      ),
      Image.network(
        'http://45.32.19.162/shopping-api/public/img/bn2.jpg',
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
      ),
      Image.network(
        'http://45.32.19.162/shopping-api/public/img/bn3.jpg',
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
      ),
      Image.network(
        'http://45.32.19.162/shopping-api/public/img/bn4.jpg',
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
      ),
      Image.network(
        'http://45.32.19.162/shopping-api/public/img/bn5.jpg',
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
      ),
      Image.network(
        'http://45.32.19.162/shopping-api/public/img/bn6.jpg',
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
      ),
    ];
    return Scaffold(
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: searchproductcontroller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Tìm kiếm sản phẩm',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.all(8.0),
              ),
              onChanged: (value) {
                SearchProduct();
              },
            ),
          ),
        ),

        Stack(
          children: [
            CarouselSlider(
              carouselController: carouselController,
              items: temporaryItems,
              options: CarouselOptions(
                // Các thuộc tính khác
                enlargeCenterPage: false,
                viewportFraction: 1,
                // Thêm chỉ số trang
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                //...
                scrollDirection: Axis.horizontal,
                // Chỉ số trang
                pageViewKey: PageStorageKey<String>('carousel_slider'),
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: temporaryItems.map((image) {
                  int index = temporaryItems.indexOf(image);
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
        FutureBuilder<List<Category>>(
          future: fetchCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final _categories = snapshot.data!;
              return Container(
                height: 40, // Đặt chiều cao cố định của danh sách
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return GestureDetector(
                      onTap: () {
                        updateCategoryProducts(category);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 8),
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: [Colors.grey, Colors.orange],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Text(
                          category.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return Container();
          },
        ),
        ElevatedButton(
          onPressed: () {
            // Hành động khi nhấn nút "Xem thêm"
            fetchProductsTopView();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.deepOrange,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text('Top 10 sản phẩm có lượt xem nhiều nhất'),
        ),
        // ListView.builder(
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),
        //   itemCount: categories.length,
        //   itemBuilder: (context, index) {
        //     final category = categories[index];
        //     return ListTile(
        //       title: Text(category.name),
        //       subtitle: Text(category.description),
        //     );
        //   },
        // ),
        isLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: productsMain.length +
                    (isLoadingMore
                        ? 1
                        : 0), // Kiểm tra isLastPage để quyết định số lượng item,
                itemBuilder: (context, index) {
                  if (index < productsMain.length) {
                    final product = productsMain[index];
                    return // Trong màn hình danh sách sản phẩm
                        GestureDetector(
                      onTap: () {
                        UpdateViews(product);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: product),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.network(
                                  product.images[0],
                                  width: MediaQuery.of(context).size.width,
                                  // fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  RichText(
                                    maxLines: 2, // Giới hạn chỉ 2 dòng
                                    overflow: TextOverflow
                                        .ellipsis, // Thêm dấu "..." nếu văn bản dài hơn
                                    text: TextSpan(
                                      text: product.description,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '\$${product.price}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      decoration: TextDecoration.lineThrough,
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
                          ],
                        ),
                      ),
                    );
                  } else {
                    // Khi đến trang cuối cùng, không cần hiển thị gì thêm
                    return SizedBox();
                  }
                },
              ),

        Container(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: decreasePage,
                child: Icon(Icons.arrow_back),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: EdgeInsets.all(10),
                  shape: CircleBorder(),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Trang $page', // Hiển thị số trang hiện tại
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: increasePage,
                child: Icon(Icons.arrow_forward),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: EdgeInsets.all(10),
                  shape: CircleBorder(),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  void decreasePage() {
    if (page > 1) {
      setState(() {
        page--;
        fetchProducts(page);
      });
    }
  }

  void increasePage() {
    if (!isLoadingMore) {
      setState(() {
        isLoadingMore = true;

        if (isLastPage) {
          if (page > 1) {
            page--;
            fetchProducts(page); // Gọi lại fetchProducts với page đã giảm đi 1
          }

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Thông báo'),
              content: Text('Đây là trang cuối cùng.'),
              actions: [
                TextButton(
                  child: Text('Đóng'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        } else {
          page++;
          fetchProducts(page); // Gọi fetchProducts với page đã tăng lên
        }
      });
    }
  }

  void updateCategoryProducts(Category category) async {
    setState(() {
      page = 1;
    });
    final newProducts = await fetchProductsByCategory(category);
    productsMain.clear();
    print(productsMain.length);
    setState(() {
      productsMain.addAll(newProducts);
      print('dsaa');
      print(productsMain.length);
    });
  }

  void UpdateViews(Product product) async {
    final response = await http.put(
        Uri.parse(
            'http://45.32.19.162/shopping-api/products/update-view.php?product_id=${product.id}'),
        body: {
          'id': product.id.toString(),
        });
    if (response.statusCode == 200) {
      setState(() {
        // Tăng giá trị views của sản phẩm trong danh sách hiện tại
        print('Tang view thanh cong');
      });
    } else {
      throw Exception('Failed to update product views');
      // Handle errors
    }
  }
}
