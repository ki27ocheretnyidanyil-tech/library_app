import 'dart:convert';
import 'dart:io';

/// Налаштування застосунку з файлу appsettings.json.
class AppSettings {
  final String storageType;
  final String filePath;
  AppSettings(this.storageType, this.filePath);

  factory AppSettings.fromJson(String json) {
    final root = jsonDecode(json) as Map<String, dynamic>;
    final storage = root['Storage'] as Map<String, dynamic>? ?? {};
    return AppSettings(
      storage['Type'] as String? ?? 'InMemory',
      storage['FilePath'] as String? ?? 'books.json',
    );
  }

  /// Читає налаштування з файлу; якщо файлу немає — значення за замовчуванням.
  static AppSettings load(String path) {
    final file = File(path);
    if (!file.existsSync()) return AppSettings('InMemory', 'books.json');
    return AppSettings.fromJson(file.readAsStringSync());
  }
}
