import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: origin, right: origin, top: large, bottom: large),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: Image.asset(
                imageNoData,
                fit: BoxFit.contain,
              ),
            ),
            space16,
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                noDataText,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: black),
              ),
            ),
            space16,
            Align(
              alignment: Alignment.center,
              child: MainButton(
                onPressed: () {
                  Get.toNamed(Routes.location);
                },
                borderRadius: 100,
                child: Container(
                   
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: const Icon(Icons.add, color: prime)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
