import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class ListingView extends StatefulWidget {
  const ListingView({super.key});

  @override
  State<ListingView> createState() => _ListingViewState();
}

class _ListingViewState extends State<ListingView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          space40,
          Image.asset(
            imageError,
            width: MediaQuery.of(context).size.width * 0.44,
          ),
          space24,
          Text(
            hello,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontWeight: FontWeight.w700, color: black),
          ),
          space24,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Text(slogan,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: black, fontWeight: FontWeight.w400)),
          ),
          space36,
          MainButton(
            padding:
                const EdgeInsets.only(top: 13, bottom: 13, left: 12, right: 30),
            borderRadius: 26,
            onPressed: () {
              Get.toNamed(Routes.location);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(
                  Icons.add_circle,
                  color: Colors.white,
                ),
                space16,
                space2,
                Text(
                  adAdd,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
