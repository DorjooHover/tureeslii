import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/pages/location/item_detail_view.dart';
import 'package:tureeslii/pages/no_data.dart';
import 'package:tureeslii/routes.dart';
import 'package:tureeslii/shared/index.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _HomeViewState();
}

class _HomeViewState extends State<BookmarkView> {
  @override
  void initState() {
    super.initState();
    getSavedPost();
  }

  final mainController = Get.put(MainController());
  getSavedPost() async {
    await mainController.getSavedPost();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: origin, vertical: 24),
        child: Obx(
          () => mainController.user != null
              ? mainController.savedPosts.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: origin,
                        ),
                        child: BookmarkCard(
                          onPress: () {
                            Get.to(
                                () => ItemDetailView(
                                      data: mainController.savedPosts[index],
                                    ),
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                          data: mainController.savedPosts[index],
                          active: true,
                          onBookmark: () {
                            if (mainController.user != null) {
                              mainController.togglePost(
                                  id: mainController.savedPosts[index].id!);
                            } else {
                              Get.toNamed(Routes.login);
                            }
                          },
                        ),
                      ),
                      itemCount: mainController.savedPosts.length,
                    )
                  : const Center(child: NoDataView())
              : Center(
                  child: MainButton(
                      onPressed: () {
                        Get.toNamed(Routes.login);
                      },
                      text: login),
                ),
        ));
  }
}
