class Preferences {
  final bool shareReviews;
  final bool shareLibrary;

  Preferences({
    required this.shareReviews,
    required this.shareLibrary,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      shareReviews: json["share_reviews"] ?? false,
      shareLibrary: json["share_library"] ?? false,
    );
  }
}