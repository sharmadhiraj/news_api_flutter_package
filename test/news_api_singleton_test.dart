import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';
import 'package:test/test.dart';

class _TrackingClient extends http.BaseClient {
  _TrackingClient({required this.onClose});

  final void Function() onClose;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw UnimplementedError();
  }

  @override
  void close() {
    onClose();
    super.close();
  }
}

void main() {
  test("instance throws before init is called", () {
    expect(() => NewsAPI.instance, throwsStateError);
  });

  test("init configures a reusable shared instance", () async {
    NewsAPI.init(
      apiKey: "test_key",
      client: MockClient((request) async {
        expect(request.url.queryParameters["apiKey"], "test_key");
        return http.Response(
          jsonEncode({"status": "ok", "totalResults": 0, "articles": []}),
          200,
        );
      }),
    );

    expect(NewsAPI.instance, same(NewsAPI.instance));
    await NewsAPI.instance.getTopHeadlines();
  });

  test("calling init again closes the previously shared client", () {
    var closed = false;
    NewsAPI.init(
      apiKey: "first_key",
      client: _TrackingClient(onClose: () => closed = true),
    );

    NewsAPI.init(apiKey: "second_key");

    expect(closed, isTrue);
    expect(NewsAPI.instance.apiKey, "second_key");
  });
}
