import 'package:flutter/material.dart';

class BookWidget extends StatelessWidget {
  final String title;
  final String coverUrl;
  final String description;
  final int? bookId;
  // final Function() refresh;
  const BookWidget({super.key,
    required this.title,
    required this.coverUrl,
    required this.description, required this.bookId,
    // required this.refresh
  });

  // const BookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      child: Column(
        children: <Widget>[
          Image.network(coverUrl),
          const SizedBox(height: 3,),
          Text(title),
          const SizedBox(height: 3,),
          Text(description)
        ],
      ),
    );
  }
}
