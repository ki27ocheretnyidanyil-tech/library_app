/// Виняток, що сигналізує про порушення бізнес-правила домену.
class DomainException implements Exception {
  final String message;
  DomainException(this.message);

  @override
  String toString() => message;
}
