# example
# 使用步骤
## 1. 创建ViewModel

```dart
class MovieListViewModel extends BaseViewModel<MovieRepository> {
  /// 获取即将上映电影
  Future<dynamic> getComingList({int start, int count}) async {
    var result = await requestData(
        mRepository.getComingList(start: start, count: count));
    if (result != null && result.data != null) {
      return result.data['subjects'];
    } else {
      return null;
    }
  }

  @override
  MovieRepository createRepository() {
    return new MovieRepository();
  }
}
```

## 2. 创建Repository

```dart
/// 电影
class MovieRepository extends BaseRepository {
  /// 获取即将上映电影
  Future<dynamic> getComingList({int start, int count}) async {
    var result = await get(ApiService.getComingSoon(),
        params: {'start': start, 'count': count});
    return result;
  }
}
```

## 3. widget使用,使用ListView实现下拉刷新，上拉加载更多

### 3.1. 通过ProviderWidget创建ViewModel对象
```dart
 /// 是否加载更多
  bool _loadMore = false;
  /// 是否是刷新
  bool _refresh = false;
  int start = 0;
  int count = 20;
  List<MovieItem> movieData = [];
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MovieListViewModel, MovieRepository>(
        model: MovieListViewModel(),
        initData: (model) {
          addListener(model);
          loadData(model: model);
        },
        builder: (context, model, child) {
          if (!model.isSuccessShowDataState() && movieData.length == 0) {
            return CommonViewStateHelper(
                model: model,
                onEmptyPressed: () {
                  refreshData(model: model);
                },
                onErrorPressed: () {
                  refreshData(model: model);
                });
          }
          if (model.isError()) {
            Toast.show(model.viewStateError.message);
          }
          if (movieData.length == 0) {
            return ViewStateEmptyWidget(onPressed: () {
              refreshData(model: model);
            });
          }
          return Scaffold(
              appBar: AppBar(
                  title: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, color: AppColor.white),
              )),
              body: RefreshIndicator(
                  child: _buildHomeList(),
                  onRefresh: () {
                    return refreshData(model: model);
                  }));
        });
  }

  /// 构建首页列表
  Widget _buildHomeList() {
    return Container(
        color: AppColor.white,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: movieData.length,
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (_loadMore && (index + 1) == movieData.length) {
                return Container(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              }
              MovieItem movieItem = movieData[index];
              return new MovieListItemView(movieItem, 'coming_soon');
            }));
  }
```
### 3.2. 刷新方法和加载更多方法实现
```dart
   /// 刷新数据
  Future<void> refreshData({@required MovieListViewModel model}) async {
    start = 0;
    count = 20;
    loadData(model: model, isRefresh: true);
  }

  /// 加载更多数据
  Future<void> loadMoreData({@required MovieListViewModel model}) async {
    loadData(model: model, isLoadMore: true);
  }

  Future<dynamic> loadData(
      {MovieListViewModel model,
      bool isRefresh = false,
      bool isLoadMore = false}) async {
    model.isRefresh = isRefresh;
    var list = await model.getComingList(start: start, count: count);
    var movieList = MovieDataUtil.getMovieList(list);
    if (isRefresh) {
      this.movieData.clear();
    }
    if (movieList == null || movieList.isEmpty) {
      model.isLoadMore = false;
      _loadMore = false;
    } else {
      model.isLoadMore = true;
      _loadMore = true;
      start += count;
      this.movieData.addAll(movieList);
    }
    refreshState(model: model);
    return null;
  }
```

### 3.3. 添加列表监听
```dart
/// 添加监听
  void addListener(MovieListViewModel model) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_loadMore) {
          _loadMore = false;
          model.isLoadMore = true;
          loadMoreData(model: model);
        }
      }
    });
  }
```

### 3.4. 刷新状态

```dart
 /// 刷新状态
  void refreshState({@required MovieListViewModel model}) {
    if (movieData.isEmpty) {
      model.setEmpty();
    } else {
      model.setSuccess();
    }
  }
```


