import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/auth_controller.dart';
import 'package:tureeslii/routes.dart';
import 'package:tureeslii/shared/constants/assets.dart';
import 'package:tureeslii/shared/constants/colors.dart';
import 'package:tureeslii/shared/constants/spacing.dart';
import 'package:tureeslii/shared/constants/strings.dart';
import 'package:tureeslii/shared/constants/values.dart';

class AuthView extends StatelessWidget {
  AuthView({super.key});
  final AuthController controller = Get.find();
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
                child: Image.network(
                  'https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  child: Container(
                color: Colors.black.withOpacity(0.8),
              )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
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
                                .copyWith(color: orange),
                          ),
                          space8,
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: orange,
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
                      ...cities
                          .map((e) => GestureDetector(
                                onTap: () {
                                  controller.city.value = e;
                         
                                  Get.toNamed(Routes.login);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: origin),
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(e,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                ),
                              ))
                          .toList(),
                      space8,
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
