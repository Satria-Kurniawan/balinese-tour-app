import 'package:balinese_tour_app/models/wisata_model.dart';
import 'package:balinese_tour_app/pages/detail_page.dart';
import 'package:balinese_tour_app/services/wisata_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late Future dataWisata;
  List<Wisata> wisata = [];

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
    loadWisata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (wisata.length == 0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 25,
                          offset: Offset(0, 3))
                    ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Search...",
                          suffixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 265,
                    child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: wisata.length,
                        itemBuilder: (context, index) {
                          if (wisata[index].kategori.name == 'Gunung') {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(_createRoute(wisata[index]));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  width: 280,
                                  child: Card(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.hiking),
                                          title: Text(wisata[index].name),
                                          subtitle:
                                              Text(wisata[index].kategori.name),
                                        ),
                                        Container(
                                          height: 180,
                                          width: double.maxFinite,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    bottom:
                                                        Radius.circular(20)),
                                            child: Image.network(
                                              'http://ilkom01.mhs.rey1024.com/laravel/storage/app/public/images/' +
                                                  wisata[index].image,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 265,
                    child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: wisata.length,
                        itemBuilder: (context, index) {
                          if (wisata[index].kategori.name == 'Danau') {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(_createRoute(wisata[index]));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  width: 280,
                                  child: Card(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.water_sharp),
                                          title: Text(wisata[index].name),
                                          subtitle:
                                              Text(wisata[index].kategori.name),
                                        ),
                                        Container(
                                          height: 180,
                                          width: double.maxFinite,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    bottom:
                                                        Radius.circular(20)),
                                            child: Image.network(
                                              'http://ilkom01.mhs.rey1024.com/laravel/storage/app/public/images/' +
                                                  wisata[index].image,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 265,
                    child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: wisata.length,
                        itemBuilder: (context, index) {
                          if (wisata[index].kategori.name == 'Perkebunan') {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(_createRoute(wisata[index]));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  width: 280,
                                  child: Card(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.park),
                                          title: Text(wisata[index].name),
                                          subtitle:
                                              Text(wisata[index].kategori.name),
                                        ),
                                        Container(
                                          height: 180,
                                          width: double.maxFinite,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    bottom:
                                                        Radius.circular(20)),
                                            child: Image.network(
                                              'http://ilkom01.mhs.rey1024.com/laravel/storage/app/public/images/' +
                                                  wisata[index].image,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 265,
                    child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: wisata.length,
                        itemBuilder: (context, index) {
                          if (wisata[index].kategori.name == 'Pantai') {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(_createRoute(wisata[index]));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  width: 280,
                                  child: Card(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.beach_access),
                                          title: Text(wisata[index].name),
                                          subtitle:
                                              Text(wisata[index].kategori.name),
                                        ),
                                        Container(
                                          height: 180,
                                          width: double.maxFinite,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    bottom:
                                                        Radius.circular(20)),
                                            child: Image.network(
                                              'http://ilkom01.mhs.rey1024.com/laravel/storage/app/public/images/' +
                                                  wisata[index].image,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

Route _createRoute(data) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        DetailPage(wisata: data),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.decelerate;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
