import 'package:library_app/application/use_cases/add_book_use_case.dart';
import 'package:library_app/application/use_cases/get_all_books_use_case.dart';
import 'package:library_app/application/use_cases/lend_book_use_case.dart';
import 'package:library_app/application/use_cases/return_book_use_case.dart';
import 'package:library_app/domain/interfaces/i_book_repository.dart';
import 'package:library_app/infrastructure/repositories/in_memory_book_repository.dart';
import 'package:library_app/infrastructure/repositories/json_book_repository.dart';
import 'package:library_app/presentation/cli/library_menu.dart';
import 'package:library_app/presentation/configuration/app_settings.dart';

/// Точка входу (Presentation) і Composition Root:
/// тут і тільки тут обирається конкретна реалізація сховища.
void main() {
  final settings = AppSettings.load('appsettings.json');

  final IBookRepository repository = settings.storageType == 'Json'
      ? JsonBookRepository(settings.filePath)
      : InMemoryBookRepository();


  // Use cases отримують залежність через конструктор (Dependency Injection)
  final menu = LibraryMenu(
    AddBookUseCase(repository),
    GetAllBooksUseCase(repository),
    LendBookUseCase(repository),
    ReturnBookUseCase(repository),
  );

  // Демонстраційний сценарій
  menu.addBook('Кобзар', 'Тарас Шевченко', 1840);
  menu.addBook('Лісова пісня', 'Леся Українка', 1911);
  menu.addBook('', 'Невідомий автор', 2000); // помилка: порожня назва
  menu.showCatalog();
  menu.lendBook(1, 'Олена');
  menu.lendBook(1, 'Іван'); // помилка: книга вже видана
  menu.showCatalog();
  menu.returnBook(1);
  menu.showCatalog();

  if (repository is JsonBookRepository) {
    print('\n--- Вміст ${repository.filePath} ---');
    print(repository.rawJson);
  }
}
