import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter/pages/home/home_page.dart';
import 'package:todo_flutter/theme/todo_theme.dart';

void main() {
  // Replace with your OpenAPI API-Key
  OpenAI.apiKey = '...';
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      routes: {
        '/home': (_) => const HomePageWidget(),
        '/create': (_) => const HomePageWidget()
      },
      initialRoute: '/home',
    );
  }
}
