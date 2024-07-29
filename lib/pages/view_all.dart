import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/article_model.dart';
import '../models/slider_model.dart';
import '../servies/data.dart';
import '../servies/news.dart';
import '../servies/slider_data.dart';
import 'article_view.dart';

class ViewAllNews extends StatefulWidget {
  String news;
  ViewAllNews({required this.news, super.key});

  @override
  State<ViewAllNews> createState() => _ViewAllNewsState();
}

class _ViewAllNewsState extends State<ViewAllNews> {
  List<SliderModel> sliderCategory = [];
  List<ArticleModel> articles = [];

  getNews() async {
    //obj
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {});
  }

  getSliders() async {
    //obj
    SliderClass slider = SliderClass();
    await slider.getSlidersCategories();

    setState(() {
      sliderCategory = slider.sliders;
    });
  }

  @override
  void initState() {
    getSliders();
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.news + ' News',
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
          itemCount: widget.news == 'Breaking'
              ? sliderCategory.length
              : articles.length,
          itemBuilder: (context, index) {
            return AllNewsSection(
              image: widget.news == 'Breaking'
                  ? sliderCategory[index].urlToImage!
                  : articles[index].urlToImage!,
              desc: widget.news == 'Breaking'
                  ? sliderCategory[index].description!
                  : articles[index].description!,
              title: widget.news == 'Breaking'
                  ? sliderCategory[index].title!
                  : articles[index].title!,
              url: widget.news == 'Breaking'
                  ? sliderCategory[index].url!
                  : articles[index].url!,
            );
          },
        ),
      ),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  String title, image, desc, url;

  AllNewsSection(
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
