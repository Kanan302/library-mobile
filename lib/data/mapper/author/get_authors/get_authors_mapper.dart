import '../../../dto/author/get_authors/get_authors_dto.dart';
import '../../../entity/author/get_authors/get_authors_entity.dart';

extension GetAuthorsMapper on GetAuthorsDto {
  GetAuthorsEntity toEntity() => GetAuthorsEntity(
    id: id,
    name: name,
    imageBase64: imageBase64,
    review: review,
    categories: categories?.map((e) => e.toEntity()).toList(),
    books: books?.map((e) => e.toEntity()).toList(),
  );
}

extension CategoriesMapper on CategoriesDto {
  CategoriesEntity toEntity() => CategoriesEntity(id: id, name: name);
}

extension BooksMapper on BooksDto {
  BooksEntity toEntity() =>
      BooksEntity(id: id, title: title, imageBase64: imageBase64, readDate: readDate, review: review);
}
