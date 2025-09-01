import 'package:flutter/material.dart';
import 'package:posts_manager_api/controllers/apis/posts/post_api_provider.dart';
import 'package:posts_manager_api/views/screens/apis/post_view_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider<PostApiProvider>(
      create: (context) => PostApiProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PostViewScreen(),
    );
  }
}
