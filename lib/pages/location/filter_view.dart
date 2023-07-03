import 'package:flutter/material.dart';
import 'package:tureeslii/shared/index.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  @override
  String sex = male;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGray,
      appBar: MainAppBar(
        bgColor: Colors.white,
        statusBarColor: Colors.white,
        back: true,
        logo: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: origin, vertical: large),
            child: Column(
              children: [
                space45,
                MenuContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        settings.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: profileTitle,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      space16,
                      Divider(
                        color: divider,
                        height: 1,
                        thickness: 1,
                      ),
                      space24,
                    ],
                  ),
                ),
                space45,
                MenuContainer(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AdditionCard(title: birthday, child: Input()),
                    space24,
                    AdditionCard(
                        title: gender,
                        child: RowRadio(
                          groupValue: sex,
                          onChanged: (value) {
                            setState(() {
                              sex = value!;
                            });
                          },
                          list: [male, female],
                        )),
                    space24,
                    AdditionCard(title: family, child: Input()),
                    space24,
                    // AdditionCard(
                    //     title: isWork,
                    //     child: RowRadio(
                    //       groupValue: workStatus,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           workStatus = value!;
                    //         });
                    //       },
                    //       list: [working, studying],
                    //     )),

                    space24,
                    AdditionCard(
                        title: briefInformation,
                        child: Input(
                          maxLine: 3,
                          textInputType: TextInputType.multiline,
                          onChange: (p0) {},
                        )),
                    space24,
                    MainButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: const EdgeInsets.symmetric(
                          vertical: small, horizontal: 24),
                      text: search,
                    )
                  ],
                ))
              ],
            )),
      ),
    );
  }
}
