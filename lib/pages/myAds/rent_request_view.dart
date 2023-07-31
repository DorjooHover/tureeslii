import 'package:flutter/material.dart';
import 'package:landlord/shared/index.dart';

class RentRequestView extends StatefulWidget {
  const RentRequestView({super.key});

  @override
  State<RentRequestView> createState() => _RentRequestViewState();
}

final GlobalKey<ScaffoldState> requestKey = GlobalKey<ScaffoldState>();
bool drawer = false;

class _RentRequestViewState extends State<RentRequestView> {
  String selectedBank = bankValues[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: requestKey,
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        bgColor: bgGray,
        statusBarColor: bgGray,
        back: true,
        logo: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: origin),
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  rentRequestStr,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: black, fontWeight: FontWeight.w600),
                ),
              ),
              space20,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: origin),
                child: RentRequestCard(
                    text:
                        '2 өрөө, гал тогоо тусдаа орон сууц урт хагацаагаар түрээслэнэ'),
              ),
              space2,
              ...[0, 1, 2, 3]
                  .map((e) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RequestCard(
                            text: 'Б.Нэлээн-Уртнэртэйнөхөр',
                            phoneNumber: 69112233,
                          ),
                          if (e != 3)
                            Divider(
                              color: navGray,
                              height: 2,
                            )
                        ],
                      ))
                  .toList()
            ],
          ),
        ),
      ),
      onEndDrawerChanged: (isOpened) {
        setState(() {
          drawer = isOpened;
        });
      },
      endDrawer: MainDrawer(
          onTap: (int index) {},
          cancel: () {
            requestKey.currentState!.closeEndDrawer();
          },
          selectedIndex: 0),
    );
  }
}
