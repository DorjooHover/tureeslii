import 'package:flutter/material.dart';
import 'package:tureeslii/shared/index.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        currentIndex: 4,
        height: 246,
        back: true,
        bgColor: bgGray,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: origin),
          child: Column(
            children: <Widget>[
              space64,
              Image.asset(imageNoData),
              space32,
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  noDataText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
