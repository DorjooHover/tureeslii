import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/shared/index.dart';

class MoreDetailCard extends StatefulWidget {
  const MoreDetailCard({super.key, required this.data});
  final Post data;
  @override
  State<MoreDetailCard> createState() => _MoreDetailCardState();
}

class _MoreDetailCardState extends State<MoreDetailCard>
    with TickerProviderStateMixin {
  bool isShowInPrice = true;
  bool isShowFlatCondition = true;
  bool isShowFlatFeature = true;
  bool isShowFurniture = true;
  bool isShowRentCondition = true;
  bool isShowRestrictions = true;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    _controller.forward();

    super.initState();
  }

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
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isShowInPrice = !isShowInPrice;
                          });
                          if (isShowInPrice) {
                            _controller.forward();
                          } else {
                            _controller.reverse();
                          }
                        },
                        child: SvgPicture.asset(
                            isShowInPrice ? iconArrowUp : iconArrowDown))
                  ],
                ),
              ),
              space16,
              AnimatedSize(
                duration: _controller.duration!,
                child: !isShowInPrice
                    ? null
                    : FadeTransition(
                        opacity: _animation,
                        child: MoreDetailItem(
                          list: [
                            DetailName(
                              icon: iconIncreasePrice,
                              value: '${widget.data.price ?? 0}',
                              type: "",
                              name: payment
                            ),
                            DetailName(
                              icon: iconIncreasePrice,
                              value: '${widget.data. ?? 0}',
                              type: "",
                              name: electronic
                            ),
                            DetailName(
                              icon: iconIncreasePrice,
                              value: '${widget.data.price ?? 0}',
                              type: "",
                              name: electronic
                            ),
                            widget.data.inPayment!.electronic!,
                            widget.data.inPayment!.accommodation!,
                            widget.data.inPayment!.internet!,
                            widget.data.inPayment!.sokh!,
                          ],
                          color: gray,
                        ),
                      ),
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
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isShowFlatCondition = !isShowFlatCondition;
                          });
                        },
                        child: SvgPicture.asset(
                            isShowFlatCondition ? iconArrowUp : iconArrowDown))
                  ],
                ),
              ),
              space16,
              MoreDetailItem(
                list: [
                  widget.data.flat!.heating!,
                  widget.data.flat!.waterSupply!,
                  widget.data.flat!.bathroom!,
                  widget.data.flat!.area!,
                  widget.data.flat!.floor!,
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
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isShowFlatFeature = !isShowFlatFeature;
                          });
                        },
                        child: SvgPicture.asset(
                            isShowFlatFeature ? iconArrowUp : iconArrowDown))
                  ],
                ),
              ),
              space16,
              MoreDetailItem(
                list: [
                  widget.data.feature!.elevator!,
                  widget.data.feature!.balcony!,
                  widget.data.feature!.net!,
                  widget.data.feature!.cabelTV!,
                  widget.data.feature!.oven!,
                  widget.data.feature!.washing!,
                  widget.data.feature!.refrigerator!,
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
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isShowFurniture = !isShowFurniture;
                          });
                        },
                        child: SvgPicture.asset(
                            isShowFurniture ? iconArrowUp : iconArrowDown))
                  ],
                ),
              ),
              space16,
              MoreDetailItem(
                list: [
                  widget.data.furniture!.cabinet!,
                  widget.data.furniture!.chair!,
                  widget.data.furniture!.table!,
                  widget.data.furniture!.sofa!,
                  widget.data.furniture!.drawer!,
                  widget.data.furniture!.cabinet!,
                  widget.data.furniture!.bed!,
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
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isShowRentCondition = !isShowRentCondition;
                          });
                        },
                        child: SvgPicture.asset(
                            isShowRentCondition ? iconArrowUp : iconArrowDown))
                  ],
                ),
              ),
              space16,
              MoreDetailItem(
                list: [
                  widget.data.rentCondition!.whomRent!,
                  widget.data.rentCondition!.bailCondition!,
                  widget.data.rentCondition!.paymentCondition!,
                  widget.data.rentCondition!.cancelCondition!,
                  widget.data.rentCondition!.contractCondition!,
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
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isShowRestrictions = !isShowRestrictions;
                          });
                        },
                        child: SvgPicture.asset(
                            isShowRestrictions ? iconArrowUp : iconArrowDown))
                  ],
                ),
              ),
              space16,
              MoreDetailItem(
                list: [
                  widget.data.restrictions!.pet!,
                  widget.data.restrictions!.smoke!,
                  widget.data.restrictions!.invite!,
                  widget.data.restrictions!.isLiveTogether!,
                  widget.data.restrictions!.whomRent!,
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
