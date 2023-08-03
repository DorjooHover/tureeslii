import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/shared/index.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _HomeViewState();
}

class _HomeViewState extends State<BookmarkView> {
  List<Post> posts = [];
  @override
  void initState() {
    super.initState();
    getSavedPost();
  }

  final mainController = Get.put(MainController());
  getSavedPost() async {
    List<Post> res = await mainController.getSavedPost();

    if (mounted) {
      setState(() {
        posts = res;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: origin, vertical: 24),
      child: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(
            vertical: origin,
          ),
          child: BookmarkCard(
            data: posts[index],
            onBookmark: () {
              mainController.togglePost(id: posts[index].id!);
              getSavedPost();
              setState(() {
                posts.removeWhere((post) => post.id == posts[index].id);
              });
            },
          ),
        ),
        itemCount: posts.length,
      ),
    );
  }
}
