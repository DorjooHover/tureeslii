import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/shared/index.dart';

class BookmarkCard extends StatefulWidget {
  const BookmarkCard(
      {super.key,
      required this.data,
      this.active = false,
      required this.onBookmark,
      this.onPress});
  final Post data;
  final bool active;
  final Function()? onPress;
  final Function() onBookmark;
  @override
  State<BookmarkCard> createState() => _BookmarkCardState();
}

class _BookmarkCardState extends State<BookmarkCard> {
  int selectedIndex = 0;

  final CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CarouselSlider(
                carouselController: carouselController,
                options: CarouselOptions(
                  height: 263.0,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
                items: widget.data.postAttachments?.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () async {
                          await showDialog(
                              barrierDismissible: false,
                              barrierColor: Colors.white.withOpacity(0.9),
                              context: context,
                              builder: (context) => ImageDialogWidget(
                                    path: '$fileUrl${item.fileThumb}',
                                  ));
                        },
                        child: SizedBox(
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
                                        borderRadius:
                                            BorderRadius.circular(origin),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            blurRadius: 4,
                                            spreadRadius: 0.25,
                                            offset: const Offset(
                                                0, 4), // Shadow position
                                          ),
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            blurRadius: 4,
                                            spreadRadius: 0.25,
                                            offset: const Offset(0, 0),
                                          )
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
                                            ), // Placeholder widget while loading
                                            errorWidget: (context, url,
                                                    error) =>
                                                Icon(Icons
                                                    .error), // Widget to display on error
                                          )))),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Positioned(
                  top: origin,
                  right: origin,
                  child: GestureDetector(
                    onTap: widget.onBookmark,
                    child: SvgPicture.asset(
                        widget.active ? iconHeartActive : iconHeartWhite),
                  )),
              Positioned(
                bottom: small,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.data.postAttachments?.map((e) {
                        final index = widget.data.postAttachments?.indexOf(e);
                        return GestureDetector(
                            onTap: () =>
                                carouselController.animateToPage(index!),
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
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
                  bottom: 0,
                  right: origin,
                  child: Row(
                    children: [
                      ItemCard(
                          icon: iconRoom,
                          value: '${widget.data.roomCount ?? 0}'),
                      space13,
                      ItemCard(
                          icon: iconBed, value: '${widget.data.bedroom ?? 0}'),
                      space13,
                      ItemCard(
                          icon: iconBath,
                          value: '${widget.data.bathroom ?? 0}'),
                    ],
                  )),
            ],
          ),
          space16,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text:
                      '${currencyFormat(widget.data.monthlyRent! ? widget.data.price ?? 0.0 : widget.data.priceDaily ?? 0.0, false)} ',
                  style: Theme.of(context).textTheme.titleLarge,
                  children: <TextSpan>[
                    TextSpan(
                        text: '₮/${widget.data.monthlyRent! ? 'сар' : 'өдөр'}',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: gray, fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              Text(
                  DateFormat('yyyy.MM.dd')
                      .format(DateTime.parse(widget.data.startDate!)),
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: gray, fontWeight: FontWeight.w400))
            ],
          ),
          space8,
          Text(
            widget.data.title ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          space16
        ],
      ),
    );
  }
}
