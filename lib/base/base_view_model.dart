import 'package:flutter_movie/base/base_repository.dart';

abstract class BaseViewModel<T extends BaseRepository> {
  T mRepository;

  BaseViewModel() {
    mRepository = createRepository();
  }

  Future<dynamic> get(String path, Map<String, dynamic> params) {
    if (mRepository == null) {
      return null;
    }
    return mRepository.get(path, params: params);
  }

  Future<dynamic> post(String path, Map<String, dynamic> params) {
    if (mRepository == null) {
      return null;
    }
    return mRepository.post(path, params);
  }

  T createRepository();

  void dispose();
}
