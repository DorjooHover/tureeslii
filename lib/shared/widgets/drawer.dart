import 'package:flutter/material.dart';
import 'package:landlord/shared/index.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer(
      {super.key,
      required this.selectedIndex,
      required this.onTap,
      required this.cancel});
  final int selectedIndex;
  final Function(int index) onTap;
  final Function() cancel;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: origin,
                right: origin,
                top: MediaQuery.of(context).padding.top + 13,
                bottom: 13),
            color: bgGray,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  imageLogo,
                  width: 100,
                ),
                IconButton(
                    onPressed: cancel,
                    icon: const Icon(Icons.close, color: black, size: 24))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(origin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80'),
                    ),
                    space16,
                    Text(
                      'Б.Нэлээн-Уртнэртэйнөхөр',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 24,
                      color: gray,
                    ))
              ],
            ),
          ),
          const Divider(
            color: navGray,
            height: 2,
          ),
          space20,
          ...navbar
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: origin),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      e['label']!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: black, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )
              .toList(),
          space20,
          const Divider(
            color: navGray,
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(origin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.language,
                      color: Colors.black,
                    ),
                    space16,
                    Text(
                      mn,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: black, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 24,
                      color: gray,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LocationDrawer extends StatelessWidget {
  const LocationDrawer({super.key, required this.selected});
  final List<int> selected;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: origin),
        decoration: BoxDecoration(color: bgGray, boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          )
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            ...addAdValues.map((e) {
              final i = addAdValues.indexOf(e);
              return LocationDrawerCard(
                  text: e,
                  isSelected:
                      selected.where((element) => i == element).isNotEmpty,
                  number: i + 1);
            }).toList(),
            space20,
            MainButton(width: double.infinity, onPressed: () {}, text: save),
          ],
        ),
      ),
    );
  }
}
