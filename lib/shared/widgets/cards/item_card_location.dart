import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/shared/index.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key, required this.data});
  final Apartment data;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: small),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          Flexible(
            flex: 5,
            child: Stack(
              children: [
                Container(
                    width: 119,
                    height: 119,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(origin),
                      border: Border.all(color: Colors.black),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          spreadRadius: 0.25,
                          offset: const Offset(0, 4),
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
                    )),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(origin),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black,
                              Colors.black.withOpacity(0),
                            ],
                          )),
                    )),
                Positioned(
                    top: small,
                    left: small,
                    child: SvgPicture.asset(iconHeartActive)),
                Positioned(
                    bottom: small,
                    right: small,
                    left: small,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(iconRoom),
                            space2,
                            Text(
                              '12',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(iconBed),
                            space2,
                            Text(
                              '5',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(iconBath),
                            space2,
                            Text(
                              '3',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
          space16,
          Flexible(
            flex: 9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('СБД • Орон сууц • 2023.01.10',
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: gray, fontWeight: FontWeight.w400)),
                Text(
                  '2 өрөө, гал тогоо тусдаа хуучны дулаахан байрыг баруун европуудад удаан хугацаагаар түрээслүүлнэ ',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: black, fontWeight: FontWeight.bold),
                ),
                space16,
                RichText(
                  text: TextSpan(
                    text: '${currencyFormat(450000, false)} ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: '₮/сар',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: gray, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
