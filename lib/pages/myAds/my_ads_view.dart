import 'package:flutter/material.dart';
import 'package:landlord/pages/pages.dart';
import 'package:landlord/shared/index.dart';

class MyAdsView extends StatefulWidget {
  const MyAdsView({super.key});

  @override
  State<MyAdsView> createState() => _MyAdsViewState();
}

final GlobalKey<ScaffoldState> mainKey = GlobalKey<ScaffoldState>();
bool isDrawer = false;

class _MyAdsViewState extends State<MyAdsView> {
  String selectedBank = bankValues[0];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: mainKey,
        backgroundColor: Colors.white,
        appBar: MyAdsAppBar(
          height: MediaQuery.of(context).padding.top + 220,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: origin, vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset(
                      imageLogo,
                      height: 22,
                    ),
                    Builder(
                      builder: (context) => IconButton(
                        icon: Icon(Icons.menu_sharp),
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: origin, vertical: 25),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Миний',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: black, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'оруулсан зар',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: black, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [Container()],
          bgColor: bgGray,
          statusBarColor: bgGray,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30),
            child: Container(
              color: Colors.white,
              child: TabBar(
                indicatorColor: prime,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
                unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
                labelColor: black,
                unselectedLabelColor: black,
                tabs: [
                  Tab(height: 30, text: published),
                  Tab(height: 30, text: entered),
                  Tab(height: 30, text: notEnough),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            PublishedView(),
            EnteredView(),
            NotEnoughView(),
          ],
        ),
        onEndDrawerChanged: (isOpened) {
          setState(() {
            isDrawer = isOpened;
          });
        },
        endDrawer: MainDrawer(
            onTap: (int index) {},
            cancel: () {
              mainKey.currentState!.closeEndDrawer();
            },
            selectedIndex: 0),
      ),
    );
  }
}
