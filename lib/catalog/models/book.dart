import 'dart:ffi';

// sekedar buat test

class Book {
    int isbn13;
    String title;
    String authors;
    String categories;
    String thumbnail;
    String description;
    int published_year;
    int page_count;
    int overall_rating; //sementara int dulu, gatau kenapa kalo pake Float dia tu parameternya error
    int favorites_count;

    Book(
        this.isbn13,
        this.title,
        this.authors,
        this.categories,
        this.thumbnail,
        this.description,
        this.published_year,
        this.page_count,
        this.overall_rating,
        this.favorites_count,
    );
}