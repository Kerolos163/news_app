import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app/core/serves/constant_key.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class DetailsProvider extends ChangeNotifier {
  var box = Hive.box(GetKey.bookmarks);
  bool marked = false;

  void isMarked({required String key}) {
    marked = box.containsKey(key);
  }

  changeMark({required String key, required NewsArticle value}) {
    marked = !marked;
    if (marked) {
      box.put(key, value);
    } else {
      box.delete(key);
    }
    notifyListeners();
  }
}
