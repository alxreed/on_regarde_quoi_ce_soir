class Movie {
  String title;

  Movie() {
    title = '';
  }

  Movie.fromMap(dynamic map) {
    title = map["title"];
  }
}