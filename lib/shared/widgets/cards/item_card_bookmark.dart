import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/shared/index.dart';

class BookmarkCard extends StatelessWidget {
  const BookmarkCard({super.key, required this.data});
  final Apartment data;
  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5];
    CarouselController carouselController = CarouselController();

    return Column(
      children: [
        CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(height: 263.0, viewportFraction: 1),
          items: list.map((item) {
            final i = list.indexOf(item);
            return Builder(
              builder: (BuildContext context) {
                return Container(
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
                                    offset:
                                        const Offset(0, 4), // Shadow position
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
                                  'https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                                  fit: BoxFit.cover,
                                ),
                              ))),
                      Positioned(
                          top: origin,
                          right: origin,
                          child: SvgPicture.asset(iconHeartActive)),
                      Positioned(
                        bottom: small,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: list.map((e) {
                            final index = list.indexOf(e);
                            return GestureDetector(
                                onTap: () =>
                                    carouselController.animateToPage(i),
                                child: Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white),
                                    color: i == index
                                        ? Colors.white
                                        : Colors.transparent,
                                  ),
                                ));
                          }).toList(),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: origin,
                          child: Row(
                            children: [
                              ItemCard(icon: iconRoom, value: '1'),
                              space13,
                              ItemCard(icon: iconBed, value: '1'),
                              space13,
                              ItemCard(icon: iconBath, value: '1'),
                            ],
                          )),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        space16,
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: '${currencyFormat(1250000, false)} ',
                style: Theme.of(context).textTheme.titleLarge,
                children: <TextSpan>[
                  TextSpan(
                      text: '₮/сар',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: gray, fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            Text('2023.01.11',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: gray, fontWeight: FontWeight.w400))
          ],
        ),
        space8,
        Text(
          '2 өрөө, гал тогоо тусдаа хуучны дулаахан байрыг баруун европуудад удаан хугацаагаар түрээслүүлнэ ',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: black, fontWeight: FontWeight.bold),
        ),
        space16
      ],
    );
  }
}
