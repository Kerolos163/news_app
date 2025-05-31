import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/core/extensions/date_time.dart';
import 'package:news_app/features/home/state/home_provider.dart';
import 'package:news_app/features/home/widgets/category_list_widget.dart';
import 'package:news_app/features/home/widgets/news_card.dart';
import 'package:news_app/features/home/widgets/trending_news_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider()..loadNews(),
      child: Scaffold(
        body: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: TrendingNews(
                    isLoading: homeProvider.isLoadingHeadlines,
                    articles: homeProvider.topHeadlines,
                    formatTimeAgo: (DateTime dataTime) => dataTime.dateFormate,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: CategoryList(
                      categories: homeProvider.categories,
                      selectedCategory: homeProvider.selectedCategory,
                      onCategorySelected:
                          (category) => homeProvider.changeCategory(category: category),
                    ),
                  ),
                ),
                homeProvider.isLoadingEverything
                    ? SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    )
                    : SliverToBoxAdapter(
                      child: ValueListenableBuilder(
                        valueListenable: Hive.box('bookmarks').listenable(),
                        builder: (context, Box box, _) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: homeProvider.everythingArticles.length,
                            itemBuilder: (context, index) {
                              final article = homeProvider.everythingArticles[index];
                              final isBookmarked = box.containsKey(article.url);
                              return NewsCard(
                                article: article,
                                isBookmarked: isBookmarked,
                                formatTimeAgo:
                                    (DateTime dataTime) => dataTime.dateFormate,
                              );
                            },
                          );
                        },
                      ),
                    ),
              ],
            );
          },
        ),
      ),
    );
  }
}
