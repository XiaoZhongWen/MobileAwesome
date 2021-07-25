class StoryModel {
  final String title;
  final String image;
  final int id;
  final String url;

  StoryModel(this.id, this.title, {this.image, this.url});

  StoryModel.fromJson(Map<String, dynamic> json)
      : this(
          json['id'] as int,
          json['title'] as String,
          image: json['image'] != null
              ? json['image'] as String
              : (json['images'] != null ? json['images'][0] : null) as String,
          url: json['url'] != null
              ? json['url'] as String
              : (json['url'] != null ? json['url'][0] : null) as String,
        );

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'image': image, 'url': url};
  }
}
