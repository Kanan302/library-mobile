import '../../../entity/book/get_books/get_books_entity.dart';

abstract class IGetBooksRepository {
  Future<List<GetBookEntity>> getBooks();
}
