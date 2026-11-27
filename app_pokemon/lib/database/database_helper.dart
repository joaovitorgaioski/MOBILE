import 'package:app_pokemon/models/pokemon.dart';
import 'package:app_pokemon/models/pokemon_colecao.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final filePath = path.join(dbPath, 'app_pokemon.db');

    return await openDatabase(
      filePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE colecao (
            id           INTEGER PRIMARY KEY,
            nome         TEXT    NOT NULL,
            data_captura TEXT    NOT NULL
          )
        ''');
      },
    );
  }

  Future<List<PokemonColecao>> obterTodos() async {
    final db = await database;

    final result = await db.query('colecao', orderBy: 'data_captura DESC');

    return result.map(PokemonColecao.fromMap).toList();
  }

  Future<void> inserir(Pokemon pokemon) async {
    final db = await database;

    await db.insert('colecao', {
      'id': pokemon.id,
      'nome': pokemon.nome,
      'data_captura': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }
}
