import 'package:agendacontatos/screens/home_screen.dart';
import 'package:agendacontatos/database/database_seeder.dart';
import 'package:agendacontatos/util/auth.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseSeeder.seed();

  Auth auth = Auth();
  if (await auth.authenticate()) {
    runApp(const MainApp());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}
