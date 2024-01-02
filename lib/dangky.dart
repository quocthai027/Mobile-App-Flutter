import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:AdsaxShop/main.dart';
import 'package:AdsaxShop/test2.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

import 'loginPage.dart';
import 'model/user.dart';

class DangKy extends StatefulWidget {
  @override
  _DangKyState createState() => _DangKyState();
}

class _DangKyState extends State<DangKy> with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _animation;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController tenController = TextEditingController();
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FadeTransition(
          opacity: _animation,
          child: Stack(children: [
            LottieBuilder.network(
              'https://assets9.lottiefiles.com/packages/lf20_jcikwtux.json',
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 10,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 170, 20, 20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Đăng ký',
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
                      controller: tenController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tên không được bỏ trống';
                        }
                        if (value.contains(RegExp(r'\d'))) {
                          return 'Tên không được chứa chữ số';
                        }
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
                        labelText: "Tên",
                        hintText: 'Nguyễn Văn A',
                        labelStyle: TextStyle(color: Colors.purple),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email không được bỏ trống';
                        }
                        bool emailValid =
                            RegExp(r'^.+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$')
                                .hasMatch(value);

                        if (emailValid) {
                          return null;
                        } else {
                          return 'Email không đúng định dạng';
                        }
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

                        if (value.length < 5) {
                          return 'Mật khẩu không được nhỏ hơn 5 kí tự';
                        } else {
                          return null;
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
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          // print('object' ${widget.wppost.email});
                          // print(
                          //     'object ${widget.wppost.access_token.toString()}');
                          // print(
                          //     'object ${widget.wppost.email ?? 'rong'} ');

                          // check if form data are valid,
                          // your process task ahed if all data are valid
                          Register();
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
                          'Đăng Ký',
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
                              'Đã có tài khoản? ',
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
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Đăng nhập tại đây',
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
          ]),
        ),
      ),
    );
  }

  Future<void> Register() async {
    final dio = Dio();

    final response = await http.post(
      Uri.parse('http://45.32.19.162/shopping-api/user/register.php'),
      body: {
        'name': tenController.text,
        'username': usernameController.text,
        'password': passwordController.text
      },
    );
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final success = responseData['success'];

      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$success')));
    } else {
      final error = responseData['error'];

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Đăng ký thất bại: ${error}')));
    }
  }
}
