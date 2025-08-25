class GetAuthorsEntity {
  final int? id;
  final String? name;
  final String? imageBase64;
  final String? review;
  final List<CategoriesEntity>? categories;
  final List<BooksEntity>? books;

  GetAuthorsEntity({this.id, this.name, this.imageBase64, this.review, this.categories, this.books});
}

class CategoriesEntity {
  final int? id;
  final String? name;

  CategoriesEntity({this.id, this.name});
}

class BooksEntity {
  final int? id;
  final String? title;
  final String? imageBase64;
  final String? readDate;
  final String? review;

  BooksEntity({this.id, this.title, this.imageBase64, this.readDate, this.review});
}
