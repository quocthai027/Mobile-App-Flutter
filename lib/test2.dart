import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThanhToan extends StatelessWidget {
 // final String payerId;
  const ThanhToan({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Successful'),
      ),
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
              'Payment Successful',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Transaction ID:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            InkWell(
                onTap: () {
                  // Điều hướng đến màn hình chính hoặc màn hình khác (tùy thuộc vào nhu cầu của bạn)
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: Text('Continue')),
          ],
        ),
      ),
    );
    ;
  }
}
