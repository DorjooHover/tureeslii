import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/controllers.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/shared/index.dart';

class RentRequestView extends StatefulWidget {
  const RentRequestView({super.key, required this.data});
  final Post data;
  @override
  State<RentRequestView> createState() => _RentRequestViewState();
}

bool drawer = false;

class _RentRequestViewState extends State<RentRequestView> {
  final GlobalKey<ScaffoldState> requestKey = GlobalKey<ScaffoldState>();
  String selectedBank = bankValues[0];
  final controller = Get.put(MainController());
  List<RentRequest> rentRequests = [];
  @override
  void initState() {
    super.initState();

    if (widget.data.rentRequests == null) {
      getRentRequest();
    }
  }

  getRentRequest() async {
    rentRequests = await controller.getRentRequestById(widget.data.id!);
    setState(() {});
  }

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
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: origin),
                  child: RentRequestCard(data: widget.data)),
              space2,
              if (widget.data.rentRequests != null &&
                  widget.data.rentRequests!.isNotEmpty)
                ...widget.data.rentRequests!.map((e) {
                  final i = widget.data.rentRequests?.indexOf(e);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RequestCard(data: e),
                      if (widget.data.rentRequests?.length != null &&
                          widget.data.rentRequests!.length > 1 &&
                          i != widget.data.rentRequests!.length - 1)
                        const Divider(
                          color: navGray,
                          height: 2,
                        )
                    ],
                  );
                }).toList()
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
