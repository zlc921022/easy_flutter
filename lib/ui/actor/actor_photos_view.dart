import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/base/provider_widget.dart';
import 'package:flutter_movie/model/movie_photo.dart';
import 'package:flutter_movie/repository/actor_repository.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_app_bar.dart';
import 'package:flutter_movie/viewmodel/actor_view_model.dart';

class ActorPhotosView extends StatelessWidget {
  final String title;
  final String action;
  final String id;

  ActorPhotosView(this.title, this.id, {this.action});

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ActorViewModel, ActorRepository>(
        model: ActorViewModel(),
        initData: (model) {
          if (action == 'stills') {
            model.getMovieAlbum(movieId: id, start: 0, count: 20);
          } else {
            model.getActorPhotos(actorId: id, start: 0, count: 20);
          }
        },
        builder: (context, model, child) {
          if (model.moviePhotos == null) {
            return new Scaffold(
              body: new Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          return Scaffold(
            appBar: CommonAppBar(context, title),
            body: GridView.builder(
                itemCount: model.moviePhotos?.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
                itemBuilder: (context, index) {
                  var moviePhoto = model.moviePhotos[index];
                  return _buildPhotoItem(
                      context, moviePhoto, model.imagesUrls, index);
                }),
          );
        });
  }

  Widget _buildPhotoItem(BuildContext context, MoviePhoto moviePhoto,
      List<String> imageUrls, int index) {
    return GestureDetector(
      onTap: () {
        AppNavigator.toPhotoViewGallery(context, imageUrls, index);
      },
      child: Image(
        image: CachedNetworkImageProvider(moviePhoto.cover),
        fit: BoxFit.cover,
      ),
    );
  }
}
