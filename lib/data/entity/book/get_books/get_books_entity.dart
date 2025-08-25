class GetBookEntity {
  final int? id;
  final String? title;
  final String? imageBase64;
  final String? readDate;
  final String? review;
  final AuthorEntity? author;
  final CategoryEntity? category;
  final List<UsersEntity>? users;

  GetBookEntity({
    this.id,
    this.title,
    this.imageBase64,
    this.readDate,
    this.review,
    this.author,
    this.category,
    this.users,
  });
}

class AuthorEntity {
  final int? id;
  final String? name;
  final String? imageBase64;
  final String? review;

  AuthorEntity({this.id, this.name, this.imageBase64, this.review});
}

class CategoryEntity {
  final int? id;
  final String? name;

  CategoryEntity({this.id, this.name});
}

class UsersEntity {
  final int? id;
  final String? email;

  UsersEntity({this.id, this.email});
}
