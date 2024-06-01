import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:landlord/shared/index.dart';

class OrderAcceptedView extends StatefulWidget {
  const OrderAcceptedView({super.key});

  @override
  State<OrderAcceptedView> createState() => _OrderAcceptedViewState();
}

class _OrderAcceptedViewState extends State<OrderAcceptedView> {
  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();
    List<int> list = [1, 2, 3, 4, 5];
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgGray,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + origin,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: origin),
                  child: Column(
                    children: <Widget>[
                      CarouselSlider(
                        carouselController: carouselController,
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.5,
                            viewportFraction: 1),
                        items: list.map((item) {
                          final i = list.indexOf(item);
                          return Builder(
                            builder: (BuildContext context) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        left: 0,
                                        right: 0,
                                        top: 0,
                                        bottom: 0,
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(origin),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  blurRadius: 4,
                                                  spreadRadius: 0.25,
                                                  offset: const Offset(
                                                      0, 4), // Shadow position
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(origin),
                                              child: Image.network(
                                                'https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                                                fit: BoxFit.cover,
                                              ),
                                            ))),
                                    Positioned(
                                      bottom: small,
                                      left: 0,
                                      right: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: list.map((e) {
                                          final index = list.indexOf(e);
                                          return GestureDetector(
                                              onTap: () => carouselController
                                                  .animateToPage(i),
                                              child: Container(
                                                width: 9.0,
                                                height: 9.0,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 3.0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  color: i == index
                                                      ? Colors.white
                                                      : Colors.transparent,
                                                ),
                                              ));
                                        }).toList(),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 35,
                                      left: 26,
                                      child: RichText(
                                        text: TextSpan(
                                          text:
                                              '${currencyFormat(1250000, false)} ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: '₮/сар',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      space36,
                      Text('2 өрөө бүрэн тавилгатай дулаан байр түрээслэнэ.',
                          style: Theme.of(context).textTheme.titleLarge),
                      space16,
                      Text(
                        'Усны эх байгалын сайханд байрлах 2 өрөө байрыг урт хугацаагаар Монгол хүнд түрээслүүлнэ. Гэр бүл бол давуу тал болно.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: black),
                      ),
                      space36,
                    ],
                  ),
                ),
                Positioned(
                    top: large,
                    left: origin,
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
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom + 49 + 56,
                  left: origin,
                  right: origin,
                  child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 22, bottom: origin),
                      decoration: BoxDecoration(
                          color: orange,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(11),
                              topRight: Radius.circular(11))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            time,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '3 $month ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                              children: <TextSpan>[
                                TextSpan(text: '1 $day'),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 34,
                        top: 15,
                        left: origin,
                        right: origin),
                    child: MainButton(
                      onPressed: () {},
                      text: 'Нүүж орох',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
