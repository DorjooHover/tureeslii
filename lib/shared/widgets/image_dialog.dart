import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tureeslii/shared/index.dart';

class ImageDialogWidget extends StatelessWidget {
  const ImageDialogWidget({super.key, required this.path});
  final String path;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: origin),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      '$path',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                right: 16,
                top: MediaQuery.of(context).padding.top + large,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Get.back();
                  },
                ))
          ],
        ),
      ),
    );
  }
}
