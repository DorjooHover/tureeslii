import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/controllers.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MyAdsCard extends StatelessWidget {
  const MyAdsCard({
    super.key,
    required this.post,
    this.onPressed,
  });
  final Post post;

  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());

    String status = '';

    Color statusColor = Colors.transparent;
    switch (post.status?.toLowerCase()) {
      case 'active':
        status = 'Нийтлэгдсэн';
        statusColor = green;
        break;
      case 'rented':
        status = 'Шалгаж байна';
        statusColor = checkingBlack;
        break;
      case 'rejected':
        status = 'Буцаагдсан';
        statusColor = returnedRed;
        break;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          post.title ?? '',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold, color: black),
        ),
        space13,
        RichText(
          text: TextSpan(
            text: '${post.district} - · ',
            style:
                Theme.of(context).textTheme.labelSmall!.copyWith(color: gray),
            children: <TextSpan>[
              TextSpan(
                text: '${post.category?["name"] ?? ''} · ',
              ),
              TextSpan(
                  text: DateTime.parse(post.postDate!)
                      .toString()
                      .substring(0, 10)),
            ],
          ),
        ),
        space6,
        RichText(
          text: TextSpan(
            text:
                '${currencyFormat(post.monthlyRent! ? post.price! : post.priceDaily!, false)} ',
            style: Theme.of(context).textTheme.titleLarge,
            children: <TextSpan>[
              TextSpan(
                  text: '₮/${post.monthlyRent! ? 'сар' : 'хоног'}',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: gray, fontWeight: FontWeight.w400)),
            ],
          ),
        ),
        space32,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (post.status?.toLowerCase() != 'rejected')
              Flexible(
                child: Row(
                  mainAxisAlignment: post.status == null
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    MainButton(
                      height: 26,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: origin),
                      onPressed: onPressed ?? () {},
                      child: RichText(
                        text: TextSpan(
                          text: req,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white),
                          children: <TextSpan>[
                            TextSpan(
                                text: ': ${post.rentRequests?.length ?? 0}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    space8,
                    RichText(
                      text: TextSpan(
                        text: view,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: gray),
                        children: <TextSpan>[
                          TextSpan(
                              text: ': ${post.viewCount ?? 0}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: black,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (status != '')
              Flexible(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(15)),
                    height: 26,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      status,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ),
                  space10,
                  if (post.status?.toLowerCase() == "rejected")
                    Text(
                      fakeInfo,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: gray, fontWeight: FontWeight.w300),
                    )
                ],
              ))
          ],
        ),
        space16,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MainButton(
              onPressed: () {
                controller.createPost.value = post;
                Get.toNamed(Routes.location);
              },
              text: edit,
              padding: const EdgeInsets.symmetric(horizontal: large),
            ),
            MainButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertContainer(
                      child: [
                        Text(
                          deletePost,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: black),
                        ),
                        space32,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            MainButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              padding: const EdgeInsets.symmetric(
                                  vertical: small, horizontal: 24),
                              text: no,
                            ),
                            MainButton(
                              onPressed: () {
                                controller.deletePost(
                                    post.id.toString(), context);
                              },
                              color: red,
                              padding: const EdgeInsets.symmetric(
                                  vertical: small, horizontal: 24),
                              text: yes,
                            ),
                          ],
                        ),
                        space36
                      ],
                    );
                  },
                );
              },
              text: delete,
              color: red,
              padding: const EdgeInsets.symmetric(horizontal: large),
            ),
            // MainButton(onPressed: () {}, text: 'asdf',)
          ],
        ),
      ],
    );
  }
}

class NotEnoughCard extends StatelessWidget {
  const NotEnoughCard(
      {super.key,
      required this.onTap,
      required this.selected,
      required this.onPress,
      required this.date});
  final Function() onTap;
  final Function(int e) onPress;
  final String date;

  final List<int> selected;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextButton(
            onPressed: onTap,
            child: Text(
              date,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: black, fontWeight: FontWeight.bold),
            )),
        space16,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [1, 2, 3, 4, 5, 6, 7]
              .map((e) => GestureDetector(
                    onTap: onPress(e),
                    child: Container(
                        margin: const EdgeInsets.only(left: 11),
                        alignment: Alignment.center,
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                            color: selected.where((s) => s == e).isNotEmpty
                                ? blue
                                : sliderGray,
                            borderRadius: BorderRadius.circular(100)),
                        child: Text(
                          '$e',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      selected.where((s) => s == e).isNotEmpty
                                          ? Colors.white
                                          : gray,
                                  fontWeight: FontWeight.bold),
                        )),
                  ))
              .toList(),
        )
      ],
    );
  }
}

class RentRequestCard extends StatelessWidget {
  const RentRequestCard(
      {super.key, required this.data, this.shadow = true, this.borderRadius});
  final Post data;
  final bool shadow;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          if (shadow)
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15)
        ],
        borderRadius: borderRadius ?? BorderRadius.circular(origin),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: data.postAttachments?.map((e) {
                    int i = data.postAttachments?.indexOf(e) ?? 0;

                    return Container(
                      margin: EdgeInsets.only(
                          right:
                              i + 1 != data.postAttachments!.length ? 10 : 0),
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: CachedNetworkImage(
                            imageUrl: '$fileUrl${e.fileThumb}',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Padding(
                              padding: EdgeInsets.all(4),
                              child: Center(
                                child: SizedBox(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                                Icons.error), // Widget to display on error
                          )),
                    );
                  }).toList() ??
                  [],
            ),
          ),
          space16,
          Text(
            data.title ?? '',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold, color: black),
          ),
          space13,
          RichText(
            text: TextSpan(
              text: '${data.district ?? ''} - · ',
              style:
                  Theme.of(context).textTheme.labelSmall!.copyWith(color: gray),
              children: <TextSpan>[
                TextSpan(
                  text: '${data.category?['name'] ?? ''} · ',
                ),
                TextSpan(
                    text: DateTime.parse(data.postDate!)
                        .toString()
                        .substring(0, 10)),
              ],
            ),
          ),
          space6,
          RichText(
            text: TextSpan(
              text:
                  '${currencyFormat(data.monthlyRent! ? data.price! : data.priceDaily!, false)} ',
              style: Theme.of(context).textTheme.titleLarge,
              children: <TextSpan>[
                TextSpan(
                    text: '₮/${data.monthlyRent! ? 'сар' : 'хоног'}',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: gray, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.data,
  });
  final RentRequest data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: origin, vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  'https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                  width: 59,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              space16,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${data.user!.firstname!.substring(0, 1)}.${data.user!.lastname}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: black, fontWeight: FontWeight.bold),
                  ),
                  space2,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.phone,
                        size: 16,
                        color: green,
                      ),
                      space4,
                      Text(
                        data.user?.mobile ?? '',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: black, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          space16,
          RichText(
            text: TextSpan(
              text: 'Түрээслэх хугацаа: ',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: black),
              children: <TextSpan>[
                TextSpan(
                  text: data.duration! > 30
                      ? '${(data.duration! ~/ 30)} сар ${(data.duration! % 30)} өдөр}'
                      : '${data.duration!} өдөр',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          space24,
          SizedBox(
            width: MediaQuery.of(context).size.width - large,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: MainButton(
                  borderRadius: 20,
                  onPressed: () {},
                  color: green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      ),
                      space8,
                      Text(
                        agree,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white),
                      )
                    ],
                  ),
                )),
                space16,
                Expanded(
                    child: MainButton(
                  color: Colors.transparent,
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.close,
                        size: 16,
                        color: red,
                      ),
                      space8,
                      Text(
                        decline,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: red),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AgreedRequestCard extends StatelessWidget {
  const AgreedRequestCard({super.key, required this.data, this.child});
  final RentRequest data;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: origin, vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  'https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                  width: 59,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              space16,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${data.user!.firstname!.substring(0, 1)}.${data.user!.lastname}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: black, fontWeight: FontWeight.bold),
                  ),
                  space2,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.phone,
                        size: 16,
                        color: green,
                      ),
                      space4,
                      Text(
                        data.user?.mobile ?? '',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: black, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          space16,
          AnimatedDateSlider(
            startDate: DateTime(2023, 11, 1),
            endDate: DateTime(2023, 11, 24),
          ),
          child ?? space36,
          if (child == null)
            SizedBox(
              width: MediaQuery.of(context).size.width - large,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    remainder,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: black),
                  ),
                  Text(
                    '${currencyFormat(5000000, false)}₮',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: red, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key, required this.data});
  final RentRequest data;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              width: 78,
              height: 78,
              alignment: Alignment.center,
              imageUrl:
                  '${data.post!.postAttachments!.isNotEmpty ? '$fileUrl${data.post!.postAttachments!.first}' : 'https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80'}',
              fit: BoxFit.cover,
              placeholder: (context, url) => const Padding(
                padding: EdgeInsets.all(4),
                child: Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error), // Widget to display on error
            )),
        space16,
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width - 94 - 32,
              child: Text(
                data.post?.title ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: black, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            space8,
            Row(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      imageUrl:
                          '${data.user?.profilePic != '' ? '$fileUrl${data.user!.profilePic!}' : 'https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80'}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(4),
                        child: Center(
                          child: SizedBox(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error), // Widget to display on error
                    )),
                space6,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${data.user!.firstname!.substring(0, 1)}.${data.user!.lastname}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: black),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.phone,
                          size: 16,
                          color: green,
                        ),
                        space4,
                        Text(
                          data.user?.mobile ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: black, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
