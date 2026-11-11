/// Книгу з указаним ідентифікатором не знайдено у сховищі.
class BookNotFoundException implements Exception {
  final String id;
  BookNotFoundException(this.id);

  @override
  String toString() => 'Книгу з ідентифікатором $id не знайдено.';
}
