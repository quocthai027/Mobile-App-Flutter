import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:AdsaxShop/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../loginPage.dart';
import 'doimatkhau.dart';
import 'giohang.dart';
import 'myoder.dart';
import 'trangchu.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    key,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  String name = '';

  final List<Widget> _pages = [
    ProductListScreen(),
    CartPage(),
    PaymentDetailsScreen(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
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
        title: RichText(
            maxLines: 1, 
            overflow:
                TextOverflow.ellipsis, // Thêm dấu "..." nếu văn bản dài hơn
            text: TextSpan(
              text: 'Xin chào: $name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                decorationStyle: TextDecorationStyle.dashed,
              ),
            )),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.black54, // text + icon color
            ),
            icon: Icon(Icons.logout, size: 20),
            label: Text('Logout', style: TextStyle(fontSize: 14)),
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.clear();
              // log('message${pref}');
              // Logout();
              print('ds');
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                'Đăng xuất thành công',
                style: TextStyle(fontWeight: FontWeight.bold),
              )));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text(
                'Thay đổi mật khẩu của bạn',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Đổi mật khẩu'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePasswordScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromARGB(255, 197, 127, 209),
        color: Colors.white,
        buttonBackgroundColor: Colors.orange,
        height: 50,
        animationDuration: Duration(milliseconds: 200),
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.grey,
          ),
          Icon(
            Icons.shopping_cart,
            size: 30,
            color: Colors.grey,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  void getUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? valname = pref.getString('hello');
    setState(() {
      name = valname ?? '';
    });
  }
}
