import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/controllers.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/routes.dart';
import 'package:tureeslii/shared/index.dart';
import 'package:url_launcher/url_launcher.dart';

class QPayView extends StatelessWidget {
  const QPayView(
      {super.key,
      required this.price,
      required this.qpay,
      required this.invoiceId});
  final double price;
  final String invoiceId;
  final QPay qpay;
  @override
  Widget build(BuildContext context) {
    CustomSnackbar snackbar = CustomSnackbar();
    final controller = Get.put(MainController());
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: bgGray,
          statusBarIconBrightness:
              Brightness.dark, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness:
              Brightness.light, //<-- For iOS SEE HERE (dark icons)
        ),
        actions: [Container()],
        leading: SizedBox(),
        toolbarHeight: 63,
        elevation: 0,
        leadingWidth: 0,
        backgroundColor: bgGray,
        titleSpacing: 0,
        title: Container(
          margin: const EdgeInsets.only(left: origin),
          alignment: Alignment.centerLeft,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: const EdgeInsets.all(origin),
                backgroundColor: Colors.white,
                shape: const CircleBorder()),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: gray,
              size: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      backgroundColor: bgGray,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding:
            const EdgeInsets.symmetric(horizontal: origin, vertical: large),
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          payValue,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold, color: black),
                        ),
                        Text(
                          "${currencyFormat(price, true)}₮",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: prime, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                space32,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: origin),
                  height: MediaQuery.of(context).size.height / 2 + 50,
                  width: double.infinity,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).size.width > 650
                                ? 150
                                : MediaQuery.of(context).size.width / 500 * 100,
                        childAspectRatio: 1,
                        crossAxisSpacing: 40,
                        mainAxisSpacing: 40),
                    itemCount: qpay.urls?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          final Uri url =
                              Uri.parse(qpay.urls![index].link.toString());
                          try {
                            await launchUrl(url);
                          } catch (e) {
                            snackbar.mainSnackbar(
                                context,
                                'Та ${qpay.urls![index].name} апп-аа татна уу',
                                SnackBarTypes.warning);
                            // Uri store = Uri.parse(
                            //   Platform.isAndroid
                            //       ? "market://details?id=${qpay.urls![index].link?.split(':')[0]}"
                            //       : "https://apps.apple.com/app/id${qpay.urls![index].link?.split(':')[0]}",
                            // );
                            // await launchUrl(store);
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: qpay.urls![index].logo.toString(),
                            placeholder: (context, url) => Center(
                              child: SizedBox(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            Positioned(
                bottom: MediaQuery.of(context).padding.bottom,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    MainButton(
                      width:
                          (MediaQuery.of(context).size.width - large - origin) /
                              2,
                      color: Color(0xffEBEBEB),
                      contentColor: Color(0xff727272),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: back,
                    ),
                    space16,
                    MainButton(
                      width:
                          (MediaQuery.of(context).size.width - large - origin) /
                              2,
                      onPressed: () async {
                        await controller
                            .checkPayment(invoiceId)
                            .then((value) => {
                                  if (value)
                                    {Get.toNamed(Routes.main)}
                                  else
                                    {
                                      snackbar.mainSnackbar(
                                          context,
                                          "Төлбөр төлөгдөөгүй байна",
                                          SnackBarTypes.warning)
                                    }
                                });
                      },
                      text: checkPayment,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
