import 'dart:convert';
import 'package:balinese_tour_app/pages/detail_tiket_page.dart';
import 'package:http/http.dart' as http;
import 'package:balinese_tour_app/models/tiket_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TiketPage extends StatefulWidget {
  const TiketPage({Key? key}) : super(key: key);

  @override
  State<TiketPage> createState() => _TiketPageState();
}

class _TiketPageState extends State<TiketPage> {
  String? userId;
  String? userToken;
  late Future dataTiket;
  List<Tiket> tiket = [];

  getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('userId');
    userToken = pref.getString('userToken');
    setState(() {});
  }

  loadTiket() async {
    dataTiket = getTiketByUserId();
    dataTiket.then((value) {
      setState(() {
        tiket = value;
      });
    });
    setState(() {});
  }

  @override
  void initState() {
    getUser().then((_) {
      loadTiket();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (tiket.isEmpty) {
      return Text('Anda tidak memiliki tiket :)');
    } else {
      return SafeArea(
        child: Scaffold(
          body: ListView.builder(
              itemCount: tiket.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailTiketPage(tiket: tiket[index]);
                    }));
                  },
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.airplane_ticket),
                      title: Text(tiket[index].kodeTiket),
                    ),
                  ),
                );
              }),
        ),
      );
    }
  }

  Future getTiketByUserId() async {
    if (userToken != null) {
      final response = await http.get(
          Uri.parse('http://ilkom01.mhs.rey1024.com/api/tiket-ku/' + userId!),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $userToken',
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> data = jsonResponse["tiket"];

        return data.map<Tiket>((json) => Tiket.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data wisata");
      }
    } else {
      print('Gagal');
    }
  }
}
