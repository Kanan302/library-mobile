import '../../../dto/book/get_books/get_books_dto.dart';
import '../../../entity/book/get_books/get_books_entity.dart';

extension GetBookMapper on GetBookDto {
  GetBookEntity toEntity() => GetBookEntity(
    id: id,
    title: title,
    imageBase64: imageBase64,
    readDate: readDate,
    review: review,
    author: author?.toEntity(),
    category: category?.toEntity(),
    users: users?.map((e) => e.toEntity()).toList(),
  );
}

extension AuthorMapper on AuthorDto {
  AuthorEntity toEntity() => AuthorEntity(id: id, name: name, imageBase64: imageBase64, review: review);
}

extension CategoryMapper on CategoryDto {
  CategoryEntity toEntity() => CategoryEntity(id: id, name: name);
}

extension UsersMapper on UsersDto {
  UsersEntity toEntity() => UsersEntity(id: id, email: email);
}
