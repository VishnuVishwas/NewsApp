// get all content from API
// article_model.dart

class ArticleModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;

  ArticleModel(
      {this.description,
      this.title,
      this.author,
      this.content,
      this.url,
      this.urlToImage});
}
