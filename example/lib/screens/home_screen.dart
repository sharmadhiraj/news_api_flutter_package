import 'package:example/screens/tabs/everything_tab.dart';
import 'package:example/screens/tabs/sources_tab.dart';
import 'package:example/screens/tabs/top_headlines_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("News API Demo"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Top Headlines"),
              Tab(text: "Everything"),
              Tab(text: "Sources"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TopHeadlinesTab(),
            EverythingTab(),
            SourcesTab(),
          ],
        ),
      ),
    );
  }
}
