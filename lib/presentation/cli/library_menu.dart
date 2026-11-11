import '../../application/exceptions/book_not_found_exception.dart';
import '../../application/use_cases/add_book_use_case.dart';
import '../../application/use_cases/get_all_books_use_case.dart';
import '../../application/use_cases/lend_book_use_case.dart';
import '../../application/use_cases/return_book_use_case.dart';
import '../../domain/entities/book.dart';
import '../../domain/exceptions/domain_exception.dart';

/// Консольний інтерфейс: лише викликає use cases і показує результат.
class LibraryMenu {
  final AddBookUseCase _addBook;
  final GetAllBooksUseCase _getAllBooks;
  final LendBookUseCase _lendBook;
  final ReturnBookUseCase _returnBook;

  LibraryMenu(this._addBook, this._getAllBooks, this._lendBook, this._returnBook);

  void addBook(String title, String author, int year) {
    _run('Додати книгу', () {
      final book = _addBook.execute(title, author, year);
      print('Додано: $book');
    });
  }

  void showCatalog() {
    _run('Каталог', () {
      final books = _getAllBooks.execute();
      if (books.isEmpty) {
        print('Каталог порожній.');
        return;
      }
      for (var i = 0; i < books.length; i++) {
        print('${i + 1}. ${books[i]}');
      }
    });
  }

  void lendBook(int number, String borrower) {
    _run('Видати книгу №$number', () {
      final book = _selectBook(number);
      _lendBook.execute(book.id, borrower);
      print('Книгу «${book.title}» видано читачу $borrower.');
    });
  }

  void returnBook(int number) {
    _run('Повернути книгу №$number', () {
      final book = _selectBook(number);
      _returnBook.execute(book.id);
      print('Книгу «${book.title}» повернуто.');
    });
  }

  Book _selectBook(int number) {
    final books = _getAllBooks.execute();
    if (number < 1 || number > books.length) {
      throw ArgumentError('Невірний номер книги: $number.');
    }
    return books[number - 1];
  }

  void _run(String action, void Function() body) {
    print('\n--- $action ---');
    try {
      body();
    } on DomainException catch (e) {
      print('[Помилка] ${e.message}');
    } on BookNotFoundException catch (e) {
      print('[Помилка] $e');
    } on ArgumentError catch (e) {
      print('[Помилка] ${e.message}');
    }
  }
}
