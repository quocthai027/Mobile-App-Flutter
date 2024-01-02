import 'package:flutter/material.dart';
import 'package:AdsaxShop/tama.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:lottie/lottie.dart';

import 'homepage/homepage.dart';
import 'loginPage.dart';

import 'model/modelcheck.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bJ Chính Thức',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<int>(
        future: fetchData(),
        initialData: 0,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final statusCode = snapshot.data;

            print('Status Code: $statusCode');

            if (statusCode == 200) {
              // Nếu status code là 200, tiếp tục xử lý
              return FutureBuilder<IPInfo>(
                future: fetchIPInfo(),
                builder: (context, ipSnapshot) {
                  if (ipSnapshot.connectionState == ConnectionState.done) {
                    final ipInfo = ipSnapshot.data!;
                    print('Country: ${ipInfo.country}');

                    if (ipInfo.country != 'VN') {
                      return Splash();
                    } else {
                      return MyWidget();
                    }
                  }
                return SizedBox.shrink();
                },
              );
            } else {
              return Splash();
            }
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Future<IPInfo> fetchIPInfo() async {
    final response = await http.get(Uri.parse('https://ipinfo.io/json'));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      print('oke');
      return IPInfo.fromJson(jsonMap);
    } else {
      throw Exception('Không thể lấy thông tin IP.');
    }
  }

  // Future<AppSettings> fetchData() async {
  //   final String url = 'http://45.32.19.162/app_tto/get_setting.php';
  //   final Map<String, String> data = {
  //     'secret_key': '0A83425hWdn#@^I6ccrgo19Y',
  //   };

  //   final response = await http.post(
  //     Uri.parse(url),
  //     body: data,
  //   );

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> jsonResponse = json.decode(response.body);
  //     final appSettings = AppSettings.fromJson(jsonResponse);
  //     return appSettings;
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }
  Future<int> fetchData() async {
    final String url = 'http://45.32.19.162/app_tto/get_setting.php';
    final Map<String, String> data = {
      'secret_key': '0A83425hWdn#@^I6ccrgo19Y',
    };

    final response = await http.post(
      Uri.parse(url),
      body: data,
    );
 return response.statusCode;
 
  }
}
   // if (response.statusCode == 200) {
    //   print('Status Code thanh cong : ${response.statusCode}');
    //   final Map<String, dynamic> jsonResponse = json.decode(response.body);
    //   final appSettings = AppSettings.fromJson(jsonResponse);

    //   return appSettings;
    // } else {
    //   // Handle the status code here
    //   print('Status Code: ${response.statusCode}');
    //   // You can throw an exception or return a specific object based on the status code
    //   // For example, if status code is 400, you may want to return a special AppSettings object
    //   throw Exception(
    //       'Failed to load data. Status Code: ${response.statusCode}');
    // }
class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  initState() {
    // TODO: implement initState
    super.initState();

    Flashcheck();
  }

  Flashcheck() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = await pref.getString('login');
    String? valname = await pref.getString('hello');
    Future.delayed(const Duration(seconds: 3), () {
      if (val == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        // BlocProvider<DetailNativeBloc>(
//         create: (context) => DetailNativeBloc()..add(GetproductEvent()),
//         child: Builder(
//           builder: (context) {
//             return const Splash();
//           }
//         ),
//       ),
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Chào mừng bạn đã trở lại')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: LottieBuilder.network(
                    'https://assets2.lottiefiles.com/packages/lf20_a2chheio.json'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
