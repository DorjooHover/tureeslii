import 'package:flutter/material.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/shared/index.dart';
import 'package:landlord/shared/widgets/widgets.dart';

class HistoryDetailView extends StatelessWidget {
  const HistoryDetailView({super.key, required this.data, required this.type});
  final RentRequest data;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAdsAppBar(
          back: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: origin, vertical: large),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 15,
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 0))
                ],
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RentRequestCard(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(origin),
                        topRight: Radius.circular(origin)),
                    shadow: false,
                    data: Post(
                        price: 1250000,
                        monthlyRent: true,
                        title:
                            '2 өрөө, гал тогоо тусдаа орон сууц урт хагацаагаар түрээслэнэ',
                        postAttachments: [],
                        postDate: DateTime.now().toString())),
                Stack(
                  children: [
                    CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, 40),
                      painter: CustomRectBorder(),
                    ),
                    Positioned(
                        top: -8,
                        left: MediaQuery.of(context).size.width * 0.5 -
                            20 -
                            large,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.cancel,
                            color: red,
                            size: 40,
                          ),
                        )),
                  ],
                ),
               Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                   borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(origin),
                        bottomRight: Radius.circular(origin)),
                ),
                child: AgreedRequestCard(data: data, child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    space16,
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: MainButton(
                        width: double.infinity,
                        onPressed: () {}, color: Color(0xffFFEEEE), child: Text(type, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: red, fontWeight: FontWeight.bold),),)),
                        if(type == renterCanceled) Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            space27,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('$paymentMonthly:', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),),
                            Text('${currencyFormat(100000, false)}₮', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),)
                          ],
                        ),
                        space20,
                        Divider(color: navGray,),
                        space13,
                            Text(paymentPaid, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontWeight: FontWeight.bold),),
                            space13,
                        ...['asdf', 'asdf'].map((e) => Container(
                          margin: EdgeInsets.only(bottom: origin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('$e', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),),
                              Text('${currencyFormat(100000, false)}₮', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: green, fontWeight: FontWeight.bold),)
                            ],
                          ),
                        )),
                        space13,
                        Divider(color: navGray,),
                        space20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('$totalPayment:', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),),
                            Text('${currencyFormat(100000, false)}₮', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),)
                          ],
                        ),
                        space16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('$totalPaid:', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),),
                            Text('${currencyFormat(100000, false)}₮', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: green, fontWeight: FontWeight.bold),)
                          ],
                        ),
                        space16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('$remainder:', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),),
                            Text('${currencyFormat(100000, false)}₮', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: red, fontWeight: FontWeight.bold),)
                          ],
                        ),
                        space16,space27,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('$paymentMonthly:', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),),
                            Text('${currencyFormat(100000, false)}₮', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),)
                          ],
                        ),
                        space20,
                        Divider(color: navGray,),
                        space13,
                            Text(paymentPaid, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontWeight: FontWeight.bold),),
                            space13,
                        ...['asdf', 'asdf'].map((e) => Container(
                          margin: EdgeInsets.only(bottom: origin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('$e', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),),
                              Text('${currencyFormat(100000, false)}₮', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: green, fontWeight: FontWeight.bold),)
                            ],
                          ),
                        )),
                        space13,
                        Divider(color: navGray,),
                        space20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('$totalPayment:', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),),
                            Text('${currencyFormat(100000, false)}₮', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),)
                          ],
                        ),
                        space16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('$totalPaid:', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),),
                            Text('${currencyFormat(100000, false)}₮', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: green, fontWeight: FontWeight.bold),)
                          ],
                        ),
                        space16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('$remainder:', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),),
                            Text('${currencyFormat(100000, false)}₮', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: red, fontWeight: FontWeight.bold),)
                          ],
                        ),
                        space16,
                          ],
                        )
                  ],
                ),))
              ],
            ),
          ),
        ));
  }
}

class CustomRectBorder extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    paint.style = PaintingStyle.fill;

    Paint line = Paint()
      ..color = navGray
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    Path path = Path()
      ..addPolygon([
        Offset(0, 0),
        Offset(size.width, 0),
        Offset(size.width - 15, size.height / 2),
        Offset(size.width, size.height),
        Offset(0, size.height),
        Offset(15, size.height / 2),
        Offset(0, 0),
      ], true);

    canvas.drawPath(path, paint);
    canvas.drawLine(Offset(15, size.height / 2),
        Offset(size.width - 15, size.height / 2), line);
  }

  @override
  bool shouldRepaint(covariant CustomRectBorder oldDelegate) {
    return false;
  }
}
