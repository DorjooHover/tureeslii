import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:landlord/shared/index.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  String selectedBank = bankValues[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGray,
      appBar: MainAppBar(
        back: true,
        logo: false,
        actions: [Container()],
        bgColor: bgGray,
        statusBarColor: bgGray,
      ),
      body: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: origin, vertical: medium),
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 63,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                verification,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: black, fontWeight: FontWeight.w600),
              ),
              space36,
              Row(
                children: <Widget>[
                  Expanded(
                      child: AdditionCard(
                          title: front,
                          child: Container(
                            width: double.infinity,
                            height: 96,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: divider),
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              iconAddImage,
                              width: 40,
                            ),
                          ))),
                  space16,
                  Expanded(
                      child: AdditionCard(
                          title: back,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: divider),
                            ),
                            width: double.infinity,
                            height: 96,
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              iconAddImage,
                              width: 40,
                            ),
                          ))),
                ],
              ),
              space16,
              Text(
                yourId,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontStyle: FontStyle.italic, color: black),
              ),
              space24,
              AdditionCard(
                  title: bank,
                  child: DropDown(
                    list: bankValues,
                    value: selectedBank,
                    onChanged: (value) {},
                  )),
              space24,
              AdditionCard(
                  title: accountNumber,
                  child: Input(
                    textInputType: TextInputType.number,
                  )),
              space24,
              AdditionCard(
                  title: accountName,
                  child: Input(
                    textInputType: TextInputType.number,
                  )),
              space36,
              MainButton(
                onPressed: () {},
                text: request,
                width: double.infinity,
              ),
              space40
            ],
          ),
        ),
      ),
    );
  }
}
