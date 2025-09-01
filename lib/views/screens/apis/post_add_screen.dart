import 'package:flutter/material.dart';
import 'package:posts_manager_api/controllers/apis/posts/post_api_provider.dart';
import 'package:provider/provider.dart';
import '../../../models/posts/post_model.dart';


class PostAddScreen extends StatelessWidget {
  PostAddScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostApiProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bodyController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Body",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    bodyController.text.isNotEmpty) {
                  final newPost = PostModel(
                    userId: 1,
                    title: titleController.text,
                    body: bodyController.text,
                  );

                  provider.addPost(newPost).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Post Added!")),
                    );
                    Navigator.pop(context);
                  });
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
