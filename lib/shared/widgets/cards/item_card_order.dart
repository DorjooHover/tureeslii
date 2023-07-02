import 'package:flutter/material.dart';
import 'package:tureeslii/shared/index.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    Color color = Colors.white;

    bool arrow = false;
    switch (type) {
      case 'success':
        color = green;

        arrow = true;
        break;
      case 'warning':
        color = warning;

        break;
      case 'danger':
        color = red;

        break;

      default:
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          arrow
              ? BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  spreadRadius: 0.15,
                  offset: const Offset(0, 4), // Shadow position
                )
              : const BoxShadow(
                  color: Colors.transparent,

                  offset: Offset(0, 0), // Shadow position
                ),
          arrow
              ? BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  spreadRadius: 0.15,
                  offset: const Offset(0, 0), // Shadow position
                )
              : const BoxShadow(
                  color: Colors.transparent,

                  offset: Offset(0, 0), // Shadow position
                ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: LayoutBuilder(
              builder: (p0, p1) {
                final double w = p1.maxHeight;
                final double h = w;
                return AspectRatio(
                  aspectRatio:
                      1.0, // Aspect ratio of 1:1 for equal width and height
                  child: Container(
                    width: w,
                    height: h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(origin),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            width: 11,
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2 өрөө, гал тогоо тусдаа байр түрээслэнэ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold, color: black),
                ),
                space4,
                RichText(
                  text: TextSpan(
                    text: '${currencyFormat(1250000)} ',
                    style: Theme.of(context).textTheme.titleLarge,
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
                space8,
                OrderStatus(
                  type: type,
                )
              ],
            ),
          ),
          space10,
          arrow
              ? Icon(
                  Icons.arrow_forward_ios,
                  size: 24,
                  color: Colors.black,
                )
              : const SizedBox(
                  width: 24,
                ),
        ],
      ),
    );
  }
}
