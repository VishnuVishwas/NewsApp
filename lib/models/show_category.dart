// models/show_category.dart

// for categories_news.dart

class ShowCategoryModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;

  ShowCategoryModel(
      {this.description,
      this.title,
      this.author,
      this.content,
      this.url,
      this.urlToImage});
}
