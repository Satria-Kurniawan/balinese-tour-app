import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:balinese_tour_app/models/wisata_model.dart';

class WisataServices {
  final _baseUrl = 'http://ilkom01.mhs.rey1024.com/api';

  Future getWisata() async {
    final response = await http.get(Uri.parse(_baseUrl + '/wisata'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse["wisata"];

      return data.map<Wisata>((json) => Wisata.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load data wisata");
    }
  }
}
