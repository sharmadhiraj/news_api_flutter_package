import 'package:example/widgets/error.dart';
import 'package:example/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/model/error.dart';
import 'package:news_api_flutter_package/model/source.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

class SourcesTabBody extends StatelessWidget {
  const SourcesTabBody({required this.newsAPI, super.key});

  final NewsAPI newsAPI;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Source>>(
      future: newsAPI.getSources(),
      builder: (BuildContext context, AsyncSnapshot<List<Source>> snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? snapshot.hasData
                ? _buildSourceListView(snapshot.data!)
                : ApiErrorWidget(error: snapshot.error as ApiError)
            : ProgressWidget();
      },
    );
  }

  Widget _buildSourceListView(List<Source> sources) {
    return ListView.builder(
      itemCount: sources.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(sources[index].name!),
            subtitle: Text(sources[index].description!),
          ),
        );
      },
    );
  }
}
