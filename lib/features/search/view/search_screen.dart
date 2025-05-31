import 'package:flutter/material.dart';
import 'package:news_app/features/search/state/search_provider.dart';
import 'package:provider/provider.dart';

/// TODO : Task - Add Controller To It
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchProvider>(
      create: (context) => SearchProvider(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Search News')),
        body: Consumer<SearchProvider>(
          builder: (context, searchProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: searchProvider.searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for news...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onSubmitted: searchProvider.searchNews,
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child:
                        searchProvider.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : searchProvider.errorMessage != null
                            ? Center(child: Text(searchProvider.errorMessage!))
                            : searchProvider.articles.isEmpty
                            ? const Center(child: Text('No results found'))
                            : ListView.builder(
                              itemCount: searchProvider.articles.length,
                              itemBuilder: (context, index) {
                                final article = searchProvider.articles[index];
                                return ListTile(
                                  leading:
                                      article.urlToImage != null
                                          ? Image.network(
                                            article.urlToImage!,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(Icons.image_not_supported),
                                          )
                                          : Container(
                                            width: 50,
                                            height: 50,
                                            color: Colors.grey.shade400,
                                          ),
                                  title: Text(article.title),
                                  subtitle: Text(
                                    '${article.sourceName} • ${article.publishedAt.toString()}',
                                  ),
                                  onTap: () {
                                    // TODO: Navigate to article details screen
                                  },
                                );
                              },
                            ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
