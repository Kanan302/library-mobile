class GetAuthorsDto {
  final int? id;
  final String? name;
  final String? imageBase64;
  final String? review;
  final List<CategoriesDto>? categories;
  final List<BooksDto>? books;

  GetAuthorsDto({this.id, this.name, this.imageBase64, this.review, this.categories, this.books});

  factory GetAuthorsDto.fromJson(Map<String, dynamic> json) => GetAuthorsDto(
    id: json['id'],
    name: json['name'],
    imageBase64: json['imageBase64'],
    review: json['review'],
    categories: (json['categories'] as List<dynamic>?)?.map((e) => CategoriesDto.fromJson(e)).toList() ?? [],
    books: (json['books'] as List<dynamic>?)?.map((e) => BooksDto.fromJson(e)).toList() ?? [],
  );
}

class CategoriesDto {
  final int? id;
  final String? name;

  CategoriesDto({this.id, this.name});

  factory CategoriesDto.fromJson(Map<String, dynamic> json) => CategoriesDto(id: json['id'], name: json['name']);
}

class BooksDto {
  final int? id;
  final String? title;
  final String? imageBase64;
  final String? readDate;
  final String? review;

  BooksDto({this.id, this.title, this.imageBase64, this.readDate, this.review});

  factory BooksDto.fromJson(Map<String, dynamic> json) => BooksDto(
    id: json['id'],
    title: json['title'],
    imageBase64: json['imageBase64'],
    readDate: json['readDate'],
    review: json['review'],
  );
}
