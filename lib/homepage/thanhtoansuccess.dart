import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:AdsaxShop/homepage/homepage.dart';
import 'package:AdsaxShop/homepage/trangchu.dart';

import 'giohang.dart';

class ThanhToanSuccess extends StatelessWidget {
  const ThanhToanSuccess({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 64.0,
              color: Colors.green,
            ),
            SizedBox(height: 16.0),
            Text(
              'Thanh toán thành công',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            // Text(
            //   'Transaction ID:$payerId',
            //   style: TextStyle(fontSize: 16.0),
            // ),
            SizedBox(height: 16.0),
            // InkWell(
            //     onTap: () {
            //       // Điều hướng đến màn hình chính hoặc màn hình khác (tùy thuộc vào nhu cầu của bạn)
            //      // Navigator.popUntil(context, ModalRoute.withName('/'));

            //     },
            //     child: Text('Continue')),
            InkWell(
              onTap: () {
                // Điều hướng đến trang giỏ hàng và cập nhật lại số lượng sản phẩm
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (route) => false,
                );
              },
              child: Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16, // Kích thước font chữ
                  fontWeight: FontWeight.bold, // Độ đậm của font chữ
                  color: Colors.blue, // Màu sắc của font chữ
                  // Các thuộc tính khác của TextStyle
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
