import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/shared/index.dart';

class ItemDetailView extends StatelessWidget {
  const ItemDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: bgGray,
            statusBarIconBrightness:
                Brightness.dark, //<-- For Android SEE HERE (dark icons)
            statusBarBrightness:
                Brightness.light, //<-- For iOS SEE HERE (dark icons)
          ),
          leading: const SizedBox(),
          toolbarHeight: 0,
          elevation: 0,
        ),
        backgroundColor: bgGray,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: origin, vertical: 24),
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ItemDetailCard(
                      data: Apartment(),
                    ),
                    space36,
                    space4,
                    const MenuContainer(child: CalendarCard()),
                    space36,
                    space4,
                    MoreDetailCard(
                      flatDetail: FlatDetail(
                        inPayment: InPayment(
                          payment: DetailName(
                              icon: detailPayment,
                              name: 'Төлбөр',
                              value: '600000',
                              type: 'number'),
                          electronic: DetailName(
                            icon: detailElectronic,
                            name: 'Цахилгаан',
                            value: 'Багтаагүй',
                          ),
                          accommodation: DetailName(
                            icon: detailAccommodation,
                            name: 'Байрны мөнгө',
                            value: 'Багтаагүй',
                          ),
                          internet: DetailName(
                            icon: detailInternet,
                            name: 'Интернет',
                            value: 'Багтаагүй',
                          ),
                          sokh: DetailName(
                            icon: detailSokh,
                            name: 'СӨХ',
                            value: 'Багтаагүй',
                          ),
                        ),
                        flat: Flat(
                          area: DetailName(
                            icon: detailArea,
                            name: 'Байрны талбай м2',
                            value: '15.7',
                          ),
                          bathroom: DetailName(
                            icon: detailBathroom,
                            name: '00-н өрөө',
                            value: 'Дотор',
                          ),
                          floor: DetailName(
                            icon: detailFloor,
                            name: 'Давхар',
                            value: '21',
                          ),
                          heating: DetailName(
                            icon: detailHeating,
                            name: 'Халаалт',
                            value: 'Төвийн',
                          ),
                          waterSupply: DetailName(
                            icon: detailArea,
                            name: 'Усан хангамж',
                            value: 'Төвийн',
                          ),
                        ),
                        feature: Feature(
                          elevator: DetailName(
                            icon: detailArea,
                            name: 'Цахилгаан шат',
                            value: 'Байхгүй',
                          ),
                          balcony: DetailName(
                            icon: detailBathroom,
                            name: 'Тагт',
                            value: 'Байхгүй',
                          ),
                          cabelTV: DetailName(
                            icon: detailFloor,
                            name: 'Кабелийн ТВ',
                            value: 'Байхгүй',
                          ),
                          net: DetailName(
                            icon: detailHeating,
                            name: 'Интернет',
                            value: 'Байхгүй',
                          ),
                          oven: DetailName(
                            icon: detailArea,
                            name: 'Зуух',
                            value: 'Байхгүй',
                          ),
                          refrigerator: DetailName(
                            icon: detailArea,
                            name: 'Хөргөгч',
                            value: 'Байхгүй',
                          ),
                          washing: DetailName(
                            icon: detailArea,
                            name: 'Угаалгын машин',
                            value: 'Байхгүй',
                          ),
                        ),
                        furniture: Furniture(
                          bed: DetailName(
                            icon: detailArea,
                            name: 'Ор',
                            value: 'Байгаа',
                          ),
                          cabinet: DetailName(
                            icon: detailBathroom,
                            name: 'Шүүгээ',
                            value: 'Байгаа',
                          ),
                          chair: DetailName(
                            icon: detailFloor,
                            name: 'Сандал',
                            value: 'Байгаа',
                          ),
                          drawer: DetailName(
                            icon: detailHeating,
                            name: 'Шургуулга',
                            value: 'Байгаа',
                          ),
                          kitchen: DetailName(
                            icon: detailArea,
                            name: 'Гал тогооны тавилга',
                            value: 'Байгаа',
                          ),
                          sofa: DetailName(
                            icon: detailArea,
                            name: 'Буйдан',
                            value: 'Байгаа',
                          ),
                          table: DetailName(
                            icon: detailArea,
                            name: 'Ширээ',
                            value: 'Байгаа',
                          ),
                        ),
                        rentCondition: RentCondition(
                          bailCondition: DetailName(
                            icon: detailArea,
                            name: 'Барьцааны нөхцөл',
                            value: 'Байхгүй',
                          ),
                          cancelCondition: DetailName(
                              icon: detailBathroom,
                              name: 'Цуцлах нөхцөл',
                              value: 'Хатуу',
                              warning: ''),
                          contractCondition: DetailName(
                              icon: detailFloor,
                              name: 'Гэрээний нөхцөл',
                              value: 'Өдрөөр',
                              warning: ''),
                          paymentCondition: DetailName(
                            icon: detailHeating,
                            name: 'Төлбөрийн нөхцөл',
                            value: '1 сар',
                          ),
                          whomRent: DetailName(
                            icon: detailArea,
                            name: 'Хэнд түрээслэх',
                            value: 'Хамаагүй',
                          ),
                        ),
                        restrictions: Restrictions(
                          invite: DetailName(
                            icon: detailArea,
                            name: 'Зочин урих',
                            value: 'Болохгүй',
                          ),
                          isLiveTogether: DetailName(
                            icon: detailBathroom,
                            name: 'Түрээслүүлэгч цуг амьдрах эсэх',
                            value: 'Үгүй',
                          ),
                          pet: DetailName(
                            icon: detailFloor,
                            name: 'Тэжээвэр амьтан',
                            value: 'Болохгүй',
                          ),
                          smoke: DetailName(
                            icon: detailHeating,
                            name: 'Тамхи татах',
                            value: 'Болохгүй',
                          ),
                          whomRent: DetailName(
                            icon: detailArea,
                            name: 'Хэнд түрээслэх',
                            value: '2',
                          ),
                        ),
                      ),
                    ),
                    space20
                  ],
                ),
              ),
              Positioned(
                  top: 32,
                  left: 24,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.all(small),
                        backgroundColor: Colors.white,
                        shape: const CircleBorder()),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: gray,
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertContainer(
                    horizontal: 0,
                    padding: const EdgeInsets.symmetric(horizontal: origin),
                    child: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              child: AdditionCard(
                                  color: black,
                                  title: startRentDate,
                                  child: const Input()),
                            ),
                            space4,
                            space2,
                            Text('-',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: black)),
                            space4,
                            space2,
                            Flexible(
                              child: AdditionCard(
                                  color: black,
                                  title: startEndDate,
                                  child: Input()),
                            ),
                          ],
                        ),
                      ),
                      space20,
                      MenuContainer(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(time,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: black)),
                              Text('2 сар 1 өдөр',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: black,
                                          fontWeight: FontWeight.bold)),
                            ],
                          ),
                          space20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(payment,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: black)),
                              Text('${currencyFormat(1200000, true)}₮',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: prime,
                                          fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      )),
                      space32,
                      MainButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        width: double.infinity,
                        text: request,
                      ),
                      space64,
                    ],
                  );
                });
          },
          child: Container(
            padding: const EdgeInsets.all(origin),
            decoration: BoxDecoration(
                color: prime,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,

                    offset: const Offset(4, 4), // Shadow position
                  )
                ]),
            child: SvgPicture.asset(iconHeartActive),
            // child: SvgPicture.asset(iconSend),
          ),
        ),
      ),
    );
  }
}
