import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

class SourceTile extends StatelessWidget {
  const SourceTile({required this.source, super.key});

  final Source source;

  @override
  Widget build(BuildContext context) {
    final tags = [source.category, source.language, source.country]
        .whereType<String>()
        .join(" · ");
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(source.name),
        subtitle: Text(source.description ?? ""),
        trailing: tags.isEmpty ? null : Text(tags),
      ),
    );
  }
}
