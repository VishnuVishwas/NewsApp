import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:quick_news/models/article_model.dart';
import 'package:quick_news/pages/article_view.dart';
import 'package:quick_news/pages/categories_news.dart';
import 'package:quick_news/pages/view_all.dart';
import 'package:quick_news/servies/data.dart';
import 'package:quick_news/servies/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/category_model.dart';
import '../models/slider_model.dart';
import '../servies/news.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> category = [];
  List<SliderModel> sliderCategory = [];
  List<ArticleModel> articles = [];
  bool _loading = true;

  // to count the Carousel slider
  int activeIndex = 0;

  // call all the list categories during load
  @override
  void initState() {
    category = getCategories();
    getSliders();
    getNews();
    super.initState();
  }

  // load articles
  getNews() async {
    //obj
    News newsclass = News();
    await newsclass.getNews();

    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  getSliders() async {
    //obj
    SliderClass slider = SliderClass();
    await slider.getSlidersCategories();

    setState(() {
      sliderCategory = slider.sliders;
    });
  }

  // Carousel slider

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Quick',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            Text('News',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
          ],
        ),
      ),

      //body
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    // categories
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 70,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: category.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoriesNews(
                                          newsCategoryName:
                                              category[index].categoryName!)));
                            },
                            child: CategoryTile(
                              image: category[index].image,
                              categoryName: category[index].categoryName,
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 30.0),

                    // Breaking news!
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Breaking News!',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ViewAllNews(news: "Breaking")));
                            },
                            child: Text(
                              'View All',
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.0),

                    // Carousel slider
                    CarouselSlider.builder(
                      itemCount: sliderCategory.length,
                      itemBuilder: (context, index, realIndex) {
                        String? res = sliderCategory[index].urlToImage;
                        String? res1 = sliderCategory[index].title;
                        return buildImage(res!, index, res1!);
                      },
                      options: CarouselOptions(
                          height: 250,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          }),
                    ),

                    SizedBox(height: 30),

                    // page transition indicator
                    buildIndicator(),

                    SizedBox(height: 30),

                    // Trending news!
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Trending News!',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ViewAllNews(news: "Trending")));
                            },
                            child: Text(
                              'View All',
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),

                    // news section
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return ArticleTile(
                                imageUrl: articles[index].urlToImage!,
                                title: articles[index].title!,
                                desc: articles[index].description!,
                                url: articles[index].url!);
                          }),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  // build sliderCategory sliders
  Widget buildImage(String image, int index, String name) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
                imageUrl: image,
                height: 250,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width),
          ),
          // Text
          Container(
            height: 250,
            margin: EdgeInsets.only(top: 185),
            padding: EdgeInsets.only(left: 10, top: 2, right: 10),
            decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Text(
              name,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  // build slide page transition/indicator
  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: sliderCategory.length,
      effect: ExpandingDotsEffect(
        dotColor: Colors.black45,
        dotHeight: 12,
        dotWidth: 9,
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  const CategoryTile({this.image, this.categoryName, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          // image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:
                Image.asset(image, width: 120, height: 60, fit: BoxFit.cover),
          ),
          // Text
          Container(
            width: 120,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black38,
            ),
            child: Center(
                child: Text(categoryName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold))),
          ),
        ],
      ),
    );
  }
}

class ArticleTile extends StatelessWidget {
  String imageUrl, title, desc, url;
  ArticleTile(
      {required this.imageUrl,
      required this.title,
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
        margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover),
                  ),
                  SizedBox(width: 8),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.9,
                        child: Text(title,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.9,
                        child: Text(desc,
                            maxLines: 3,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
