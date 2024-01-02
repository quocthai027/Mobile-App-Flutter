import 'package:flutter/material.dart';

class DateTimeWidget extends StatefulWidget {
  @override
  _DateTimeWidgetState createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  String _currentDateTime = '';
  late Stream<DateTime> _timeStream;
  late bool _isDisposed;
  @override
  void initState() {
    super.initState();
    // Gọi hàm cập nhật thời gian mỗi giây
    _isDisposed = false;
    _timeStream = Stream<DateTime>.periodic(
      Duration(seconds: 0),
      (x) => DateTime.now(),
    ).takeWhile((_) => !_isDisposed);
    updateDateTime();
  }

  void updateDateTime() {
    _timeStream.listen((dateTime) {
      if (!_isDisposed) {
        setState(() {
          _currentDateTime = '${dateTime.toLocal().toString().split('.')[0]}';
        });
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Text(
        _currentDateTime,
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
