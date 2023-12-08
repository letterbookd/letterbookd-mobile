// To parse this JSON data, do
//
//     final reader = readerFromJson(jsonString);

import 'dart:convert';

List<Reader> readerFromJson(String str) =>
    List<Reader>.from(json.decode(str).map((x) => Reader.fromJson(x)));

String readerToJson(List<Reader> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reader {
  String model;
  int pk;
  Fields fields;

  Reader({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Reader.fromJson(Map<String, dynamic> json) => Reader(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  String displayName;
  String bio;
  int profilePicture;
  int personalLibrary;
  int preferences;

  Fields({
    required this.user,
    required this.displayName,
    required this.bio,
    required this.profilePicture,
    required this.personalLibrary,
    required this.preferences,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        displayName: json["display_name"],
        bio: json["bio"],
        profilePicture: json["profile_picture"],
        personalLibrary: json["personal_library"],
        preferences: json["preferences"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "display_name": displayName,
        "bio": bio,
        "profile_picture": profilePicture,
        "personal_library": personalLibrary,
        "preferences": preferences,
      };
}
