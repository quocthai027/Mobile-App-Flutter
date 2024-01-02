import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:AdsaxShop/test2.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dangky.dart';

import 'homepage/homepage.dart';
import 'model/user.dart';

// void main() => runApp(MaterialApp(home: LoginPage()));

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginPage(),
//     );
//   }
// }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
    checkedLogin();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LottieBuilder.network(
            'https://assets9.lottiefiles.com/packages/lf20_jcikwtux.json',
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 10,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
            child: FadeTransition(
              opacity: _animation,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Đăng nhập Ngay',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email không được bỏ trống';
                        }
                        // bool emailValid =
                        //     RegExp(r'^.+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$')
                        //         .hasMatch(value);

                        // if (emailValid) {
                        //   return null;
                        // } else {
                        //   return 'Email không đúng định dạng';
                        // }
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.purple,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Email",
                        hintText: 'username@gmail.com',
                        labelStyle: TextStyle(color: Colors.purple),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Mật khẩu không được bỏ trống";
                        }
                      },
                      obscuringCharacter: '*',
                      obscureText:
                          !showPassword, // Set obscureText based on showPassword flag
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.purple,
                        ),
                        suffixIcon: IconButton(
                          // Add suffix icon button to toggle show/hide password
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: Icon(
                            // Show eye icon if password is obscured, otherwise show eye slash icon
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Password",
                        hintText: '*********',
                        labelStyle: TextStyle(color: Colors.purple),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    InkWell(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          // print('object' ${widget.wppost.email});
                          // print(
                          //     'object ${widget.wppost.access_token.toString()}');
                          // print(
                          //     'object ${widget.wppost.email ?? 'rong'} ');

                          // check if form data are valid,
                          // your process task ahed if all data are valid
                          Login();
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple,
                              Colors.orange,
                            ],
                          ),
                        ),
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Nếu chưa có tài khoản? ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DangKy(),
                                  ),
                                );
                              },
                              child: Text(
                                'Đăng ký ngay',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> Login() async {
    final dio = Dio();

    try {
      final response = await dio.post(
        "http://45.32.19.162/shopping-api/user/login.php",
        queryParameters: {
          'username': usernameController.text,
          'password': passwordController.text
        },
        options: Options(
          followRedirects: false,
        ),
      );

      if (response.statusCode == 200) {
        print('do login 200');

        final parsedJson = jsonDecode(response.data);
        final jwt = parsedJson['jwt'];
        final status = parsedJson['user_status'];
        if (status == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tài khoản của bạn đã bị khóa')));
        } else {
          Token(jwt);
          NameUser(usernameController.text);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Đăng nhập thành công')));
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ),
            (route) => false,
          );
        }

        // Xử lý thành công và tiếp tục với các bước tiếp theo
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          // Xử lý trường hợp yêu cầu trả về mã trạng thái không hợp lệ (400)
          final responseBody = e.response?.data;
          print('Lỗi 400: ' + responseBody);
          final parsedJson = jsonDecode(responseBody);
          final error = parsedJson['error'];

          // Sử dụng giá trị error và message tại đây

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$error')),
          );
          // Hiển thị thông báo lỗi hoặc xử lý dữ liệu phản hồi khác tại đây
        }
      }
    }
  }

  Future<void> Token(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('login', token);
  }

  Future<void> NameUser(String name) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('hello', name);
  }

  void checkedLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? valname = await pref.getString('hello');
    String? valtoken = await pref.getString('login');

    if (valname != null && valtoken != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MyHomePage()),
          (route) => false);
      print(valtoken);
      print(valname);
    }
  }
}
