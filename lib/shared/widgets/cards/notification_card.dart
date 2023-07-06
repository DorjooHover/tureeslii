import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:landlord/shared/index.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.type, required this.dot});
  final String type;
  final bool dot;
  @override
  Widget build(BuildContext context) {
    Color color = Colors.white;
    String icon = iconSuccess;
    switch (type) {
      case 'success':
        color = green;
        icon = iconSuccess;
        break;
      case 'warning':
        color = warning;
        icon = iconWarning;
        break;
      case 'danger':
        color = red;
        icon = iconDanger;
        break;
      case 'info':
        color = blue;
        icon = iconInfo;
        break;
      default:
    }
    return GestureDetector(
      onTap: () {
        if (dot) {
          showDialog(
              context: context,
              builder: (context) => NotificationDialog(
                  icon: icon,
                  description:
                      'Байр түрээслэх хүсэлтэй иргэд эхлээд хууль тогтоох эрхтэй боллоо.',
                  title: 'Түрээсийн хуулийн өөрчлөлт.'));
        }
      },
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 10.0,
            spreadRadius: 0.0,
          )
        ]),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 0,
          child: ListTile(
            minLeadingWidth: 20,
            horizontalTitleGap: 20,
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: tiny,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(6)),
                ),
                space20,
                SvgPicture.asset(icon)
              ],
            ),
            title: Text(
              'Түрээсийн хуулийн өөрчлөлт.',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: black),
            ),
            subtitle: Text(
              'Байр түрээслэх хүсэлтэй иргэд эхлээд хууль тогтоох эрхтэй боллоо.',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(color: gray1),
            ),
            trailing: dot
                ? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                    width: 5,
                    height: 5,
                  )
                : const SizedBox(
                    width: 5,
                    height: 5,
                  ),
          ),
        ),
      ),
    );
  }
}
