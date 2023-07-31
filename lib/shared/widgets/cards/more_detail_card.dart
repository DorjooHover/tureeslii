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
                                icon: detailPayment,
                                value: '${widget.data.price ?? 0}',
                                type: "price",
                                name: payment),
                            DetailName(
                                icon: detailElectronic,
                                value: getPriceIncluded(priceIncluded[0],
                                        widget.data.priceIncluded ?? [])
                                    ? 'Багтсан'
                                    : 'Багтаагүй',
                                type: getPriceIncluded(priceIncluded[0],
                                        widget.data.priceIncluded ?? [])
                                    ? "true"
                                    : "",
                                name: electronic),
                            DetailName(
                                icon: detailAccommodation,
                                value: getPriceIncluded(priceIncluded[1],
                                        widget.data.priceIncluded ?? [])
                                    ? 'Багтсан'
                                    : 'Багтаагүй',
                                type: getPriceIncluded(priceIncluded[1],
                                        widget.data.priceIncluded ?? [])
                                    ? "true"
                                    : "",
                                name: flatPrice),
                            DetailName(
                                icon: detailInternet,
                                value: getPriceIncluded(priceIncluded[2],
                                        widget.data.priceIncluded ?? [])
                                    ? 'Багтсан'
                                    : 'Багтаагүй',
                                type: getPriceIncluded(priceIncluded[2],
                                        widget.data.priceIncluded ?? [])
                                    ? "true"
                                    : "",
                                name: internet),
                            DetailName(
                                icon: detailSokh,
                                value: getPriceIncluded(priceIncluded[3],
                                        widget.data.priceIncluded ?? [])
                                    ? 'Багтсан'
                                    : 'Багтаагүй',
                                type: getPriceIncluded(priceIncluded[3],
                                        widget.data.priceIncluded ?? [])
                                    ? "true"
                                    : "",
                                name: sokh),
                          ],
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
              AnimatedSize(
                duration: _controller.duration!,
                child: !isShowFlatCondition
                    ? null
                    : FadeTransition(
                        opacity: _animation,
                        child: MoreDetailItem(
                          list: [
                            DetailName(
                                icon: detailHeating,
                                value: getHeating(widget.data.heating ?? ""),
                                type: "true",
                                name: heating),
                            DetailName(
                                icon: detailWaterSupply,
                                value: getWaterSupply(
                                    widget.data.waterSupply ?? ""),
                                type: "true",
                                name: waterSupply),
                            DetailName(
                                icon: detailBathroom,
                                value: getToilet(widget.data.restroom ?? ""),
                                type: "true",
                                name: toilet),
                            DetailName(
                                icon: detailArea,
                                value: widget.data.plot?.toStringAsFixed(1) ??
                                    '0.0',
                                type: "true",
                                name: area),
                            DetailName(
                                icon: detailFloor,
                                value: widget.data.floor.toString(),
                                type: "true",
                                name: floor),
                          ],
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
              AnimatedSize(
                duration: _controller.duration!,
                child: !isShowFlatFeature
                    ? null
                    : FadeTransition(
                        opacity: _animation,
                        child: MoreDetailItem(
                          list: [
                            DetailName(
                                icon: detailElevator,
                                value: widget.data.elevator!
                                    ? 'Багтсан'
                                    : "Багтаагүй",
                                type: widget.data.elevator! ? "true" : "",
                                name: elevator),
                            DetailName(
                                icon: detailBailCondition,
                                value: widget.data.balcony!
                                    ? 'Багтсан'
                                    : "Багтаагүй",
                                type: widget.data.balcony! ? "true" : "",
                                name: balcony),
                            DetailName(
                                icon: detailNet,
                                value:
                                    widget.data.wifi! ? 'Багтсан' : "Багтаагүй",
                                type: widget.data.wifi! ? "true" : "",
                                name: internet),
                            DetailName(
                                icon: detailCabel,
                                value: widget.data.tvCable!
                                    ? 'Багтсан'
                                    : "Багтаагүй",
                                type: widget.data.tvCable! ? "true" : "",
                                name: cabelTV),
                            DetailName(
                                icon: detailOval,
                                value: widget.data.stove!
                                    ? 'Багтсан'
                                    : "Багтаагүй",
                                type: widget.data.stove! ? "true" : "",
                                name: oval),
                            DetailName(
                                icon: detailWashing,
                                value: widget.data.washingMachine!
                                    ? 'Багтсан'
                                    : "Багтаагүй",
                                type: widget.data.washingMachine! ? "true" : "",
                                name: washing),
                            DetailName(
                                icon: detailRefrigerator,
                                value: widget.data.refrigerator!
                                    ? 'Багтсан'
                                    : "Багтаагүй",
                                type: widget.data.refrigerator! ? "true" : "",
                                name: refrigerator),
                          ],
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
              AnimatedSize(
                duration: _controller.duration!,
                child: !isShowFurniture
                    ? null
                    : FadeTransition(
                        opacity: _animation,
                        child: MoreDetailItem(
                          list: [
                            DetailName(
                                icon: detailCabinet,
                                value: getFurniture(furnitureIncluded[0],
                                        widget.data.furnitures ?? [])
                                    ? 'Байгаа'
                                    : 'Байхгүй',
                                type: getPriceIncluded(priceIncluded[0],
                                        widget.data.priceIncluded ?? [])
                                    ? "true"
                                    : "",
                                name: cabinet),
                            DetailName(
                                icon: detailChair,
                                value: getFurniture(furnitureIncluded[1],
                                        widget.data.furnitures ?? [])
                                    ? 'Байгаа'
                                    : 'Байхгүй',
                                type: getPriceIncluded(priceIncluded[1],
                                        widget.data.priceIncluded ?? [])
                                    ? "true"
                                    : "",
                                name: chair),
                            DetailName(
                                icon: detailTable,
                                value: getFurniture(furnitureIncluded[2],
                                        widget.data.furnitures ?? [])
                                    ? 'Байгаа'
                                    : 'Байхгүй',
                                type: getPriceIncluded(priceIncluded[2],
                                        widget.data.priceIncluded ?? [])
                                    ? "true"
                                    : "",
                                name: table),
                            DetailName(
                                icon: detailSofa,
                                value: getFurniture(furnitureIncluded[3],
                                        widget.data.furnitures ?? [])
                                    ? 'Байгаа'
                                    : 'Байхгүй',
                                type: getPriceIncluded(priceIncluded[3],
                                        widget.data.priceIncluded ?? [])
                                    ? "true"
                                    : "",
                                name: sofa),
                            DetailName(
                                icon: detailDrawer,
                                value: getFurniture(furnitureIncluded[4],
                                        widget.data.furnitures ?? [])
                                    ? 'Байгаа'
                                    : 'Байхгүй',
                                type: getPriceIncluded(priceIncluded[4],
                                        widget.data.priceIncluded ?? [])
                                    ? "true"
                                    : "",
                                name: drawer),
                            DetailName(
                                icon: detailKitchen,
                                value: widget.data.kitchenFurniture!
                                    ? 'Байгаа'
                                    : "Байхгүй",
                                type: widget.data.refrigerator! ? "true" : "",
                                name: kitchen),
                            // DetailName(
                            //     icon: detailB,
                            //     value: widget.data.bedCount! > 0
                            //         ? 'Байгаа'
                            //         : "Байхгүй",
                            //     type: widget.data.bedCount! > 0 ? "true" : "",
                            //     name: bed),
                          ],
                        ),
                      ),
              )
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
              AnimatedSize(
                duration: _controller.duration!,
                child: !isShowRentCondition
                    ? null
                    : MoreDetailItem(
                        list: [
                          DetailName(
                              icon: detailBailCondition,
                              value: widget.data.acceptedTenants! > 0
                                  ? 'Хамаагүй'
                                  : widget.data.acceptedTenants!.toString(),
                              type: "true",
                              name: bailCondition),
                          // widget.data.rentCondition!.whomRent!,
                          // widget.data.rentCondition!.bailCondition!,
                          // widget.data.rentCondition!.paymentCondition!,
                          // widget.data.rentCondition!.cancelCondition!,
                          // widget.data.rentCondition!.contractCondition!,
                        ],
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
              AnimatedSize(
                duration: _controller.duration!,
                child: !isShowRestrictions
                    ? null
                    : FadeTransition(
                        opacity: _animation,
                        child: MoreDetailItem(
                          list: [
                            DetailName(
                                icon: detailPet,
                                value: widget.data.petAllowed!
                                    ? 'Болно'
                                    : "Болохгүй",
                                type: "true",
                                name: pet),
                            DetailName(
                                icon: detailSmoke,
                                value: widget.data.smokingAllowed!
                                    ? 'Болно'
                                    : "Болохгүй",
                                type: "true",
                                name: smoke),
                            DetailName(
                                icon: detailInvite,
                                value: widget.data.guestAllowed!
                                    ? 'Болно'
                                    : "Болохгүй",
                                type: "true",
                                name: inviteGuest),
                            DetailName(
                                icon: detailTogether,
                                value: widget.data.livingProperty!
                                    ? 'Тийм'
                                    : "Үгүй",
                                type: "true",
                                name: isLiveTogether),
                            DetailName(
                                icon: detailWhoRent,
                                value: widget.data.acceptedTenants! > 0
                                    ? 'Хамаагүй'
                                    : widget.data.acceptedTenants!.toString(),
                                type: "true",
                                name: whomRent),
                          ],
                        ),
                      ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class MoreDetailItem extends StatelessWidget {
  const MoreDetailItem({
    super.key,
    required this.list,
  });
  final List<DetailName> list;

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
                  FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(e.name!,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: black,
                                    fontWeight: FontWeight.w400,
                                  )))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      e.type == 'price'
                          ? '${currencyFormat(double.parse(e.value!), true)}₮'
                          : e.value!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: e.type == 'price'
                                ? prime
                                : e.type == 'true'
                                    ? black
                                    : gray,
                            fontWeight: FontWeight.bold,
                          ),
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
