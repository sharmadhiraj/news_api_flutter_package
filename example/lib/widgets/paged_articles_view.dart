import 'package:example/widgets/article_tile.dart';
import 'package:example/widgets/error_view.dart';
import 'package:example/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

/// Renders a paginated, pull-to-refreshable list of articles.
///
/// Give it a new [key] (e.g. derived from the active filters) to make it
/// reset and reload from page 1.
class PagedArticlesView extends StatefulWidget {
  const PagedArticlesView({required this.fetch, super.key});

  final Future<ArticlesResponse> Function(int page) fetch;

  @override
  State<PagedArticlesView> createState() => _PagedArticlesViewState();
}

class _PagedArticlesViewState extends State<PagedArticlesView> {
  final List<Article> _articles = [];
  int _page = 1;
  int _totalResults = 0;
  bool _isLoading = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load(1, reset: true);
  }

  Future<void> _load(int page, {required bool reset}) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final response = await widget.fetch(page);
      if (!mounted) return;
      setState(() {
        _page = page;
        _totalResults = response.totalResults;
        if (reset) _articles.clear();
        _articles.addAll(response.articles);
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e);
      if (_articles.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(describeError(e))),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_articles.isEmpty && _error != null) {
      return ErrorView(error: _error!, onRetry: () => _load(1, reset: true));
    }
    if (_articles.isEmpty && _isLoading) {
      return const LoadingView();
    }
    return RefreshIndicator(
      onRefresh: () => _load(1, reset: true),
      child: ListView.builder(
        itemCount: _articles.length + 1,
        itemBuilder: (context, index) => index == _articles.length
            ? _buildFooter()
            : ArticleTile(article: _articles[index]),
      ),
    );
  }

  Widget _buildFooter() {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: TextButton(
            onPressed: () => _load(_page + 1, reset: false),
            child: const Text("Couldn't load more. Tap to retry."),
          ),
        ),
      );
    }
    if (_articles.length >= _totalResults) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(child: Text("$_totalResults result(s)")),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: TextButton(
          onPressed: () => _load(_page + 1, reset: false),
          child: const Text("Load more"),
        ),
      ),
    );
  }
}
