import 'package:example/widgets/enum_dropdown.dart';
import 'package:example/widgets/error_view.dart';
import 'package:example/widgets/loading_view.dart';
import 'package:example/widgets/source_tile.dart';
import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

class SourcesTab extends StatefulWidget {
  const SourcesTab({super.key});

  @override
  State<SourcesTab> createState() => _SourcesTabState();
}

class _SourcesTabState extends State<SourcesTab> {
  NewsCategory? _category;
  NewsLanguage? _language;
  NewsCountry? _country;
  late Future<List<Source>> _sources;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() {
    _sources = NewsAPI.instance.getSources(
      category: _category,
      language: _language,
      country: _country,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: EnumDropdown<NewsCategory>(
                  label: "Category",
                  value: _category,
                  values: NewsCategory.values,
                  onChanged: (value) => setState(() {
                    _category = value;
                    _fetch();
                  }),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: EnumDropdown<NewsLanguage>(
                  label: "Language",
                  value: _language,
                  values: NewsLanguage.values,
                  onChanged: (value) => setState(() {
                    _language = value;
                    _fetch();
                  }),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: EnumDropdown<NewsCountry>(
                  label: "Country",
                  value: _country,
                  values: NewsCountry.values,
                  onChanged: (value) => setState(() {
                    _country = value;
                    _fetch();
                  }),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Source>>(
            future: _sources,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const LoadingView();
              }
              if (snapshot.hasError) {
                return ErrorView(
                  error: snapshot.error!,
                  onRetry: () => setState(_fetch),
                );
              }
              final sources = snapshot.data!;
              if (sources.isEmpty) {
                return const Center(child: Text("No sources found"));
              }
              return ListView.builder(
                itemCount: sources.length,
                itemBuilder: (context, index) =>
                    SourceTile(source: sources[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
