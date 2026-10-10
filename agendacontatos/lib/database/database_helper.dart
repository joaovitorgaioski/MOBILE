import 'package:agendacontatos/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final filePath = path.join(dbPath, 'agenda.db');

    return await openDatabase(
      filePath,
      version: 1,
      onCreate: (db, version) async {
        db.execute('''CREATE TABLE tbcontact (
                    id INTEGER PRIMARY KEY AUTOINCREMENT
                    name TEXT NOT NULL
                    phone TEXT NOT NULL
                    email TEXT NOT NULL
                    age TEXT NOT NULL
                    )''');
      },
    );
  }

  Future<List<Contact>> getAll({String? search}) async {
    final db = await database;

    String? whereClause;
    List<dynamic>? whereArgs;

    if (search != null && search.trim().isNotEmpty) {
      whereClause = 'name LIKE ? OR phone LIKE ? email LIKE ?';
      final term = '%${search.trim()}%';
      whereArgs = [term, term, term];
    }

    final result = await db.query(
      'tbcontact',
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: 'name ASC',
    );

    return result.map(Contact.fromMap).toList();
  }

  Future<int> insert(Contact c) async {
    final db = await database;
    return await db.insert('tbcontact', c.toMap());
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete('tbcontact', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Contact c) async {
    final db = await database;
    return await db.update(
      'tbcontact',
      c.toMap(),
      where: 'id = ?',
      whereArgs: [c.id],
    );
  }
}
