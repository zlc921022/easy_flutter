
import 'model/movie_item.dart';

class MovieDataUtil {
  static List<MovieItem> getMovieList(var list) {
    if (list == null) {
      return null;
    }
    List content = list;
    List<MovieItem> movies = [];
    content.forEach((data) {
      movies.add(MovieItem.fromJson(data));
    });
    return movies;
  }
}
