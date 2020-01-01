class AppApi {

  /**
   * 正在热映接口
   * 参数：start 和 count
   */
  static String getNowPlayingList(){
    return 'in_theaters';
  }

  /**
   * 即将上映电影接口
   * 参数：start 和 count
   */
  static String getCommingSoon(){
    return 'coming_soon';
  }

  /**
   * 获取本周口碑榜电影
   */
  static String getWeeklyList(){
    return 'weekly';
  }

  /**
   * 获取新片榜电影
   */
  static String getNewMovies(){
    return 'new_movies';
  }

  /**
   * 获取北美票房榜电影
   */
  static String getUsBox(){
    return 'us_box';
  }

  /**
   *  获取 top250 榜单
   *  参数：start 和 count
   */
  static String getTop250(){
    return  'top250';
  }

  /**
   * 根据标签搜索
   * 参数：tag，start 和 count
   */
  static String searchByTag(){
    return 'search';
  }

  /**
   * 根据关键字搜索
   * 参数：key，start 和 count
   */
  static String searchByKey(){
    return 'search';
  }

  /**
   * 获取电影详情
   * 参数：movieId
   */
  static String getMovieDetail(){
    return 'subject';
  }

  /**
   * 获取影片剧照接口
   * movieId 电影id
   * 参数：start和count
   */
  static String getMovieStagePhoto(String movieId) {
    return 'subject/$movieId/photos';
  }

  /**
   * 演员详细信息
   * 参数actorId 演员id
   */
  static String getActorDetail(String actorId){
    return'celebrity/$actorId';
  }

  /**
   * 演员相册
   * 参数actorId 演员id
   */
  static String getActorPhotos(String actorId){
    return'celebrity/$actorId/photos';
  }
}
