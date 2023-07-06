import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  bool view = true;

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding:
              const EdgeInsets.symmetric(vertical: small, horizontal: origin),
          child: Column(
            children: <Widget>[
              MenuCard(
                icon: iconPerson,
                text: personInfo,
                child: InkWell(
                  onTap: () => Get.toNamed(Routes.profile),
                  child: Text(
                    login,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: gray),
                  ),
                ),
              ),
              MenuCard(
                  icon: iconLocation,
                  text: changeCity,
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.changeCity),
                    child: Text(
                      'Дархан',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: gray),
                    ),
                  )),
              MenuCard(
                  icon: iconHelp,
                  text: help,
                  child: IconButton(
                    icon: SvgPicture.asset(view ? iconArrowUp : iconArrowDown),
                    onPressed: () {
                      setState(() {
                        view = !view;
                      });
                    },
                  )),
              view
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        space16,
                        ...menuHelp.map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(
                                left: 85, top: 10, bottom: 10),
                            child: InkWell(
                              onTap: () => launchUrl(Uri.parse(e['url']!)),
                              child: Text(e['text']!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: black,
                                          fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        space16,
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: line, width: 1))),
                        ),
                        space8,
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 85, top: 10, bottom: 10),
                          child: InkWell(
                            onTap: () => Get.toNamed(Routes.error),
                            child: Text('Error page',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: black,
                                        fontWeight: FontWeight.bold)),
                          ),
                        ),
                        space4,
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 85, top: 10, bottom: 10),
                          child: InkWell(
                            onTap: () => Get.toNamed(Routes.page404),
                            child: Text('404 page',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: black,
                                        fontWeight: FontWeight.bold)),
                          ),
                        ),
                        space4,
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 85, top: 10, bottom: 10),
                          child: InkWell(
                            onTap: () => Get.toNamed(Routes.noData),
                            child: Text('Page with no data',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: black,
                                        fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox()
            ],
          )),
    );
  }
}
