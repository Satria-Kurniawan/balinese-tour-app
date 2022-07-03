import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:balinese_tour_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _passwordConfimationController = TextEditingController();

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
          Flexible(
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                label: Text('Name'),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                    borderRadius: BorderRadius.circular(20.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20.0)),
                suffixIcon: Icon(Icons.people)
              ),
            ),
          ),
          SizedBox(height: 20),
          Flexible(
            child: TextFormField(
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
          ),
          SizedBox(height: 20),
          Flexible(
            child: TextFormField(
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
          ),
          SizedBox(height: 20),
          Flexible(
            child: TextFormField(
              controller: _passwordConfimationController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                  label: Text('Password Confirmation'),
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
          ),
          SizedBox(height: 20),
          Flexible(
            child: ElevatedButton(
              onPressed: () {
                register();
              },
              child: Text('Register'),
              style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all(Size(double.maxFinite, 40)),
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ))),
            ),
          ),
        ],
      ),
    )));
  }

  Future<void> register() async {
    if (_nameController.text.isNotEmpty && _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty && _passwordConfimationController.text.isNotEmpty) {
      final response = await http.post(
          Uri.parse('http://ilkom01.mhs.rey1024.com/api/register'),
          body: ({
            'name': _nameController.text,
            'email': _emailController.text,
            'password': _passwordController.text,
            'password_confirmation': _passwordConfimationController.text
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
