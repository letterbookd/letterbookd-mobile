// To parse this JSON data, do
//
//     final library = libraryFromJson(jsonString);

import 'dart:convert';

List<Library> libraryFromJson(String str) => List<Library>.from(json.decode(str).map((x) => Library.fromJson(x)));

String libraryToJson(List<Library> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Library {
    String model;
    int pk;
    Fields fields;

    Library({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Library.fromJson(Map<String, dynamic> json) => Library(
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
    Fields();

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    );

    Map<String, dynamic> toJson() => {
    };
}