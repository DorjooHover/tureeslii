import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/controllers.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/pages/no_data.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class EnteredView extends StatefulWidget {
  const EnteredView({
    super.key,
  });

  @override
  State<EnteredView> createState() => _EnteredViewState();
}

class _EnteredViewState extends State<EnteredView> {
  final controller = Get.put(MainController());
  List<Post> posts = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      posts = controller.ownPost
          .where((p0) => p0.status?.toLowerCase() != postStatus[0])
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: posts.isNotEmpty
          ? ListView.builder(
              itemCount: posts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: origin, vertical: 32),
                      child: MyAdsCard(
                        onPressed: () {
                          Get.toNamed(Routes.rentRequest,
                              arguments: posts[index]);
                        },
                        post: posts[index],
                      ),
                    ),
                    index + 1 != posts.length
                        ? const Divider(
                            color: navGray,
                            height: 2,
                          )
                        : space32
                  ],
                );
              })
          : const Center(
              child: NoDataView(),
            ),
    );
  }
}
