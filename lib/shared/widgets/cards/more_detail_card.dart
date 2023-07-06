import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/shared/index.dart';

class MoreDetailCard extends StatelessWidget {
  const MoreDetailCard({super.key, required this.flatDetail});
  final FlatDetail flatDetail;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MenuContainer(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      inPrice,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SvgPicture.asset(iconArrowUp)
                  ],
                ),
              ),
              space16,
              MoreDetailItem(
                list: [
                  flatDetail.inPayment!.payment!,
                  flatDetail.inPayment!.electronic!,
                  flatDetail.inPayment!.accommodation!,
                  flatDetail.inPayment!.internet!,
                  flatDetail.inPayment!.sokh!,
                ],
                color: gray,
              ),
              space36,
              space4,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      flatCondition,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SvgPicture.asset(iconArrowUp)
                  ],
                ),
              ),
              space16,
              MoreDetailItem(
                list: [
                  flatDetail.flat!.heating!,
                  flatDetail.flat!.waterSupply!,
                  flatDetail.flat!.bathroom!,
                  flatDetail.flat!.area!,
                  flatDetail.flat!.floor!,
                ],
                color: black,
              ),
              space36,
              space4,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      flatFeature,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SvgPicture.asset(iconArrowUp)
                  ],
                ),
              ),
              space16,
              MoreDetailItem(
                list: [
                  flatDetail.feature!.elevator!,
                  flatDetail.feature!.balcony!,
                  flatDetail.feature!.net!,
                  flatDetail.feature!.cabelTV!,
                  flatDetail.feature!.oven!,
                  flatDetail.feature!.washing!,
                  flatDetail.feature!.refrigerator!,
                ],
                color: gray,
              ),
              space36,
              space4,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      furniture,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SvgPicture.asset(iconArrowUp)
                  ],
                ),
              ),
              space16,
              MoreDetailItem(
                list: [
                  flatDetail.furniture!.cabinet!,
                  flatDetail.furniture!.chair!,
                  flatDetail.furniture!.table!,
                  flatDetail.furniture!.sofa!,
                  flatDetail.furniture!.drawer!,
                  flatDetail.furniture!.cabinet!,
                  flatDetail.furniture!.bed!,
                ],
                color: black,
              ),
            ],
          ),
        ),
        space36,
        space4,
        MenuContainer(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      rentCondition,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SvgPicture.asset(iconArrowUp)
                  ],
                ),
              ),
              space16,
              MoreDetailItem(
                list: [
                  flatDetail.rentCondition!.whomRent!,
                  flatDetail.rentCondition!.bailCondition!,
                  flatDetail.rentCondition!.paymentCondition!,
                  flatDetail.rentCondition!.cancelCondition!,
                  flatDetail.rentCondition!.contractCondition!,
                ],
                color: black,
              ),
              space36,
              space4,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      restrictions,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SvgPicture.asset(iconArrowUp)
                  ],
                ),
              ),
              space16,
              MoreDetailItem(
                list: [
                  flatDetail.restrictions!.pet!,
                  flatDetail.restrictions!.smoke!,
                  flatDetail.restrictions!.invite!,
                  flatDetail.restrictions!.isLiveTogether!,
                  flatDetail.restrictions!.whomRent!,
                ],
                color: black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MoreDetailItem extends StatelessWidget {
  const MoreDetailItem({super.key, required this.list, required this.color});
  final List<DetailName> list;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: list.map((e) {
        final index = list.indexOf(e);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: small),
          color: index % 2 == 0 ? bgGray : Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SvgPicture.asset(e.icon!),
                  space16,
                  Text(e.name!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: black,
                            fontWeight: FontWeight.w400,
                          ))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    e.type != null
                        ? '${currencyFormat(double.parse(e.value!), true)}₮'
                        : e.value!,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: e.type != null ? prime : color,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  space8,
                  if (e.warning != null)
                    Container(
                        width: origin,
                        height: origin,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: purple,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.question_answer,
                          color: Colors.white,
                          size: 13,
                        ))
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
