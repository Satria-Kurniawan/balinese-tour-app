import 'package:balinese_tour_app/models/wisata_model.dart';
import 'package:balinese_tour_app/pages/detail_page.dart';
import 'package:balinese_tour_app/services/wisata_services.dart';
import 'package:flutter/material.dart';

var h2 = TextStyle(fontSize: 16);

class KategoriPantai extends StatefulWidget {
  @override
  State<KategoriPantai> createState() => _KategoriPantaiState();
}

class _KategoriPantaiState extends State<KategoriPantai> {
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
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            itemCount: wisata.length,
            itemBuilder: (context, index) {
              if (wisata[index].kategori.name == 'Pantai') {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
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
                  ),
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}

class KategoriDanau extends StatefulWidget {
  @override
  State<KategoriDanau> createState() => _KategoriDanauState();
}

class _KategoriDanauState extends State<KategoriDanau> {
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
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            itemCount: wisata.length,
            itemBuilder: (context, index) {
              if (wisata[index].kategori.name == 'Danau') {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
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
                  ),
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}

class KategoriPerkebunan extends StatefulWidget {
  @override
  State<KategoriPerkebunan> createState() => _KategoriPerkebunanState();
}

class _KategoriPerkebunanState extends State<KategoriPerkebunan> {
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
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            itemCount: wisata.length,
            itemBuilder: (context, index) {
              if (wisata[index].kategori.name == 'Perkebunan') {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
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
                  ),
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}

class KategoriGunung extends StatefulWidget {
  @override
  State<KategoriGunung> createState() => _KategoriGunungState();
}

class _KategoriGunungState extends State<KategoriGunung> {
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
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            itemCount: wisata.length,
            itemBuilder: (context, index) {
              if (wisata[index].kategori.name == 'Gunung') {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
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
                  ),
                );
              } else {
                return Container();
              }
            }),
      ),
    );
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
