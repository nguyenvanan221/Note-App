import 'package:flutter/material.dart';
import 'package:note_app_flutter/database/app_database.dart';
import 'package:note_app_flutter/pages/home_page.dart';
import 'package:note_app_flutter/provider/note_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteProvider(),
      builder: (context, child) {
        return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
      },
    );
  }
}
