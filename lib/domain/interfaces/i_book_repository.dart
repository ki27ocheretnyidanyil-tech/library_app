import '../entities/book.dart';

/// Абстракція сховища книг. Оголошена в Domain,
/// а реалізується в Infrastructure (принцип інверсії залежностей).
abstract interface class IBookRepository {
  void add(Book book);
  Book? getById(String id);
  List<Book> getAll();
  void update(Book book);
}
