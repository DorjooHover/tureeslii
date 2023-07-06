import 'package:flutter/material.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/shared/index.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _HomeViewState();
}

class _HomeViewState extends State<BookmarkView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: origin, vertical: 24),
      child: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(
            vertical: origin,
          ),
          child: BookmarkCard(
            data: Apartment(),
          ),
        ),
        itemCount: 10,
      ),
    );
  }
}
