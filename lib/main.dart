import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _todos = [];

  Future<void> _loadData() async {
    const url = 'https://jsonplaceholder.typicode.com/todos';
    try {
      final http.Response response = await http.get(Uri.parse(url));
      final loadedTodos = json.decode(response.body);
      setState(() {
        _todos = loadedTodos;
      });
    } catch (err) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: ListView.builder(
            itemCount: _todos.length,
            itemBuilder: (BuildContext ctx, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: ListTile(
                  leading: Text(_todos[index]['id'].toString()),
                  title: _todos[index]['title'],
                  trailing: _todos[index]['completed']
                      ? const Icon(
                          Icons.radio_button_unchecked,
                          color: Colors.blue,
                        )
                      : const Icon(
                          Icons.radio_button_unchecked,
                          color: Colors.blue,
                        ),
                ),
              );
            }),
      ),
    );
  }
}
