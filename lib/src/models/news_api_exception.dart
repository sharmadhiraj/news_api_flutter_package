/// Thrown when the News API returns an error response.
///
/// See https://newsapi.org/docs/errors for the list of error codes.
class NewsApiException implements Exception {
  /// A short code identifying the type of error, e.g. `apiKeyInvalid`.
  final String code;

  /// A fuller description of the error, usually including how to fix it.
  final String message;

  /// Creates a [NewsApiException] with the given [code] and [message].
  const NewsApiException({required this.code, required this.message});

  @override
  String toString() => "NewsApiException($code): $message";
}
