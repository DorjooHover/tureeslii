import 'package:flutter/material.dart';
import 'package:landlord/shared/index.dart';

class MyAdsCard extends StatelessWidget {
  const MyAdsCard(
      {super.key,
      required this.text,
      this.onPressed,
      required this.number,
      this.type});
  final String text;
  final int number;
  final String? type;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    String status = '';
    Color statusColor = Colors.transparent;
    switch (type) {
      case 'rented':
        status = 'Нийтлэгдсэн';
        statusColor = green;
        break;
      case 'checking':
        status = 'Шалгаж байна';
        statusColor = checkingBlack;
        break;
      case 'returned':
        status = 'Буцаагдсан';
        statusColor = returnedRed;
        break;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold, color: black),
        ),
        space13,
        RichText(
          text: TextSpan(
            text: 'БЗД - · ',
            style:
                Theme.of(context).textTheme.labelSmall!.copyWith(color: gray),
            children: <TextSpan>[
              TextSpan(
                text: 'Орон сууц · ',
              ),
              TextSpan(text: '2023.01.10'),
            ],
          ),
        ),
        space6,
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
        space32,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: type != null
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceBetween,
                children: [
                  MainButton(
                    height: 26,
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: origin),
                    onPressed: onPressed ?? () {},
                    child: RichText(
                      text: TextSpan(
                        text: req,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white),
                        children: <TextSpan>[
                          TextSpan(
                              text: ': $number',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  space8,
                  RichText(
                    text: TextSpan(
                      text: view,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: gray),
                      children: <TextSpan>[
                        TextSpan(
                            text: ': $number',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: black, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (status != '')
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(15)),
                  height: 26,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    status,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                ),
              )
          ],
        )
      ],
    );
  }
}

class NotEnoughCard extends StatelessWidget {
  const NotEnoughCard(
      {super.key,
      required this.onTap,
      required this.selected,
      required this.onPress,
      required this.date});
  final Function() onTap;
  final Function(int e) onPress;
  final String date;

  final List<int> selected;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextButton(
            onPressed: onTap,
            child: Text(
              date,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: black, fontWeight: FontWeight.bold),
            )),
        space16,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [1, 2, 3, 4, 5, 6, 7]
              .map((e) => GestureDetector(
                    onTap: onPress(e),
                    child: Container(
                        margin: EdgeInsets.only(left: 11),
                        alignment: Alignment.center,
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                            color: selected.where((s) => s == e).isNotEmpty
                                ? blue
                                : sliderGray,
                            borderRadius: BorderRadius.circular(100)),
                        child: Text(
                          '$e',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      selected.where((s) => s == e).isNotEmpty
                                          ? Colors.white
                                          : gray,
                                  fontWeight: FontWeight.bold),
                        )),
                  ))
              .toList(),
        )
      ],
    );
  }
}

class RentRequestCard extends StatelessWidget {
  const RentRequestCard({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15)
          ],
          borderRadius: BorderRadius.circular(origin)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [0, 1, 2, 3, 4, 5]
                  .map((e) => Container(
                        margin: EdgeInsets.only(right: e != 5 ? 10 : 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                            width: 59,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          space16,
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold, color: black),
          ),
          space13,
          RichText(
            text: TextSpan(
              text: 'БЗД - · ',
              style:
                  Theme.of(context).textTheme.labelSmall!.copyWith(color: gray),
              children: <TextSpan>[
                TextSpan(
                  text: 'Орон сууц · ',
                ),
                TextSpan(text: '2023.01.10'),
              ],
            ),
          ),
          space6,
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
        ],
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  const RequestCard({super.key, required this.text, required this.phoneNumber});
  final String text;
  final int phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: origin, vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  'https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                  width: 59,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              space16,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: black, fontWeight: FontWeight.bold),
                  ),
                  space2,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.phone,
                        size: 16,
                        color: green,
                      ),
                      space4,
                      Text(
                        '$phoneNumber',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: black, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          space16,
          RichText(
            text: TextSpan(
              text: 'Түрээслэх хугацаа: ',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: black),
              children: <TextSpan>[
                TextSpan(
                  text: '6 сар',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          space24,
          SizedBox(
            width: MediaQuery.of(context).size.width - large,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: MainButton(
                  borderRadius: 20,
                  onPressed: () {},
                  color: red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      ),
                      space8,
                      Text(
                        agree,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white),
                      )
                    ],
                  ),
                )),
                space16,
                Expanded(
                    child: MainButton(
                  color: Colors.transparent,
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.close,
                        size: 16,
                        color: red,
                      ),
                      space8,
                      Text(
                        decline,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: red),
                      )
                    ],
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
