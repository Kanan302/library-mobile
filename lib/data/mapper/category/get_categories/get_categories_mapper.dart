import '../../../dto/category/get_categories/get_categories_dto.dart';
import '../../../entity/category/get_categories/get_categories_entity.dart';

extension GetCategoryMapper on GetCategoryDto {
  GetCategoryEntity toEntity() => GetCategoryEntity(
    id: id,
    name: name,
    authors: authors?.map((e) => e.toEntity()).toList(),
    books: books?.map((e) => e.toEntity()).toList(),
  );
}

extension AuthorMapper on AuthorDto {
  AuthorEntity toEntity() => AuthorEntity(id: id, name: name, imageBase64: imageBase64, review: review);
}

extension BookMapper on BookDto {
  BookEntity toEntity() =>
      BookEntity(id: id, title: title, imageBase64: imageBase64, readDate: readDate, review: review);
}
