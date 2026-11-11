import '../../domain/entities/book.dart';
import '../../domain/interfaces/i_book_repository.dart';

/// Зберігання книг у пам'яті (дані зникають після завершення програми).
class InMemoryBookRepository implements IBookRepository {
  final Map<String, Book> _books = {};

  @override
  void add(Book book) {
    _books[book.id] = book;
  }

  @override
  Book? getById(String id) => _books[id];

  @override
  List<Book> getAll() => _books.values.toList();

  @override
  void update(Book book) {
    if (!_books.containsKey(book.id)) {
      throw StateError('Книгу ${book.id} не знайдено у сховищі.');
    }
    _books[book.id] = book;
  }
}
