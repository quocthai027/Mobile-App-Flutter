import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // CalendarController _calendarController = CalendarController();
  DateTime today = DateTime.now();
  void _onSelect(DateTime day, DateTime focusday) {
    setState(() {
      today = day;
    });
  }

  String formatMonth(DateTime date) {
    final dateFormat = DateFormat.yMMM(
        'vi_VN'); // Sử dụng 'vi_VN' để định dạng ngày tháng theo tiếng Việt
    return dateFormat.format(date);
  }

  String formatDay(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Xem Lịch'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Ngày bạn đang xem: ' +
                    formatDay(
                        today), // Sử dụng formatDay để định dạng ngày tháng năm
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Arial',
                ),
              ),
            ),
            Stack(children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/nenlich.jpg', // Thay 'assets/background_image.png' bằng đường dẫn tới ảnh của bạn
                  fit: BoxFit.cover,
                ),
              ),
              TableCalendar(
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),
                focusedDay: today,
                firstDay: DateTime.utc(2015, 12, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                onDaySelected: _onSelect,
              ),
            ])
            // Tùy chỉnh giao diện và hiển thị danh sách sự kiện ở đây
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webview không hoạt động'),
      ),
      body: WebView(
        initialUrl: 'http://i9betapp.online/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
