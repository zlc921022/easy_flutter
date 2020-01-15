import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/base/provider_widget.dart';
import 'package:flutter_movie/base/view_state_widget.dart';
import 'package:flutter_movie/model/movie_photo.dart';
import 'package:flutter_movie/repository/actor_repository.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_app_bar.dart';
import 'package:flutter_movie/util/movie_data_util.dart';
import 'package:flutter_movie/viewmodel/actor_view_model.dart';

/// 演员相册和剧照页面
class ActorPhotosView extends StatefulWidget {
  final String title;
  final String action;
  final String id;

  ActorPhotosView(this.title, this.id, {this.action});

  @override
  State<StatefulWidget> createState() => _ActorPhotosViewState();
}

class _ActorPhotosViewState extends State<ActorPhotosView> {
  /// 接口返回数据
  List<MoviePhoto> moviePhotos = [];
  List<String> imagesUrls = [];

  /// 能否加载更多
  bool _loadMore = false;

  final ScrollController _scrollController = new ScrollController();
  int start = 0;
  int count = 20;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ActorViewModel, ActorRepository>(
        model: ActorViewModel(),
        initData: (model) {
          loadData(model);
          _addListener(model);
        },
        builder: (context, model, child) {
          if (!model.isSuccessShowDataState()) {
            return CommonViewStateHelper(
                model: model,
                onEmptyPressed: () {
                  loadData(model);
                },
                onErrorPressed: () {
                  loadData(model);
                });
          }
          return Scaffold(
            appBar: CommonAppBar(context, widget.title),
            body: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverGrid.count(
                  crossAxisCount: 3,
                  children: getChildren(context),
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                SliverToBoxAdapter(
                  child: _buildLoadMore(),
                )
              ],
            ),
          );
        });
  }

  /// 构建相册条目
  List<Widget> getChildren(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < moviePhotos.length; i++) {
      var moviePhoto = moviePhotos[i];
      children.add(_buildPhotoItem(context, moviePhoto, imagesUrls, i));
    }
    return children;
  }

  /// 相册条目
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

  /// 加载数据
  Future<dynamic> loadData(ActorViewModel model) async {
    var photos;
    if (widget.action == 'stills') {
      photos = await model.getMovieAlbum(
          movieId: widget.id, start: start, count: count);
    } else {
      photos = await model.getActorPhotos(
          actorId: widget.id, start: start, count: count);
    }
    var newPhotos = MovieDataUtil.getPhotoList(photos);
    var newImages = await model.getImageUrls(newPhotos);
    if (newPhotos != null && newPhotos.length > 0) {
      moviePhotos.addAll(newPhotos);
      imagesUrls.addAll(newImages);
      start = start + count;
      model.isLoadMore = true;
      _loadMore = true;
    } else {
      model.isLoadMore = false;
      _loadMore = false;
    }
    if (moviePhotos.isEmpty) {
      model.setEmpty();
    } else {
      model.setSuccess();
    }
  }

  /// 添加滑动监听
  void _addListener(ActorViewModel model) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_loadMore) {
          _loadMore = false;
          loadData(model);
        }
      }
    });
  }

  /// 加载更多
  Widget _buildLoadMore() {
    if (_loadMore) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }
    return new Container();
  }
}
