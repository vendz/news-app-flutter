class ArticleModel {
  String title;
  String image;
  String content;
  String publishedTime;
  String publishedDate;
  String fullArticle;

  ArticleModel(
      {required this.content,
      required this.fullArticle,
      required this.image,
      required this.publishedDate,
      required this.publishedTime,
      required this.title});
}
