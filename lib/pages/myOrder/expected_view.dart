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
  Future<void> getData () async {
      List<RentRequest> res = await controller.pendingRentRequest('PAID');
      if(!mounted) {
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
      child: SingleChildScrollView(
        child: data.isNotEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ...data.map((e) {
                    final i = data.indexOf(e);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        space24,
                        Container(
                            margin: EdgeInsets.symmetric(
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
                              padding: EdgeInsets.symmetric(vertical: large),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  RentRequestCard(
                                    shadow: false,
                                    data: e.post!
                                  ),
                                  space32,
    
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                              Divider(color: navGray,),
                                  RequestCard(
                                    data: e
                                  ),
                                  Divider(color: navGray,)
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ],
                    );
                  }).toList(),
                ],
              )
            : Center(
                child: NoDataView(
                  height: MediaQuery.of(context).size.height * 0.6 - 66,
                ),
              ),
      ),
    );
  }
}
