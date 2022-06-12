import 'package:flutter/material.dart';
import 'package:flutter_vanilla_todos/repositories/todos_repository.dart';
import 'package:flutter_vanilla_todos/todos/todos_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    initialize();
  }

  Future<void> initialize() async {
    final todos = await TodosRepository.getTodos();

    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => TodosPage(initialTodos: todos),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: Image.asset(
                'assets/splash_icon.png',
              ),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
