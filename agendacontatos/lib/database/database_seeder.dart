import 'package:agendacontatos/database/database_helper.dart';
import 'package:agendacontatos/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSeeder {
  static Future<void> seed() async {
    // Retorna a instancia do banco de dados
    final dbHelper = DatabaseHelper();
    final db = await dbHelper.database;

    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM tbcontact'),
    );

    await dbHelper.insert(
      Contact(
        name: "João",
        phone: "(42) 99999-9999",
        email: "joao@gmail.com",
        age: "27",
      ),
    );

    await dbHelper.insert(
      Contact(
        name: "Gandalf",
        phone: "(41) 92939-5949",
        email: "gandalf@gmail.com",
        age: "80",
      ),
    );

    await dbHelper.insert(
      Contact(
        name: "Marcos",
        phone: "(42) 91111-1111",
        email: "marcos@gmail.com",
        age: "34",
      ),
    );
  }
}
