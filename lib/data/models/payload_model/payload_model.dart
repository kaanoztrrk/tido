import 'dart:convert';

class PayloadModel {
  PayloadModel({
    required this.title,
    required this.body,
    this.image,
    this.link,
    this.scheduledTime,
  });

  String title;
  String body;
  String? image;
  String? link;
  DateTime? scheduledTime; // Bildirim zamanı için

  factory PayloadModel.fromRawJson(String str) =>
      PayloadModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PayloadModel.fromJson(Map<String, dynamic> json) => PayloadModel(
        title: json["title"],
        body: json["body"],
        image: json["image"],
        link: json["link"],
        scheduledTime: json["scheduledTime"] != null
            ? DateTime.parse(json["scheduledTime"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "image": image,
        "link": link,
        "scheduledTime": scheduledTime?.toIso8601String(),
      };
}
