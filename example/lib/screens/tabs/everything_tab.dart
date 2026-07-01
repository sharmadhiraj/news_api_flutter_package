import 'package:example/widgets/enum_dropdown.dart';
import 'package:example/widgets/paged_articles_view.dart';
import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

class EverythingTab extends StatefulWidget {
  const EverythingTab({super.key});

  @override
  State<EverythingTab> createState() => _EverythingTabState();
}

class _EverythingTabState extends State<EverythingTab> {
  final _queryController = TextEditingController(text: "flutter");
  String _query = "flutter";
  NewsLanguage? _language = NewsLanguage.en;
  ArticleSortBy? _sortBy = ArticleSortBy.publishedAt;

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: TextField(
            controller: _queryController,
            decoration: const InputDecoration(
              labelText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              isDense: true,
            ),
            onSubmitted: (value) => setState(() => _query = value.trim()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: EnumDropdown<NewsLanguage>(
                  label: "Language",
                  value: _language,
                  values: NewsLanguage.values,
                  onChanged: (value) => setState(() => _language = value),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: EnumDropdown<ArticleSortBy>(
                  label: "Sort by",
                  value: _sortBy,
                  values: ArticleSortBy.values,
                  onChanged: (value) => setState(() => _sortBy = value),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _query.isEmpty
              ? const Center(child: Text("Enter a search term"))
              : PagedArticlesView(
                  key: ValueKey("$_query-$_language-$_sortBy"),
                  fetch: (page) => NewsAPI.instance.getEverything(
                    query: _query,
                    language: _language,
                    sortBy: _sortBy,
                    page: page,
                  ),
                ),
        ),
      ],
    );
  }
}
