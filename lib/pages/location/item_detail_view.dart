import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/shared/index.dart';

class ItemDetailView extends StatelessWidget {
  const ItemDetailView({super.key, required this.data});
  final Post data;

  @override
  Widget build(BuildContext context) {
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
        leading: const SizedBox(),
        toolbarHeight: 0,
        elevation: 0,
      ),
      backgroundColor: bgGray,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: origin, vertical: 24),
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  ItemDetailCard(
                    data: data,
                  ),
                  space36,
                  space4,
                  const MenuContainer(child: CalendarCard()),
                  space36,
                  space4,
                  MoreDetailCard(
                    data:data            
                  ),
                  space20
                ],
              ),
            ),
            Positioned(
                top: 32,
                left: 24,
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
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertContainer(
                  horizontal: 0,
                  padding: const EdgeInsets.symmetric(horizontal: origin),
                  child: [
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: AdditionCard(
                                color: black,
                                title: startRentDate,
                                child: const Input()),
                          ),
                          space4,
                          space2,
                          Text('-',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: black)),
                          space4,
                          space2,
                          Flexible(
                            child: AdditionCard(
                                color: black,
                                title: startEndDate,
                                child: Input()),
                          ),
                        ],
                      ),
                    ),
                    space20,
                    MenuContainer(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(time,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: black)),
                            Text('2 сар 1 өдөр',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: black,
                                        fontWeight: FontWeight.bold)),
                          ],
                        ),
                        space20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(payment,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: black)),
                            Text('${currencyFormat(data.price!, true)}₮',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: prime,
                                        fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    )),
                    space32,
                    MainButton(
                      onPressed: () async{
                        await controller.rentRequest(data.id!, DateTime.now().millisecondsSinceEpoch, 30, 'monthly');
                        Navigator.pop(context);
                      },
                      width: double.infinity,
                      text: request,
                    ),
                    space64,
                  ],
                );
              });
        },
        child: Container(
          padding: const EdgeInsets.all(origin),
          decoration: BoxDecoration(
              color: prime,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4,

                  offset: const Offset(4, 4), // Shadow position
                )
              ]),
          child: SvgPicture.asset(iconSend),
          // child: SvgPicture.asset(iconSend),
        ),
      ),
    );
  }
}
