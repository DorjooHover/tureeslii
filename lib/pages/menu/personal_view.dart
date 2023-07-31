import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:landlord/shared/index.dart';

class PersonalView extends StatefulWidget {
  const PersonalView({super.key});

  @override
  State<PersonalView> createState() => _PersonalViewState();
}

class _PersonalViewState extends State<PersonalView> {
  bool info = true;
  bool product = true;

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
                personInfo,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: black, fontWeight: FontWeight.w600),
              ),
              space36,
              space20,
              AdditionCard(title: firstName, child: Input()),
              space24,
              AdditionCard(title: name, child: Input()),
              space24,
              AdditionCard(
                  title: email,
                  child: Input(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(13),
                        child: SvgPicture.asset(
                          iconVerified,
                        ),
                      ),
                      borderSide: BorderSide(
                        color: active,
                      ))),
              space24,
              AdditionCard(
                  title: phone,
                  child: Input(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(13),
                        child: SvgPicture.asset(
                          iconVerified,
                        ),
                      ),
                      borderSide: BorderSide(
                        color: active,
                      ))),
              space24,
              AdditionCard(title: companyName, child: Input()),
              space24,
              AdditionCard(title: registerNumber, child: Input()),
              space24,
              AdditionCard(
                  title: password,
                  child: Input(
                    suffixIcon: Icon(Icons.draw),
                  )),
              space24,
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                activeColor: Colors.white,
                activeTrackColor: active,
                title: Text(
                  infoByEmail,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: black,
                      ),
                ),
                value: info,
                onChanged: (value) {
                  setState(() {
                    info = value;
                  });
                },
              ),
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                activeColor: Colors.white,
                activeTrackColor: active,
                title: Text(
                  productByEmail,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: black,
                      ),
                ),
                value: product,
                onChanged: (value) {
                  setState(() {
                    product = value;
                  });
                },
              ),
              space36,
              MainButton(
                onPressed: () {},
                text: request,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
