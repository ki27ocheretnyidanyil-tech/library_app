import '../../domain/interfaces/i_book_repository.dart';
import '../exceptions/book_not_found_exception.dart';

/// Сценарій «Видати книгу читачу».
class LendBookUseCase {
  final IBookRepository _repository;
  LendBookUseCase(this._repository);

  void execute(String bookId, String borrowerName) {
    final book = _repository.getById(bookId);
    if (book == null) throw BookNotFoundException(bookId);
    book.lend(borrowerName); // бізнес-правило живе в сутності
    _repository.update(book);
  }
}
