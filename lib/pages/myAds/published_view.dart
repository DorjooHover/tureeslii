import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/controllers.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/pages/no_data.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class PublishedView extends StatefulWidget {
  const PublishedView({super.key, });

  @override
  State<PublishedView> createState() => _PublishedViewState();
}

class _PublishedViewState extends State<PublishedView> {
  final controller = Get.put(MainController());
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6 - 66,
          child: SingleChildScrollView(
            child: controller.ownPost.where((p0) => p0.status?.toLowerCase() == postStatus[0]).isNotEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ...controller.ownPost.where((p0) => p0.status?.toLowerCase() == postStatus[0]).map((e) {
                        final i = controller.ownPost.indexOf(e);
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: origin, vertical: 32),
                              child: MyAdsCard(
                                onPressed: () {
                                  Get.toNamed(Routes.rentRequest, arguments: e);
                                },
                                post: e,
                              ),
                            ),
                            i + 1 != controller.ownPost.where((p0) => p0.status?.toLowerCase() == postStatus[0]).length
                                ? const Divider(
                                    color: navGray,
                                    height: 2,
                                  )
                                : space32
                          ],
                        );
                      }).toList(),
                    ],
                  )
                : Center(
                    child: NoDataView(
                      height: MediaQuery.of(context).size.height * 0.6 - 66,
                    ),
                  ),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom + origin,
            child: Align(
              alignment: Alignment.center,
              child: MainButton(
                onPressed: () {
                  Get.toNamed(Routes.location);
                },
                borderRadius: 100,
                child: Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(Icons.add, color: prime)),
              ),
            ))
      ],
    );
  }
}
