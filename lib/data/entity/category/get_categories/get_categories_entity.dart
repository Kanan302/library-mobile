class GetCategoryEntity {
  final int? id;
  final String? name;
  final List<AuthorEntity>? authors;
  final List<BookEntity>? books;

  GetCategoryEntity({this.id, this.name, this.authors, this.books});
}

class AuthorEntity {
  final int? id;
  final String? name;
  final String? imageBase64;
  final String? review;

  AuthorEntity({this.id, this.name, this.imageBase64, this.review});
}

class BookEntity {
  final int? id;
  final String? title;
  final String? imageBase64;
  final String? readDate;
  final String? review;

  BookEntity({this.id, this.title, this.imageBase64, this.readDate, this.review});
}
