import '../../domain/entities/book.dart';
import '../../domain/interfaces/i_book_repository.dart';

/// Сценарій «Додати книгу до каталогу».
class AddBookUseCase {
  final IBookRepository _repository;
  AddBookUseCase(this._repository);

  Book execute(String title, String author, int year) {
    final book = Book.create(title, author, year);
    _repository.add(book);
    return book;
  }
}
