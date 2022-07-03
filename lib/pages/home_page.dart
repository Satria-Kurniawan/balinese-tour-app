import 'package:balinese_tour_app/models/wisata_model.dart';
import 'package:balinese_tour_app/pages/category_page.dart';
import 'package:balinese_tour_app/pages/detail_page.dart';
import 'package:balinese_tour_app/pages/explore_page.dart';
import 'package:balinese_tour_app/pages/login_page.dart';
import 'package:balinese_tour_app/pages/profile_page.dart';
import 'package:balinese_tour_app/pages/tiket_page.dart';
import 'package:balinese_tour_app/services/wisata_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var h1 = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
var h2 = TextStyle(fontSize: 18, color: Colors.white);
var h3 = TextStyle(fontSize: 15);

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final screens = [Home(), ExplorePage(), TiketPage(), ProfilePage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurpleAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.airplane_ticket), label: "Ticket"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Profile')
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    if (wisata.length == 0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return SafeArea(
        child: Container(
          color: Color.fromARGB(255, 223, 223, 223),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Stack(
                children: [
                  Container(
                    height: 240,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 207,
                        width: double.maxFinite,
                        color: Colors.deepPurpleAccent,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              userName != null
                                  ? Text('Hi ' + userName! + ',', style: h1)
                                  : ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return LoginPage();
                                        }));
                                      },
                                      icon: Icon(Icons.login),
                                      label: Text('Login'),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.black))),
                              Text("Selamat datang di", style: h2),
                              Text("aplikasi tempat", style: h2),
                              Text("wisata Bali", style: h2)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 40,
                    child: Container(
                      width: 280,
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
                  )
                ],
              ),
              // End Header Section

              // Category Section
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                child: Text("Category", style: h3),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return KategoriPantai();
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 70,
                            width: 70,
                            color: Colors.deepPurpleAccent,
                            child: Icon(Icons.beach_access,
                                color: Colors.white, size: 40),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return KategoriDanau();
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 70,
                            width: 70,
                            color: Colors.deepPurpleAccent,
                            child: Icon(Icons.water_sharp,
                                color: Colors.white, size: 40),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return KategoriPerkebunan();
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 70,
                            width: 70,
                            color: Colors.deepPurpleAccent,
                            child:
                                Icon(Icons.park, color: Colors.white, size: 40),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return KategoriGunung();
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 70,
                            width: 70,
                            color: Colors.deepPurpleAccent,
                            child: Icon(Icons.hiking,
                                color: Colors.white, size: 40),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // End Category Section

              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                child: Text("Wisata Trending", style: h3),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: wisata.length,
                      itemBuilder: (context, index) {
                        if (wisata[index].kategori.trending == "1") {
                          return Column(
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 10.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(_createRoute(wisata[index]));
                                    },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          width: 200,
                                          height: 150,
                                          child: Image.network(
                                            'http://ilkom01.mhs.rey1024.com/laravel/storage/app/public/images/' +
                                                wisata[index].image,
                                            fit: BoxFit.fill,
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(wisata[index].name, style: h3),
                              ),
                            ],
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
