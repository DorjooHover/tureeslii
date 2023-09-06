import 'package:flutter/material.dart';
import 'package:tureeslii/shared/index.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({super.key, this.height});
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: origin),
      child: Column(
        children: <Widget>[
          space64,
          SizedBox(
            height: height != null ? (height! - 150) : height,
            child: Image.asset(
              imageNoData,
            ),
          ),
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
    );
  }
}
