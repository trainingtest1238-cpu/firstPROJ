class Photo {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String download_url;
  Photo({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.download_url,
  });
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      author: json['author'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      download_url: json['download_url'],
    );
  }
}
