import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/auth_controller.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/routes.dart';
import 'package:tureeslii/shared/index.dart';

class AuthView extends StatelessWidget {
  AuthView({super.key});
  final AuthController controller = Get.find();
  final mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: MediaQuery.of(context).padding.bottom),
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  bottom: 0,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                         Center(child: SizedBox(child: CircularProgressIndicator(),),), // Placeholder widget while loading
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error), // Widget to display on error
                  )),
              Positioned(
                  child: Container(
                color: Colors.black.withOpacity(0.8),
              )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.login);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            login,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                          space8,
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 24,
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(origin),
                                  topRight: Radius.circular(origin)),
                              color: Colors.white),
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Obx(
                            () => RowRadio(
                              border: const Border(),
                              groupValue: mainController.timeType.value,
                              onChanged: (value) {
                                if (value != null) {
                                  mainController.timeType.value = value;
                                }
                              },
                              list: const [byMonth, byDay],
                            ),
                          )),
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(GestureDetector(
                            child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(20.0),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  space24,
                                  Container(
                                    width: 50,
                                    height: 4,
                                    decoration: BoxDecoration(
                                        color: prime,
                                        borderRadius:
                                            BorderRadius.circular(2.5)),
                                  ),
                                  space32,
                                  ...cities
                                      .map(
                                        (e) => GestureDetector(
                                          onTap: () {
                                            mainController.city.value = e;
                                            Navigator.pop(context);
                                            Get.toNamed(Routes.main);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Color(
                                                            0xffEFEFEF)))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 18),
                                                  child: Text(e,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium!
                                                          .copyWith(
                                                              color: black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: prime,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9)),
                                                  alignment: Alignment.center,
                                                  width: 35,
                                                  child: Text(
                                                    '2',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  space64
                                ],
                              ),
                            ),
                          ));
                        },
                        child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: origin),
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Obx(
                              () => Text(mainController.city.value,
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                            )),
                      ),
                      space16,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: origin),
                        child: Text(
                          chooseYourCity,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: huge),
                    child: Image.asset(
                      // imageAppBarText,
                      imageLogoTextWhite,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
