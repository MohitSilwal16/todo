import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/shawtydata.dart';
import 'package:todo/todo.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('shortterm');
  await Hive.openBox('longterm');
  await Hive.openBox('date');
  ShawtyData.dateStamp();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const ToDo(),
    );
  }
}
