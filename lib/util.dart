import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_api_flutter_package/model/error.dart';

class Util {
  static const String _baseUrl = "https://newsapi.org/v2/";

  static Future<dynamic> call({
    required String apiKey,
    required String url,
    required String dataKey,
  }) async {
    url = "$_baseUrl$url&apiKey=$apiKey";
    debugPrint(url);
    try {
      var response = await http.get(Uri.parse(url));
      Map<String, dynamic> responseJson = json.decode(response.body);
      if (responseJson["status"].toString().toLowerCase() == "ok") {
        return responseJson[dataKey];
      }
      return Future.error(
        ApiError(
          responseJson["code"],
          responseJson["message"],
        ),
      );
    } catch (e) {
      return Future.error(ApiError("unknown", e.toString()));
    }
  }

  static String formatDate(DateTime dt) {
    return "${dt.year}-${dt.month}-${dt.day}T${dt.hour}:${dt.minute}:${dt.second}";
  }

  static String sanitize(String value) {
    return value.isEmpty || !value.contains(".")
        ? value
        : value.toString().split(".").last;
  }

  static String buildSourcesUrl(
    String path,
    String? category,
    String? language,
    String? country,
  ) {
    final Uri url = Uri.parse("$path?x=y");
    final queryParams = <String, String>{};
    if (category != null) queryParams["category"] = Util.sanitize(category);
    if (language != null) queryParams["language"] = Util.sanitize(language);
    if (country != null) queryParams["country"] = Util.sanitize(country);
    return url.replace(queryParameters: queryParams).toString();
  }

  static String buildEverythingUrl(
    String? query,
    String? queryInTitle,
    String? sources,
    String? domains,
    String? excludeDomains,
    DateTime? from,
    DateTime? to,
    String? language,
    String? sortBy,
    int? pageSize,
    int? page,
  ) {
    final Uri url = Uri.parse("everything?x=y");
    final queryParams = <String, String>{};
    if (query != null) queryParams["q"] = query;
    if (queryInTitle != null) queryParams["qInTitle"] = queryInTitle;
    if (sources != null) queryParams["sources"] = sources;
    if (domains != null) queryParams["domains"] = domains;
    if (excludeDomains != null) queryParams["excludeDomains"] = excludeDomains;
    if (from != null) queryParams["from"] = Util.formatDate(from);
    if (to != null) queryParams["to"] = Util.formatDate(to);
    if (language != null) queryParams["language"] = language;
    if (sortBy != null) queryParams["sortBy"] = sortBy;
    if (pageSize != null) queryParams["pageSize"] = pageSize.toString();
    if (page != null) queryParams["page"] = page.toString();
    return url.replace(queryParameters: queryParams).toString();
  }

  static String buildTopHeadlinesUrl(
    String? country,
    String? category,
    String? sources,
    String? query,
    int? pageSize,
    int? page,
  ) {
    final Uri url = Uri.parse("top-headlines?x=y");
    final queryParams = <String, String>{};
    if (country != null) queryParams["country"] = country;
    if (category != null) queryParams["category"] = category;
    if (sources != null) queryParams["sources"] = sources;
    if (query != null) queryParams["q"] = query;
    if (pageSize != null) queryParams["pageSize"] = pageSize.toString();
    if (page != null) queryParams["page"] = page.toString();
    return url.replace(queryParameters: queryParams).toString();
  }
}
