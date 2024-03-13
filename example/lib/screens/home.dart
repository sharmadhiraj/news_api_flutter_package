import 'package:example/screens/tabs/everything.dart';
import 'package:example/screens/tabs/sources.dart';
import 'package:example/screens/tabs/top_headlines.dart';
import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

class HomePage extends StatelessWidget {
  final NewsAPI _newsAPI = NewsAPI(apiKey: "API_KEY");

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("News API Demo"),
      bottom: _buildTabBar(),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      tabs: [
        Tab(text: "Top Headlines"),
        Tab(text: "Everything"),
        Tab(text: "Sources"),
      ],
    );
  }

  Widget _buildBody() {
    return TabBarView(
      children: [
        TopHeadlinesTabBody(newsAPI: _newsAPI),
        EverythingTabBody(newsAPI: _newsAPI),
        SourcesTabBody(newsAPI: _newsAPI),
      ],
    );
  }
}
