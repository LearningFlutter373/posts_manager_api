import 'package:flutter/material.dart';
import 'package:posts_manager_api/controllers/apis/posts/post_api_provider.dart';
import 'package:provider/provider.dart';
import '../../../models/posts/post_model.dart';

class PostUpdateWithPatchScreen extends StatefulWidget {
  final PostModel? post;

  const PostUpdateWithPatchScreen({super.key, this.post});

  @override
  State<PostUpdateWithPatchScreen> createState() => _PostUpdateWithPatchScreenState();
}

class _PostUpdateWithPatchScreenState extends State<PostUpdateWithPatchScreen> {
  late TextEditingController titleController;
  late TextEditingController bodyController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.post?.title ?? "");
    bodyController = TextEditingController(text: widget.post?.body ?? "");
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostApiProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Post (PATCH)"),
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
              onPressed: () async {
                if (titleController.text.isNotEmpty &&
                    bodyController.text.isNotEmpty) {

                  final updatedPost = PostModel(
                    id: widget.post!.id,
                    title: titleController.text,
                    body: bodyController.text,
                  );
                  await provider.patchPost({});

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Post Updated!")),
                  );

                  Navigator.pop(context); // back after success
                }
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
