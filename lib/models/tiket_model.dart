// To parse this JSON data, do
//
//     final Tiket = TiketFromJson(jsonString);

import 'dart:convert';

Tiket tiketFromJson(String str) => Tiket.fromJson(json.decode(str));

String tiketToJson(Tiket data) => json.encode(data.toJson());

class Tiket {
    Tiket({
      required this.id,
      required this.kodeTiket,
      required this.pesananId,
      required this.createdAt,
      required this.updatedAt,
      required this.pesanan,
    });

    int id;
    String kodeTiket;
    String pesananId;
    DateTime createdAt;
    DateTime updatedAt;
    Pesanan pesanan;

    factory Tiket.fromJson(Map<String, dynamic> json) => Tiket(
        id: json["id"],
        kodeTiket: json["kode_tiket"],
        pesananId: json["pesanan_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pesanan: Pesanan.fromJson(json["pesanan"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "kode_tiket": kodeTiket,
        "pesanan_id": pesananId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pesanan": pesanan.toJson(),
    };
}

class Pesanan {
    Pesanan({
       required this.id,
       required this.jumlahTiket,
       required this.userId,
       required this.wisataId,
       required this.createdAt,
       required this.updatedAt,
    });

    int id;
    String jumlahTiket;
    String userId;
    String wisataId;
    DateTime createdAt;
    DateTime updatedAt;

    factory Pesanan.fromJson(Map<String, dynamic> json) => Pesanan(
        id: json["id"],
        jumlahTiket: json["jumlah_tiket"],
        userId: json["user_id"],
        wisataId: json["wisata_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "jumlah_tiket": jumlahTiket,
        "user_id": userId,
        "wisata_id": wisataId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
