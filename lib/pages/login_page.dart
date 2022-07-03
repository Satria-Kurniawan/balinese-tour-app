import 'dart:convert';
import 'package:balinese_tour_app/pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:balinese_tour_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  void togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_circle, size: 100, color: Colors.deepPurpleAccent),
          SizedBox(height: 30),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              label: Text('Email'),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  borderRadius: BorderRadius.circular(20.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(20.0)),
              suffixIcon: Icon(Icons.email),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscureText,
            decoration: InputDecoration(
                label: Text('Password'),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                    borderRadius: BorderRadius.circular(20.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20.0)),
                suffixIcon: GestureDetector(
                    onTap: () {
                      togglePassword();
                    },
                    child: Icon(Icons.remove_red_eye))),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              login();
            },
            child: Text('Login'),
            style: ButtonStyle(
                fixedSize:
                    MaterialStateProperty.all(Size(double.maxFinite, 40)),
                backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ))),
          ),
          SizedBox(height: 20),
          GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return RegisterPage();
                }));
              },
              child: Text('Belum punya akun?'))
        ],
      ),
    )));
  }

  Future<void> login() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      final response = await http.post(
          Uri.parse('http://ilkom01.mhs.rey1024.com/api/login'),
          body: ({
            'email': _emailController.text,
            'password': _passwordController.text
          }));
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        final userId = data['user']['id'].toString();
        final userName = data['user']['name'];
        final userEmail = data['user']['email'];
        final userToken = data['token'];
        final SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('userId', userId);
        pref.setString('userName', userName);
        pref.setString('userEmail', userEmail);
        pref.setString('userToken', userToken);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid credential')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Isi form...')));
    }
  }
}
