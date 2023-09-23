import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/routes.dart';
import 'package:tureeslii/shared/index.dart';

class OrderAcceptedView extends StatefulWidget {
  const OrderAcceptedView({super.key, required this.data});
  final RentRequest data;
  @override
  State<OrderAcceptedView> createState() => _OrderAcceptedViewState();
}

class _OrderAcceptedViewState extends State<OrderAcceptedView> {
  double finalPrice = 0.0;
  RentRequest data = RentRequest();
  @override
  void initState() {
    super.initState();
    setState(() {
      data = widget.data;
    });
    int duration = widget.data.duration! > 30
        ? widget.data.duration! ~/ 30
        : widget.data.duration!;
    double fee = widget.data.fee!.toDouble();
    double total = (widget.data.price! * duration).toDouble();
    setState(() {
      finalPrice = total + fee;
    });
  }

  final CarouselController carouselController = CarouselController();

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGray,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + origin,
        ),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(
                  left: origin, right: origin, bottom: large),
              margin: EdgeInsets.only(
                  bottom: 80 + MediaQuery.of(context).padding.bottom),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        CarouselSlider(
                          carouselController: carouselController,
                          options: CarouselOptions(
                              onPageChanged: (index, reason) {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              height: MediaQuery.of(context).size.height * 0.5,
                              viewportFraction: 1),
                          items: widget.data.post!.postAttachments!.map((item) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () async {
                                    await showDialog(
                                        barrierDismissible: false,
                                        barrierColor:
                                            Colors.white.withOpacity(0.9),
                                        context: context,
                                        builder: (context) => ImageDialogWidget(
                                              path: '$fileUrl${item.fileThumb}',
                                            ));
                                  },
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
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
                                              child: CachedNetworkImage(
                                                imageUrl: item.fileThumb != null
                                                    ? '$fileUrl${item.fileThumb}'
                                                    : 'https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child: SizedBox(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Icon(Icons
                                                        .error), // Widget to display on error
                                              )))),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        Positioned(
                          bottom: small,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: Iterable<int>.generate(
                                    widget.data.post!.postAttachments?.length ??
                                        0)
                                .map((e) {
                              return GestureDetector(
                                  onTap: () {
                                    carouselController.animateToPage(e);
                                    setState(() {
                                      selectedIndex = e;
                                    });
                                  },
                                  child: Container(
                                    width: 9.0,
                                    height: 9.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 3.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white),
                                      color: selectedIndex == e
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
                                  '${currencyFormat(widget.data.price?.toDouble() ?? 0.0, false)} ',
                              style: Theme.of(context).textTheme.displaySmall,
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        '₮/${widget.data.post!.monthlyRent! ? 'сар' : 'өдөр'}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    space36,
                    Text(widget.data.post!.title ?? '',
                        style: Theme.of(context).textTheme.titleLarge),
                    space16,
                    if (widget.data.post!.description != "" &&
                        widget.data.post!.description != null)
                      Text(
                        widget.data.post!.description ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: black),
                      ),
                    Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 22, bottom: origin),
                        decoration: BoxDecoration(
                            color: data.paidDate != null ? green : orange,
                            borderRadius: BorderRadius.circular(11)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
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
                                    text: widget.data.duration! > 0
                                        ? "${widget.data.duration! ~/ 30} $month "
                                        : '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: widget.data.duration! % 30 > 0
                                            ? "${widget.data.duration! % 30} $day "
                                            : '',
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            space16,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  widget.data.startDate!
                                      .substring(0, 10)
                                      .replaceAll('-', '.'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                Expanded(
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: small),
                                    width: double.infinity,
                                    height: 1,
                                    color: Colors.white,
                                    alignment: Alignment.center,
                                  ),
                                ),
                                Text(
                                  widget.data.endDate!
                                      .substring(0, 10)
                                      .replaceAll('-', '.'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            if (data.paidDate == null) space32,
                            if (data.paidDate == null)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    payment,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${currencyFormat(widget.data.totalPrice!.toDouble(), true)}₮",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                  )
                                ],
                              ),
                            space24,
                            Flexible(
                                child: MainButton(
                              onPressed: () {
                                Get.toNamed(Routes.qpay,
                                    arguments: widget.data);
                              },
                              width: double.infinity,
                              color: Colors.white,
                              contentColor: orange,
                              child: Text(
                                pay,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: orange,
                                        fontWeight: FontWeight.w400),
                              ),
                            ))
                          ],
                        )),
                    // space32,
                    // Container(
                    //   width: double.infinity,
                    //   padding: EdgeInsets.symmetric(
                    //       vertical: origin, horizontal: 20),
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(11),
                    //       boxShadow: [
                    //         BoxShadow(
                    //             blurRadius: 15,
                    //             spreadRadius: 0,
                    //             offset: Offset(4, 0),
                    //             color: Colors.black.withOpacity(0.1)),
                    //         BoxShadow(
                    //             blurRadius: 15,
                    //             spreadRadius: 0,
                    //             offset: Offset(0, 0),
                    //             color: Colors.black.withOpacity(0.1))
                    //       ]),
                    //   child: Column(
                    //     children: <Widget>[
                    //       Text(
                    //         landlord,
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .headlineSmall!
                    //             .copyWith(
                    //                 color: Color(0xff9C9C9C),
                    //                 fontWeight: FontWeight.bold),
                    //       ),
                    //       space10,
                    //       // Row(
                    //       //   children: <Widget>[
                    //       //     ClipRRect(
                    //       //       borderRadius: BorderRadius.circular(100),
                    //       //       child: CachedNetworkImage(
                    //       //           width: 70,
                    //       //           height: 70,
                    //       //           fit: BoxFit.cover,
                    //       //           imageUrl: widget.data.user!.profilePic != ""
                    //       //               ? "$fileUrl${widget.data.user!.profilePic}"
                    //       //               : "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1972&q=80"),
                    //       //     ),
                    //       //     space20,
                    //       //     Column(
                    //       //       mainAxisSize: MainAxisSize.min,
                    //       //       children: <Widget>[
                    //       //         Text(widget.data.user!.firstname!)
                    //       //       ],
                    //       //     )
                    //       //   ],
                    //       // )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            if (data.paidDate == null)
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
            if (data.paidDate == null)
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
                    onPressed: () {
                      Get.toNamed(Routes.qpay, arguments: widget.data);
                    },
                    text: 'Нүүж орох',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
