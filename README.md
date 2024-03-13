# News API Flutter Package

Flutter package for accessing News API. ([https://newsapi.org/](https://newsapi.org/))

## Getting Started

* [Installation Guide](https://pub.dev/packages/news_api_flutter_package/install)
* [Example Project](https://github.com/sharmadhiraj/news_api_flutter_package/tree/master/example)

## Initialization

```dart

NewsAPI _newsAPI = NewsAPI("your_api_key");
```

[Get API key from here](https://newsapi.org/register)

### Top Headlines

```dart

Future<List<Article>> articleList = _newsAPI.getTopHeadlines();
```

**Parameters**  
*String country, String category, String sources, String query, int pageSize, int page*

[Details on request and parameters](https://newsapi.org/docs/endpoints/top-headlines)

### Everything

```dart

Future<List<Article>> articleList = _newsAPI.getEverything();
```

**Parameters**  
*String query, String queryInTitle, String sources, String domains, String excludeDomains, DateTime
from, DateTime to, String language, String sortBy, int pageSize, int page*

[Details on request and parameters](https://newsapi.org/docs/endpoints/everything)

### Sources

```dart

Future<List<Source>> sources = _newsAPI.getSources();
```

**Parameters**  
*String category, String language, String country*

[Details on request and parameters](https://newsapi.org/docs/endpoints/sources)

### Errors

Any error occurred will be instance of ApiError.

```dart
class ApiError {
  String code;
  String message;
}
```

[Details on errors](https://newsapi.org/docs/errors)

<hr/>

I'm always working on making improvements. If you have any feedback, issues, or suggestions, feel
free to reach out. Happy coding!