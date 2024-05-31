// To parse this JSON data, do
//
//     final doctorsData = doctorsDataFromJson(jsonString);

import 'dart:convert';

List<DoctorsData> doctorsDataFromJson(String str) => List<DoctorsData>.from(json.decode(str).map((x) => DoctorsData.fromJson(x)));

String doctorsDataToJson(List<DoctorsData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorsData {
  int? id;
  String? name;
  String? speciality;
  String? address;
  String? experience;
  String? image;
  dynamic latitude;
  dynamic longitude;
  DateTime? createdAt;
  DateTime? updatedAt;

  DoctorsData({
    this.id,
    this.name,
    this.speciality,
    this.address,
    this.experience,
    this.image,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  factory DoctorsData.fromJson(Map<String, dynamic> json) => DoctorsData(
    id: json["id"],
    name: json["name"],
    speciality: json["speciality"],
    address: json["address"],
    experience: json["experience"],
    image: json["image"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "speciality": speciality,
    "address": address,
    "experience": experience,
    "image": image,
    "latitude": latitude,
    "longitude": longitude,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
