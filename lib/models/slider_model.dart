// get all content from API
// slider_model.dart

class SliderModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;

  SliderModel(
      {this.description,
      this.title,
      this.author,
      this.content,
      this.url,
      this.urlToImage});
}
