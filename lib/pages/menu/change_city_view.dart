import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/main_controller.dart';
import 'package:landlord/shared/constants/assets.dart';
import 'package:landlord/shared/constants/colors.dart';
import 'package:landlord/shared/constants/spacing.dart';
import 'package:landlord/shared/constants/strings.dart';

class ChangeCityView extends StatefulWidget {
  const ChangeCityView({super.key});

  @override
  State<ChangeCityView> createState() => _ChangeCityViewState();
}

class _ChangeCityViewState extends State<ChangeCityView> {
  final controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
              ),
              fit: BoxFit.cover,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: MediaQuery.of(context).padding.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: large),
                alignment: Alignment.topLeft,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.all(small),
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
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    city,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: gray),
                  ),
                  space16,
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.1,
                        left: 30,
                        right: 30),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 13),
                    child: DropdownButton(
                        icon: const Icon(Icons.search),
                        iconEnabledColor: gray,
                        isExpanded: true,
                        dropdownColor: Colors.white,
                        value: controller.cities[1],
                        underline: const SizedBox(),
                        items: controller.cities.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: black),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {}),
                  ),
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
          )),
    );
  }
}
