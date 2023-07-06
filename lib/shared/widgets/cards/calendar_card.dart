import 'package:flutter/material.dart';
import 'package:landlord/shared/constants/colors.dart';
import 'package:landlord/shared/constants/spacing.dart';
import 'package:landlord/shared/constants/strings.dart';
import 'package:landlord/shared/constants/values.dart';

class CalendarCard extends StatelessWidget {
  const CalendarCard({super.key});
  @override
  Widget build(BuildContext context) {
    List<int> years = [2023, 2024];
    List<DateTime> selected = [DateTime(2023, 7), DateTime(2023, 8)];
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ...years.map((year) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$year $yearStr',
                style: Theme.of(context).textTheme.titleLarge!,
              ),
              space16,
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: monthsValues
                      .where((element) => element <= 6)
                      .map((month) {
                    return Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected.contains(DateTime(year, month))
                            ? orange
                            : DateTime.now().compareTo(DateTime(year, month)) <
                                    0
                                ? Colors.white
                                : monthBefore,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: monthGray, width: 2),
                      ),
                      child: Text(
                        '$month',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: selected.contains(DateTime(year, month))
                                ? Colors.white
                                : monthTextGray,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList()),
              space16,
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      monthsValues.where((element) => element > 6).map((month) {
                    return Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected.contains(DateTime(year, month))
                            ? orange
                            : DateTime.now().compareTo(DateTime(year, month)) <
                                    0
                                ? Colors.white
                                : monthBefore,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: monthGray, width: 2),
                      ),
                      child: Text(
                        '$month',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: selected.contains(DateTime(year, month))
                                ? Colors.white
                                : monthTextGray,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList()),
              year != years.last ? space45 : space16,
            ]);
      }).toList()
    ]);
  }
}
