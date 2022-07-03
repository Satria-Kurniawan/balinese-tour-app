import 'package:balinese_tour_app/pages/home_page.dart';
import 'package:balinese_tour_app/pages/login_page.dart';
import 'package:balinese_tour_app/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userName;
  String? userEmail;
  String? userToken;

  void getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('userName');
    userEmail = pref.getString('userEmail');
    userToken = pref.getString('userToken');
    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userToken != null) {
      return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 207,
                        width: double.maxFinite,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.account_circle,
                                size: 100, color: Colors.white),
                            Text(userName != null ? userName! : '', 
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 25.0),
                child: Container(
                  height: 30,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black))),
                  child: Text(userName != null ? userName! : ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 25.0),
                child: Container(
                  height: 30,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black))),
                  child: Text(userEmail != null ? userEmail! : ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    logout();
                  },
                  child: Text('Logout'),
                  style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all(Size(double.maxFinite, 40)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return ProfileUnlogged();
    }
  }

  Future<void> logout() async {
    if (userToken != null) {
      final response = await http.post(
          Uri.parse('http://ilkom01.mhs.rey1024.com/api/logout'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $userToken',
          });
      if (response.statusCode == 200) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.clear();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      } else {
        print('Gagal logout');
      }
    }
  }
}

class ProfileUnlogged extends StatelessWidget {
  const ProfileUnlogged({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              child: Text('Sign In'),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RegisterPage();
                }));
              },
              child: Text('Sign Up'),
              style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all(Size(double.maxFinite, 40)),
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ))),
            ),
          ),
        ],
      ),
    );
  }
}
