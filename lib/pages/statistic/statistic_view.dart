import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/controllers.dart';
import 'package:landlord/shared/index.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class StatisticView extends StatefulWidget {
  const StatisticView({super.key});

  @override
  State<StatisticView> createState() => _StatisticViewState();
}

class _StatisticViewState extends State<StatisticView> {
  List<String> data = [];
  String? postId;
  String date = datesValuesStr[0];
  final controller = Get.put(MainController());
  int viewed = 0;
  int saved = 0;
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
  List<ChartSampleData> chartData = <ChartSampleData>[

  ];

  getViews(String postId, String week) async {
    
    Map<String, List> res =await controller.getPostStats(postId, week);
    if(res['views']!.isNotEmpty) {
      List<ChartSampleData> chart = List<ChartSampleData>.filled(res['views']!.length, ChartSampleData());
       
      for(int i = 0; i < res['views']!.length ; i++) {
        setState(() { 
          viewed += res['views']![i]['counted_leads'] as int;
         saved += res['liked']![i]['counted_leads'] as int;
        });
        chart[i].x = res['views']![i]['count_date'] as String;
        chart[i].y = res['views']![i]['counted_leads'] as int;
        chart[i].yValue = res['liked']![i]['counted_leads'] as int;
      }
      
      setState(() {chartData = chart;});

    }
    
  }

  @override
  void initState() {
    super.initState();
    if (controller.ownPost.isNotEmpty) {
    
      setState(() {
        data =
            controller.ownPost.map((element) => element.id.toString()).toList();
        postId = data[0];
        
      });
      int dateIndex = datesValuesStr.indexOf(date);
      getViews(postId!, datesValues[dateIndex]);
    }
  }


  TrackballBehavior _trackballBehavior =
      TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAdsAppBar(
          back: true,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: origin, vertical: medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    statistic,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: black, fontWeight: FontWeight.bold),
                  ),
                  space45,
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              post,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: black),
                            ),
                            space4,
                            DropDown(
                                list: data,
                                value: postId ?? '0',
                                onChanged: (String? e) {
                                  if (e != null) {
                                    setState(() {
                                      postId = e;
                                    });
                             
                                    
                                
                                    getViews(e,date);
                                  
                                  }
                                })
                          ],
                        ),
                      ),
                      space16,
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              time,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: black),
                            ),
                            space4,
                            DropDown(
                                list: datesValuesStr,
                                value: date,
                                onChanged: (String? e) {
                                  if (e != null) {
                                    setState(() {
                                      date = e;
                                    });
                                    int i = datesValuesStr.indexOf(e);
                                    getViews(postId!, datesValues[i]);
                                  }
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                  space32,
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              viewed.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: orange,
                                      fontWeight: FontWeight.bold),
                            ),
                            space4,
                            Text(
                              totalViewed,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: black),
                            ),
                          ],
                        ),
                      ),
                      space16,
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '$saved',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: prime,
                                      fontWeight: FontWeight.bold),
                            ),
                            space4,
                            Text(
                              totalSaved,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  space20,
                  // Row(
                  //   children: <Widget>[
                  //    Expanded(
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //           Text('175', style: Theme.of(context).textTheme.displayMedium!.copyWith(color: black, fontWeight: FontWeight.bold),),
                  //           space4,
                  //           Text(lastSevenDayViewed, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),),

                  //         ],
                  //       ),
                  //     ),
                  //     space16,
                  //     Expanded(
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //           Text('75', style: Theme.of(context).textTheme.displayMedium!.copyWith(color: black, fontWeight: FontWeight.bold),),
                  //           space4,
                  //           Text(lastOneMonthViewed, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),),

                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  space32,
                  SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    legend: Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                    ),
                    primaryXAxis: CategoryAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        labelRotation: 0),
                    primaryYAxis: NumericAxis(
                        maximum: 200,
                        axisLine: const AxisLine(width: 0),
                        labelFormat: r'{value}',
                        majorTickLines: const MajorTickLines(size: 0)),
                    series: _getStackedLineSeries(),
                    trackballBehavior: _trackballBehavior,
                  )
                ],
              )),
        ));
  }

  List<StackedLineSeries<ChartSampleData, String>> _getStackedLineSeries() {
    return <StackedLineSeries<ChartSampleData, String>>[
      StackedLineSeries<ChartSampleData, String>(
          dataSource: chartData!,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: viewedCount,
          markerSettings: const MarkerSettings(isVisible: true)),
      StackedLineSeries<ChartSampleData, String>(
          dataSource: chartData!,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          name: savedCount,
          markerSettings: const MarkerSettings(isVisible: true)),

    ];
  }
}

class ChartSampleData {
 
  ChartSampleData(
      {this.x,
      this.y,

      this.yValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  String? x;

  /// Holds y value of the datapoint
  num? y;


  /// Holds y value of the datapoint
  num? yValue;


  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}

