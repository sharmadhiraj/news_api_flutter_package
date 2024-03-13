import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/model/error.dart';

class ApiErrorWidget extends StatelessWidget {
  const ApiErrorWidget({required this.error, super.key});

  final ApiError error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error.code ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 4),
            Text(error.message ?? "", textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
