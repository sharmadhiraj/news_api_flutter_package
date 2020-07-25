# News API Flutter Package

Flutter package for accessing News API. (https://newsapi.org/)

## Getting Started
* <a href="https://pub.dev/packages/news_api_flutter_package/install" target="_blank">Installation Guide</a>
* <a href="https://pub.dev/packages/news_api_flutter_package/example" target="_blank">Example</a>


## Initialization
```dart
NewsAPI _newsAPI = NewsAPI("your_api_key");
```
<a href="https://newsapi.org/register" target="_blank">Get API Key</a>
<hr/>

### Top Headlines
```dart
Future<List<Article>> articleList = _newsAPI.getTopHeadlines();
```
Parameters  
*String country, String category, String sources, String query, int pageSize, int page*

<a href="https://newsapi.org/docs/endpoints/top-headlines" target="_blank">Details on request and parameters.</a>

### Everything
```dart
Future<List<Article>> articleList = _newsAPI.getEverything();
```
Parameters  
*String query, String queryInTitle, String sources, String domains, String excludeDomains, DateTime from, DateTime to, String language, String sortBy, int pageSize, int page*

<a href="https://newsapi.org/docs/endpoints/everything" target="_blank">Details on request and parameters.</a>


### Sources
```dart
Future<List<Source>> sources = _newsAPI.getSources();
```
Parameters  
*String category, String language, String country*

<a href="https://newsapi.org/docs/endpoints/sources" target="_blank">Details on request and parameters.</a>

<hr/>

### Errors
Any error occurred will be instance of ApiError.
```dart
class ApiError{
    String code;
    String message;
}
```
<a href="https://newsapi.org/docs/errors" target="_blank">Details on error.</a>