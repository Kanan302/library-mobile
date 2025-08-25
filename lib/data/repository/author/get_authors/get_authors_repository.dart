import '../../../entity/author/get_authors/get_authors_entity.dart';

abstract class IGetAuthorsRepository {
  Future<List<GetAuthorsEntity>> getAuthors();
}
