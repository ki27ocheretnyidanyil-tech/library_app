import '../../domain/entities/book.dart';
import '../../domain/interfaces/i_book_repository.dart';

/// Сценарій «Переглянути каталог книг» (відсортовано за назвою).
class GetAllBooksUseCase {
  final IBookRepository _repository;
  GetAllBooksUseCase(this._repository);

  List<Book> execute() {
    final books = _repository.getAll();
    return books;
  }
}
