import 'package:flutter/widgets.dart';
import 'package:posts_manager_api/controllers/apis/posts/post_api_controller.dart';

import '../../../models/posts/post_model.dart';


class PostApiProvider with ChangeNotifier {
  PostApiProvider() {
    getData();
  }

  List<PostModel> _list = [];
  List<PostModel> get getList => _list;

  PostApiController apiHelper = PostApiController();

  /// GET
  Future<void> getData() async {
    List<PostModel> data = await apiHelper.fetchData();
    _list.clear();
    _list.addAll(data);
    notifyListeners();
  }

  /// POST
  Future<void> addPost(PostModel post) async {
    PostModel newPost = await apiHelper.addPost(post);
    _list.add(newPost);
    notifyListeners();
  }

  /// PUT - full update
  Future<void> updatePost( PostModel post) async {
    PostModel updatedPost = await apiHelper.updatePost( post);


    int index = _list.indexWhere((e) => e.id == post.id);
    if (index != -1) {
      _list[index] = updatedPost;
      notifyListeners();
    }
    /// Or
    // for (int i = 0; i < _list.length; i++) {
    //   if (_list[i].id == id) {
    //     _list[i] = updatedPost;
    //     notifyListeners();
    //     break;
    //   }
  }

  /// PATCH - partial update
  Future<void> patchPost( Map<String, dynamic> data) async {
    PostModel patchedPost = await apiHelper.patchPost(data);

    int index = _list.indexWhere((e) => e.id ==  data['id']);
    if (index != -1) {
      _list[index] = patchedPost;
      notifyListeners();
    }

    /// or
    /// for (int i = 0; i < _list.length; i++) {
    ///   if (_list[i].id == id) {
    ///    _list[i] = updatedPost;
    ///     notifyListeners();
    ///     break;
    ///   }
  }

  /// DELETE
  Future<void> deletePost(int id) async {
    bool success = await apiHelper.deletePost(id);
    if (success) {
      _list.removeWhere((e) => e.id == id);
      notifyListeners();
    }
    ///OR
    /// for (int i = 0; i < _list.length; i++) {
    //   if (_list[i].id == id) {
    //     _list.removeAt(i);
    //     notifyListeners();
    //     break;
    //   }
    // }
  }

}
