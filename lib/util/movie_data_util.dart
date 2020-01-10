import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/model/movie_photo.dart';

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

  static List<MoviePhoto> getPhotoList(var list) {
    if (list == null) {
      return null;
    }
    List content = list;
    List<MoviePhoto> photos = [];
    content.forEach((data) {
      photos.add(MoviePhoto.fromJson(data));
    });
    return photos;
  }
}
