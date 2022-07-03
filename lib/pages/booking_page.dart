import 'dart:convert';

import 'package:balinese_tour_app/pages/home_page.dart';
import 'package:balinese_tour_app/pages/tiket_page.dart';
import 'package:http/http.dart' as http;
import 'package:balinese_tour_app/models/wisata_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingPage extends StatefulWidget {
  final Wisata wisata;

  const BookingPage({required this.wisata});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String? userToken;
  var _jumlahTiketController = TextEditingController();

  void getUserToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userToken = pref.getString('userToken');
  }

  @override
  void initState() {
    getUserToken();
    super.initState();
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
              const Text('Booking Ticket',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Card(
                  child: ListBody(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text(widget.wisata.name),
                          subtitle: Text(widget.wisata.location),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        child: ListTile(
                            title: Text('Metode Pembayaran'),
                            subtitle: Row(
                              children: [
                                Image.network(
                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/Logo_dana_blue.svg/1200px-Logo_dana_blue.svg.png',
                                    width: 55),
                                SizedBox(width: 10),
                                Image.network(
                                    'https://i.pinimg.com/originals/02/2e/98/022e9877180fdc3ef50f973e7620547d.png',
                                    width: 55),
                                SizedBox(width: 10),
                                Image.network(
                                    'https://upload.wikimedia.org/wikipedia/commons/9/9d/Logo_Indomaret.png',
                                    width: 55),
                                SizedBox(width: 10),
                                Image.network(
                                    'https://upload.wikimedia.org/wikipedia/commons/9/9e/ALFAMART_LOGO_BARU.png',
                                    width: 55),
                              ],
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        child: ListTile(
                          title: Text('Tiket'),
                          subtitle: TextFormField(
                            controller: _jumlahTiketController,
                            decoration: InputDecoration(
                                label: Text('Jumlah Tiket'),
                                suffixIcon: GestureDetector(
                                    onTap: () {},
                                    child: Icon(Icons.airplane_ticket))),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          bookingTicket();
                        },
                        child: Text('Order now'),
                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                                Size(double.maxFinite, 40)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepPurpleAccent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ))),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> bookingTicket() async {
    if (_jumlahTiketController.text.isNotEmpty) {
      final response = await http.post(
          Uri.parse('http://ilkom01.mhs.rey1024.com/api/bookingtiket'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $userToken',
          },
          body: ({
            'jumlah_tiket': _jumlahTiketController.text,
            'wisata_id': widget.wisata.id.toString()
          }));
      if (response.statusCode == 201) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal melakukan pesanan...')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Isi form...')));
    }
  }
}
