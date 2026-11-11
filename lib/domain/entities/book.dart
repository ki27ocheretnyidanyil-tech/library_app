import '../exceptions/domain_exception.dart';

/// Сутність «Книга». Містить дані та бізнес-правила видачі й повернення.
class Book {
  static const int minYear = 1450;
  static int _counter = 0;

  final String id;
  final String title;
  final String author;
  final int year;
  bool _isAvailable;
  String? _borrowerName;

  Book._(this.id, String title, String author, this.year, this._isAvailable,
      this._borrowerName)
      : title = title.trim(),
        author = author.trim() {
    final currentYear = DateTime.now().year;
    if (this.title.isEmpty) {
      throw DomainException('Назва книги не може бути порожньою.');
    }
    if (this.author.isEmpty) {
      throw DomainException('Автор книги не може бути порожнім.');
    }
    if (year < minYear || year > currentYear) {
      throw DomainException('Рік видання має бути в межах $minYear–$currentYear.');
    }
  }

  /// Нова книга (генерується ідентифікатор).
  factory Book.create(String title, String author, int year) {
    _counter++;
    return Book._('B$_counter', title, author, year, true, null);
  }

  /// Відновлення книги зі сховища.
  factory Book.restore({
    required String id,
    required String title,
    required String author,
    required int year,
    required bool isAvailable,
    String? borrowerName,
  }) =>
      Book._(id, title, author, year, isAvailable, borrowerName);

  bool get isAvailable => _isAvailable;
  String? get borrowerName => _borrowerName;

  /// Видати книгу читачу.
  void lend(String borrowerName) {
    if (borrowerName.trim().isEmpty) {
      throw DomainException("Вкажіть ім'я читача.");
    }
    _isAvailable = false;
    _borrowerName = borrowerName.trim();
  }

  /// Повернути книгу до бібліотеки.
  void giveBack() {
    if (_isAvailable) {
      throw DomainException('Книга «$title» і так знаходиться в бібліотеці.');
    }
    _isAvailable = true;
    _borrowerName = null;
  }

  @override
  String toString() {
    final status = _isAvailable ? 'в наявності' : 'видана: $_borrowerName';
    return '$title — $author ($year) [$status]';
  }
}
