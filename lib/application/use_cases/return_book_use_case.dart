import '../../domain/interfaces/i_book_repository.dart';
import '../exceptions/book_not_found_exception.dart';

/// Сценарій «Повернути книгу до бібліотеки».
class ReturnBookUseCase {
  final IBookRepository _repository;
  ReturnBookUseCase(this._repository);

  void execute(String bookId) {
    final book = _repository.getById(bookId);
    if (book == null) throw BookNotFoundException(bookId);
    book.giveBack();
    _repository.update(book);
  }
}
