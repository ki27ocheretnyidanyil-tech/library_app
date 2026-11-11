import 'dart:convert';

import '../../domain/entities/book.dart';
import '../../domain/interfaces/i_book_repository.dart';

/// Зберігання книг у форматі JSON.
/// Вміст «файлу» тримається в рядку, тому код працює і в DartPad.
class JsonBookRepository implements IBookRepository {
  final String filePath;
  String _fileContent = '[]';

  JsonBookRepository(this.filePath);

  String get rawJson => _fileContent;

  @override
  void add(Book book) {
    final records = _load();
    records.add(_toRecord(book));
    _save(records);
  }

  @override
  Book? getById(String id) {
    for (final r in _load()) {
      if (r['id'] == id) return _fromRecord(r);
    }
    return null;
  }

  @override
  List<Book> getAll() => _load().map(_fromRecord).toList();

  @override
  void update(Book book) {
    final records = _load();
    final index = records.indexWhere((r) => r['id'] == book.id);
    if (index < 0) {
      throw StateError('Книгу ${book.id} не знайдено у файлі $filePath.');
    }
    records[index] = _toRecord(book);
    _save(records);
  }

  List<Map<String, dynamic>> _load() => (jsonDecode(_fileContent) as List)
      .map((e) => Map<String, dynamic>.from(e as Map))
      .toList();

  void _save(List<Map<String, dynamic>> records) {
    _fileContent = const JsonEncoder.withIndent('  ').convert(records);
  }

  static Map<String, dynamic> _toRecord(Book b) => {
        'id': b.id,
        'title': b.title,
        'author': b.author,
        'year': b.year,
        'isAvailable': b.isAvailable,
        'borrowerName': b.borrowerName,
      };

  static Book _fromRecord(Map<String, dynamic> r) => Book.restore(
        id: r['id'] as String,
        title: r['title'] as String,
        author: r['author'] as String,
        year: r['year'] as int,
        isAvailable: r['isAvailable'] as bool,
        borrowerName: r['borrowerName'] as String?,
      );
}
