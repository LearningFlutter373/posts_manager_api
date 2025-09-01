import 'package:flutter/material.dart';
import 'package:posts_manager_api/controllers/apis/posts/post_api_provider.dart';
import 'package:posts_manager_api/views/screens/apis/post_add_screen.dart';
import 'package:posts_manager_api/views/screens/apis/post_update_with_patch_screen.dart';
import 'package:posts_manager_api/views/screens/apis/post_update_with_put_screen.dart';
import 'package:provider/provider.dart';



class PostViewScreen extends StatelessWidget {
  const PostViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostApiProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: Consumer<PostApiProvider>(
        builder: (context, value, child) {
          if (value.getList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          var data = value.getList;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var post = data[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text("${post.title}"),
                  subtitle: Text(post.body ?? ""),
                  trailing: PopupMenuButton<String>(
                    onSelected: (choice) async {
                      if (choice == "edit") {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PostUpdateWithPatchScreen(post: post,),));
                      } else if (choice == "update") {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PostUpdateWithPutScreen(post: post,)));
                      } else if (choice == "delete") {
                        await provider.deletePost(post.id!);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Post deleted successfully")));

                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: "edit",
                        child: Text("Patch Update"),
                      ),
                      const PopupMenuItem(
                        value: "update",
                        child: Text("Put Update"),
                      ),
                      const PopupMenuItem(
                        value: "delete",
                        child: Text("Delete"),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PostAddScreen(),));
      },child: Icon(Icons.add),),
    );
  }
}
