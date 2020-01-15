# Flutter MVVM框架介绍

A Flutter MVVM plugin for iOS and Android,It makes Make development easier。

# 代码说明：

- BaseRepository：负责统一封装get和post请求，供子类调用，获取服务器数据
- BaseViewModel：负责管理widget加载状态，提供一个抽象方法创建Repository对象，通过这个对象从服务器获取数据，提供一个统一供子类调用的方法，方便统一处理显示loading和处理错误状态，提供widget状态设置和刷新widget状态的方法。
- ViewState：widget状态枚举类
- ProviderWidget：负责给widget创建viewmodel对象，关联viewmodel，提供一个初始化加载数据方法。
- CommonViewStateHelper：_针对widget状态为加载中，数据为空，数据加载失败做统一处理，并提供数据为空，数据加载失败的点击事件处理。_
- HttpProvider：单例对象，负责创建dio网络对象，添加通用请求头，请求参数，log日志拦截期。
- ApiManager：单例对象，负责获取HttpProvider对象，进而获取dio网络请求对象。

代码中用到的插件：

```dart
dio: ^3.0.8
provider: ^3.2.0
fluttertoast: ^3.0.1
```

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
    if (movieList == null || movieList.isEmpty) {
      model.isLoadMore = false;
      _loadMore = false;
    } else {
      model.isLoadMore = true;
      _loadMore = true;
      start += count;
      if (isRefresh) {
        this.movieData.clear();
      }
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



