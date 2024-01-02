// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:flutter_application_20/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget( MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }

// Future<void> fetchData() async {
//     final String url = 'http://45.32.19.162/app_tto/get_setting.php';
//     final Map<String, String> data = {
//       'secret_key': '0A83425hWdn#@^I6ccrgo19Y',
//     };

//     final response = await http.post(
//       Uri.parse(url),
//       body: data,
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> jsonResponse = json.decode(response.body);

//       // Chuyển đổi JSON thành một đối tượng AppSettings
//       appSettings = AppSettings.fromJson(jsonResponse);

//       // In ra từng giá trị
//       print('App Version: ${appSettings.appVersion}');
//       print('Show Function iOS: ${appSettings.showFunctionIOS}');
//       print('ID News Open Webview: ${appSettings.idnewsOpenWebview}');
//       print('Open News In Webview: ${appSettings.openNewsInWebview}');
//       print('Is Logo New Year: ${appSettings.isLogoNewYear}');
//       print('Is Open AdMob In App: ${appSettings.isOpenAdmobInApp}');
//       print('Show Daily Newspaper: ${appSettings.showDailyNewspaper}');
//       runApp(MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: (appSettings.appVersion == '490') ? Splash() : MyWidget(),
//       ));
//     }
//   }
// FutureBuilder<List<dynamic>>(
//         future: Future.wait([fetchData(), fetchIPInfo()]),
//         initialData: [],
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             final appSettings = snapshot.data?[0] as AppSettings;
//             final ipInfo = snapshot.data?[1] as IPInfo;
//             print(ipInfo.country);
//             print(appSettings.appVersion);
//             print('gia tri status  ${snapshot.data?[0]}');
//             if (snapshot.data?[0] == 200) {
//               if (ipInfo.country != 'VN') {
//                 return Splash();
//               } else {
//                 return MyWidget();
//               }
//             } else {
//               return Splash();
//             }
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Lỗi: ${snapshot.error}'),
//             );
//           }
//           return Container();
//         },
//       ),
//     );