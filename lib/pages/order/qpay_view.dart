import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/controllers.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/shared/index.dart';
import 'package:url_launcher/url_launcher.dart';

class QPayView extends StatelessWidget {
  const QPayView({super.key, required this.data});
  final RentRequest data;
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
      body: Padding(
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
                          "${currencyFormat(data.totalPrice!.toDouble(), true)}₮",
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
                    itemCount: bankValues.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          final Uri url =
                              Uri.parse(bankValues[index]["url"].toString());

                          if (!await launchUrl(url)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            bankValues[index]["img"].toString(),
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
                        bool res =
                            await controller.checkPayment(data.qpayInvoiceId!);
                        if (res) {
                          Navigator.pop(context);
                        } else {
                          snackbar.mainSnackbar(
                              context,
                              "Төлбөр төлөгдөөгүй байна",
                              SnackBarTypes.warning);
                        }
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
