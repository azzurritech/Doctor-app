import 'dart:convert';

List<BookingHistory> bookingHistoryFromJson(String str) => List<BookingHistory>.from(json.decode(str).map((x) => BookingHistory.fromJson(x)));

String bookingHistoryToJson(List<BookingHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingHistory {
  int? id;
  String? date;
  String? userId;
  String? name;
  String? email;
  String? subject;
  String? slotId;
  String? starttime;
  String? endtime;
  DateTime? createdAt;
  DateTime? updatedAt;

  BookingHistory({
    this.id,
    this.date,
    this.userId,
    this.name,
    this.email,
    this.subject,
    this.slotId,
    this.starttime,
    this.endtime,
    this.createdAt,
    this.updatedAt,
  });

  factory BookingHistory.fromJson(Map<String, dynamic> json) => BookingHistory(
    id: json["id"],
    date: json["date"],
    userId: json["user_id"],
    name: json["name"],
    email: json["email"],
    subject: json["subject"],
    slotId: json["slot_id"],
    starttime: json["starttime"],
    endtime: json["endtime"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "user_id": userId,
    "name": name,
    "email": email,
    "subject": subject,
    "slot_id": slotId,
    "starttime": starttime,
    "endtime": endtime,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}