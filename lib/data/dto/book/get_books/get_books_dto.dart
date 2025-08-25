class GetBookDto {
  final int? id;
  final String? title;
  final String? imageBase64;
  final String? readDate;
  final String? review;
  final AuthorDto? author;
  final CategoryDto? category;
  final List<UsersDto>? users;

  GetBookDto({
    this.id,
    this.title,
    this.imageBase64,
    this.readDate,
    this.review,
    this.author,
    this.category,
    this.users,
  });

  factory GetBookDto.fromJson(Map<String, dynamic> json) => GetBookDto(
    id: json['id'],
    title: json['title'],
    imageBase64: json['imageBase64'],
    readDate: json['readDate'],
    review: json['review'],
    author: json['author'] != null ? AuthorDto.fromJson(json['author']) : null,
    category: json['category'] != null ? CategoryDto.fromJson(json['category']) : null,
    users: (json['users'] as List<dynamic>?)?.map((e) => UsersDto.fromJson(e)).toList() ?? [],
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

class CategoryDto {
  final int? id;
  final String? name;

  CategoryDto({this.id, this.name});

  factory CategoryDto.fromJson(Map<String, dynamic> json) => CategoryDto(id: json['id'], name: json['name']);
}

class UsersDto {
  final int? id;
  final String? email;

  UsersDto({this.id, this.email});

  factory UsersDto.fromJson(Map<String, dynamic> json) => UsersDto(id: json['id'], email: json['email']);
}
