import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/shared/index.dart';

class ItemDetailCard extends StatefulWidget {
  const ItemDetailCard({super.key, required this.data});
  final Post data;
  @override
  State<ItemDetailCard> createState() => _ItemDetailCardState();
}

class _ItemDetailCardState extends State<ItemDetailCard> {
  int selectedIndex = 0;
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();

    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                height: 430.0,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              items: widget.data.postAttachments?.map((PostAttachments item) {
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
                              bottom: 15,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(origin),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 4,
                                        spreadRadius: 0.25,
                                        offset: const Offset(
                                            0, 4), // Shadow position
                                      ),
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 4,
                                        spreadRadius: 0.25,
                                        offset: const Offset(0, 0),
                                      )
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(origin),
                                    child: Image.network(
                                      '$fileUrl${item.fileThumb}',
                                      fit: BoxFit.cover,
                                    ),
                                  ))),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Positioned(
              bottom: origin,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.data.postAttachments?.map((PostAttachments e) {
                      final index = widget.data.postAttachments?.indexOf(e);
                      return GestureDetector(
                          onTap: () => carouselController.animateToPage(index!),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white),
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                          ));
                    }).toList() ??
                    [],
              ),
            ),
            Positioned(
                top: 36,
                right: origin,
                child: Column(
                  children: [
                    ItemGlassCard(
                      icon: iconHeartWhite,
                      value: '',
                      row: false,
                    ),
                    space10,
                    ItemGlassCard(
                      icon: iconVerifiedWhite,
                      value: '',
                      row: false,
                      color: orange,
                    ),
                    space10,
                    ItemGlassCard(
                        icon: iconRoom,
                        value: widget.data.roomCount.toString()),
                    space10,
                    ItemGlassCard(
                        icon: iconBed, value: widget.data.bedroom.toString()),
                    space10,
                    ItemGlassCard(
                        icon: iconBath, value: widget.data.bathroom.toString()),
                  ],
                )),
            Positioned(
              bottom: 36,
              left: 20,
              child: RichText(
                text: TextSpan(
                  text: '${currencyFormat(widget.data.price!, false)} ',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                  children: <TextSpan>[
                    TextSpan(
                        text: '₮/сар',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            )
          ],
        ),
        space16,
        SizedBox(
          width: double.infinity,
          child: Text(
            widget.data.title!,
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: prime, fontWeight: FontWeight.bold),
          ),
        ),
        if (widget.data.description != "" && widget.data.description != null)
          space24,
        Text(
          widget.data.description ?? "",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: black),
        )
      ],
    );
  }
}
