import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quick_news/models/show_category.dart';
import 'package:quick_news/pages/article_view.dart';

import '../servies/show_category_news.dart';

class CategoriesNews extends StatefulWidget {
  // get the category name to display on app bar
  String newsCategoryName;
  CategoriesNews({required this.newsCategoryName, super.key});

  @override
  State<CategoriesNews> createState() => _CategoriesNewsState();
}

class _CategoriesNewsState extends State<CategoriesNews> {
  List<ShowCategoryModel> showCategoryList = [];
  bool _loading = true;

  getCategories() async {
    //obj
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews
        .getCategoryNews(widget.newsCategoryName.toLowerCase());
    showCategoryList = showCategoryNews.categoriesList;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.newsCategoryName,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87))
          ],
        ),
      ),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: showCategoryList.length,
          itemBuilder: (context, index) {
            return ShowCategory(
              image: showCategoryList[index].urlToImage!,
              desc: showCategoryList[index].description!,
              title: showCategoryList[index].title!,
              url: showCategoryList[index].url!,
            );
          },
        ),
      ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  String title, image, desc, url;
  ShowCategory(
      {required this.title,
      required this.image,
      required this.desc,
      required this.url,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              desc,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
