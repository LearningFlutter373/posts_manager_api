import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/posts/post_model.dart';

class PostApiController {
  String apiUrl = "https://jsonplaceholder.typicode.com/posts";

  /// GET - fetch posts
  Future<List<PostModel>> fetchData() async {
    var res = await http.get(Uri.parse(apiUrl));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body) as List;
      return data.map((e) => PostModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  /// POST - add new post
  Future<PostModel> addPost(PostModel post) async {
    var res = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toJson()),
    );

    if (res.statusCode == 201) {
      return PostModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception( "Failed to add post: ${res.statusCode}");
      // or
      // return PostModel();
    }
  }

  /// PUT - update full post
  Future<PostModel> updatePost( PostModel post) async {
    var res = await http.put(
      Uri.parse("$apiUrl/${post.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toJson()),
    );

    if (res.statusCode == 200) {
      return PostModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to update post: ${res.statusCode}");
      // or
      // return PostModel();
    }
  }

  /// PATCH - update partially
  Future<PostModel> patchPost( Map<String, dynamic> data) async {
    var res = await http.patch(
      Uri.parse("$apiUrl/${data['id']}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (res.statusCode == 200) {
      return PostModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to patch post: ${res.statusCode}");
      // or
      // return PostModel();

    }
  }

  /// DELETE - remove post
  Future<bool> deletePost(int id) async {
    var res = await http.delete(Uri.parse("$apiUrl/$id"));
    if(res.statusCode==200 || res.statusCode==204){
      return true;
    }
    return false;
  }
}
