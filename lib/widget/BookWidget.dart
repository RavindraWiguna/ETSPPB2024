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
          // Container(
          //     margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
          //     child: Image.network(coverUrl,
          //     fit: BoxFit.fitWidth)
          //
          // ),
          SizedBox(
            height: 150,
            child: Image.network(coverUrl, fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter,),
          ),
          const SizedBox(height: 3,),
          Text(title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),),
          const SizedBox(height: 3,),
          // Text(description,
          // style: TextStyle(
          //   color: Colors.white,
          //   fontSize: 17
          // ),)
        ],
      ),
    );
  }
}
