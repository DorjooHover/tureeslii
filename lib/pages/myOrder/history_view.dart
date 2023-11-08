import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/controllers.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/pages/no_data.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({
    super.key,
  });

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final controller = Get.put(MainController());
  List<RentRequest> data = [];
  bool loading = false;
  int active = 0;
  List<String> statuses = [
    "EXPIRED",
    "DECLINED",
    "FINISHED",
    "USER_CANCEL_REQUEST"
  ];
  List<String> statusStr = [notResponse, renterCanceled, refused, rented];
  Future<void> getData([String status = 'EXPIRED']) async {
    setState(() {
      loading = true;
    });
    List<RentRequest> res = await controller.pendingRentRequest(status);
    

    setState(() {
      data = res;
    });
    setState(() {
      loading = false;
    });
  }
  @override
  void setState(VoidCallback fn) {
    
    if(mounted) {
      super.setState(fn);
    }
  }


  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        space32,
        Wrap(
          runSpacing: 10,
          spacing: 10,
          children: statusStr.map((e) {
            int i = statusStr.indexOf(e);

            return GestureDetector(
              onTap: () {
                if (active != i) {
                  getData(statuses[i]);
                  setState(() {
                    active = i;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: active == i ? prime : Color(0xffEFEFEF)),
                child: Text(
                  e,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: i == active ? Colors.white : black),
                ),
              ),
            );
          }).toList(),
        ),
        space16,
        loading ? Center(child: CircularProgressIndicator(),) :
        Container(
          padding: EdgeInsets.symmetric(horizontal: origin),
          height: MediaQuery.of(context).size.height * 0.65 - 66,
          child: data.isNotEmpty
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.historyDetail,
                            arguments: [data[index], statusStr[index]]);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: origin),
                        child: HistoryCard(data: data[index]),
                      ),
                    );
                  },
                )
              : Center(
                  child: NoDataView(
                    height: MediaQuery.of(context).size.height * 0.6 - 66,
                  ),
                ),
        ),
      ],
    );
  }
}
