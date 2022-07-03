import 'package:balinese_tour_app/models/wisata_model.dart';
import 'package:balinese_tour_app/pages/booking_page.dart';
import 'package:balinese_tour_app/pages/login_page.dart';
import 'package:balinese_tour_app/pages/maps_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var h1 = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
var h2 = TextStyle(fontSize: 16, color: Colors.blue);
var body = TextStyle(fontSize: 14);

class DetailPage extends StatefulWidget {
  final Wisata wisata;

  DetailPage({required this.wisata});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? userToken;

  void loggedCheck() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userToken = pref.getString('userToken');
    setState(() {});
  }

  @override
  void initState() {
    loggedCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 350,
                      height: 200,
                      child: Image.network(
                        'http://ilkom01.mhs.rey1024.com/laravel/storage/app/public/images/' +
                            widget.wisata.image,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new,
                        color: Colors.deepPurpleAccent),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                widget.wisata.name,
                style: h1,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CurentMap(wisata: widget.wisata);
                }));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Icon(Icons.location_pin, size: 30, color: Colors.blue),
                    Flexible(
                      child: Text(
                        widget.wisata.location,
                        style: h2,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                widget.wisata.description,
                style: body,
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return userToken != null ? BookingPage(wisata: widget.wisata) : LoginPage();
                    }));
                  },
                  child: Text("Buy Ticket"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: Size(100, 40)),
                ))
          ],
        ),
      ),
    );
  }
}
