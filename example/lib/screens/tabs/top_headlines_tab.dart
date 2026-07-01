import 'package:example/widgets/enum_dropdown.dart';
import 'package:example/widgets/paged_articles_view.dart';
import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

class TopHeadlinesTab extends StatefulWidget {
  const TopHeadlinesTab({super.key});

  @override
  State<TopHeadlinesTab> createState() => _TopHeadlinesTabState();
}

class _TopHeadlinesTabState extends State<TopHeadlinesTab> {
  NewsCountry? _country = NewsCountry.us;
  NewsCategory? _category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: EnumDropdown<NewsCountry>(
                  label: "Country",
                  value: _country,
                  values: NewsCountry.values,
                  onChanged: (value) => setState(() => _country = value),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: EnumDropdown<NewsCategory>(
                  label: "Category",
                  value: _category,
                  values: NewsCategory.values,
                  onChanged: (value) => setState(() => _category = value),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: PagedArticlesView(
            key: ValueKey("$_country-$_category"),
            fetch: (page) => NewsAPI.instance.getTopHeadlines(
              country: _country,
              category: _category,
              page: page,
            ),
          ),
        ),
      ],
    );
  }
}
