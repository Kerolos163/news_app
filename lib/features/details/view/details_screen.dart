import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/date_time.dart';
import 'package:news_app/features/details/state/details.provider.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/features/main/main_screen.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsArticle article = ModalRoute.of(context)!.settings.arguments as NewsArticle;
    log('article: ${article.url}');
    return ChangeNotifierProvider<DetailsProvider>(
      create: (context) => DetailsProvider()..isMarked(key: article.url),
      child: Scaffold(
        appBar: AppBar(
          title: Text("News Details"),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new, size: 22),
          ),
        ),

        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          children: [
            article.urlToImage == null
                ? Image.network(
                  "assets/images/demo.png",
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                : Image.network(
                  article.urlToImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
            SizedBox(height: 12),
            Text(article.title, style: Theme.of(context).textTheme.labelMedium),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/channelLogo.png"),
                SizedBox(width: 4),
                Text(
                  article.sourceName,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Color(0XFF141414)),
                ),
                SizedBox(width: 12),
                Text(
                  article.publishedAt.dateFormate,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Spacer(),
                CustomSVG(imgPath: "assets/images/shareIcon.svg"),
                SizedBox(width: 8),
                Consumer<DetailsProvider>(
                  builder: (context, detailsProvider, child) {
                    return GestureDetector(
                      child: CustomSVG(
                        imgPath: "assets/images/BookMarkIcon.svg",
                        isSelected: detailsProvider.marked,
                      ),
                      onTap:
                          () => detailsProvider.changeMark(
                            key: article.url,
                            value: article,
                          ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              "humanitarian initiative led by the Life Again Education and Culture Foundation with the support of Türkiye Sigorta. The project brought a group of children from Kahramanmaraş and surrounding earthquake-affected regions to Istanbul for a series of events aimed at supporting their psychological recovery and personal development",

              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
