// To parse this JSON data, do
//
//     final allSlots = allSlotsFromJson(jsonString);

import 'dart:convert';

List<AllSlots> allSlotsFromJson(String str) => List<AllSlots>.from(json.decode(str).map((x) => AllSlots.fromJson(x)));

String allSlotsToJson(List<AllSlots> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllSlots {
  int? id;
  String? starttime;
  String? endtime;
  DateTime? createdAt;
  DateTime? updatedAt;

  AllSlots({
    this.id,
    this.starttime,
    this.endtime,
    this.createdAt,
    this.updatedAt,
  });

  factory AllSlots.fromJson(Map<String, dynamic> json) => AllSlots(
    id: json["id"],
    starttime: json["starttime"],
    endtime: json["endtime"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "starttime": starttime,
    "endtime": endtime,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
