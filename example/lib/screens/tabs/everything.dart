import 'package:example/widgets/article.dart';
import 'package:example/widgets/error.dart';
import 'package:example/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/model/error.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

class EverythingTabBody extends StatelessWidget {
  const EverythingTabBody({required this.newsAPI, super.key});

  final NewsAPI newsAPI;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: newsAPI.getEverything(query: "bitcoin"),
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? snapshot.hasData
                ? ArticleListVIew(articles: snapshot.data!)
                : ApiErrorWidget(error: snapshot.error as ApiError)
            : ProgressWidget();
      },
    );
  }
}
