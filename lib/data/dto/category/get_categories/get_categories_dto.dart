class GetCategoryDto {
  final int? id;
  final String? name;
  final List<AuthorDto>? authors;
  final List<BookDto>? books;

  GetCategoryDto({this.id, this.name, this.authors, this.books});

  factory GetCategoryDto.fromJson(Map<String, dynamic> json) => GetCategoryDto(
    id: json['id'],
    name: json['name'],
    authors: (json['authors'] as List<dynamic>?)?.map((e) => AuthorDto.fromJson(e)).toList() ?? [],
    books: (json['books'] as List<dynamic>?)?.map((e) => BookDto.fromJson(e)).toList() ?? [],
  );
}

class AuthorDto {
  final int? id;
  final String? name;
  final String? imageBase64;
  final String? review;

  AuthorDto({this.id, this.name, this.imageBase64, this.review});

  factory AuthorDto.fromJson(Map<String, dynamic> json) =>
      AuthorDto(id: json['id'], name: json['name'], imageBase64: json['imageBase64'], review: json['review']);
}

class BookDto {
  final int? id;
  final String? title;
  final String? imageBase64;
  final String? readDate;
  final String? review;

  BookDto({this.id, this.title, this.imageBase64, this.readDate, this.review});

  factory BookDto.fromJson(Map<String, dynamic> json) => BookDto(
    id: json['id'],
    title: json['title'],
    imageBase64: json['imageBase64'],
    readDate: 'readDate',
    review: json['review'],
  );
}
