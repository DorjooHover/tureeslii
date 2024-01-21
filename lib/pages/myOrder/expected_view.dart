import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/controllers.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/pages/no_data.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class ExpectedView extends StatefulWidget {
  const ExpectedView({
    super.key,
  });

  @override
  State<ExpectedView> createState() => _ExpectedViewState();
}

class _ExpectedViewState extends State<ExpectedView> {
  final controller = Get.put(MainController());
  List<RentRequest> data = [];
  Future<void> getData() async {
    List<RentRequest> res = await controller.pendingRentRequest('PAID');
    if (!mounted) {
      return;
    }
    setState(() {
      data = res;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await getData();
      },
      child: data.isNotEmpty
          ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    space24,
                    Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: origin, vertical: medium),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15)
                            ],
                            borderRadius: BorderRadius.circular(origin),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: large),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RentRequestCard(
                                  shadow: false, data: data[index].post!),
                              space32,
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Divider(
                                    color: navGray,
                                  ),
                                  RequestCard(data: data[index]),
                                  const Divider(
                                    color: navGray,
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  ],
                );
              })
          : const Center(
              child: NoDataView(),
            ),
    );
  }
}
