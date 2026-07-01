import 'package:example/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

const _apiKey = "NEWS_API_KEY";

void main() {
  NewsAPI.init(apiKey: _apiKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News API Example Project",
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
