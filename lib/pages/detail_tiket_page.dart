import 'package:balinese_tour_app/models/tiket_model.dart';
import 'package:balinese_tour_app/models/wisata_model.dart';
import 'package:balinese_tour_app/services/wisata_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailTiketPage extends StatefulWidget {
  final Tiket tiket;
  const DetailTiketPage({required this.tiket});

  @override
  State<DetailTiketPage> createState() => _DetailTiketPageState();
}

class _DetailTiketPageState extends State<DetailTiketPage> {
  String? userName;
  late Future dataWisata;
  List<Wisata> wisata = [];

  void getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('userName');
    setState(() {});
  }

  loadWisata() async {
    dataWisata = WisataServices().getWisata();
    dataWisata.then((value) {
      setState(() {
        wisata = value;
      });
    });
    setState(() {});
  }

  @override
  void initState() {
    getUser();
    loadWisata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (wisata.isNotEmpty) {
      return SafeArea(
        child: Scaffold(
          body: ListView.builder(
              itemCount: wisata.length,
              itemBuilder: (context, index) {
                if (wisata[index].id.toString() ==
                    widget.tiket.pesanan.wisataId) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
                        Text('Ticket',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Card(
                                child: ListTile(
                              leading: Icon(Icons.download),
                              title: Text(widget.tiket.kodeTiket),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Tiket untuk ' +
                                      widget.tiket.pesanan.jumlahTiket +
                                      ' orang'),
                                  Text(userName != null ? 'Atas nama ' + userName! : ''),
                                  Text('Wisata ' + wisata[index].name),
                                  SizedBox(height: 10),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      bottom:
                                          Radius.circular(20)),
                                    child: Container(
                                      height: 140,
                                      width: double.maxFinite,
                                      child: Image.network(
                                        'http://ilkom01.mhs.rey1024.com/laravel/storage/app/public/images/' +
                                            wisata[index].image,
                                            fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              }),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
