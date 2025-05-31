import 'package:flutter/material.dart';
import 'package:news_app/core/service_locator.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/features/home/repositories/base_news_api_repository.dart';

class HomeProvider extends ChangeNotifier {
  final BaseNewsApiRepository repository = locator<BaseNewsApiRepository>();
  List<NewsArticle> topHeadlines = [];
  List<NewsArticle> everythingArticles = [];
  bool isLoadingHeadlines = true;
  bool isLoadingEverything = true;
  String selectedCategory = 'Top News';

  final List<String> categories = [
    'Top News',
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];

  /// TODO : Task - Make Provider For This
  Future<void> loadNews() async {
    isLoadingHeadlines = true;
    isLoadingEverything = true;

    try {
      final headlines = await repository.fetchTopHeadlines(
        category: selectedCategory == 'Top News' ? 'general' : selectedCategory,
      );

      topHeadlines = headlines;
      isLoadingHeadlines = false;
    } catch (_) {
      topHeadlines = [];
      isLoadingHeadlines = false;
    }

    try {
      final everything = await repository.fetchEverything(
        query: selectedCategory == 'Top News' ? 'news' : selectedCategory,
      );

      everythingArticles = everything;
      isLoadingEverything = false;
    } catch (_) {
      everythingArticles = [];
      isLoadingEverything = false;
    }
    notifyListeners();
  }

  void changeCategory({required String category}) {
    selectedCategory = category;
    loadNews();
  }
}
