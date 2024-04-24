import 'package:etsppb/db/BooksDatabase.dart';
import 'package:etsppb/model/book.dart';
import 'package:flutter/material.dart';

class DetailBook extends StatelessWidget {
  final Book book;
  const DetailBook({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Book Detail',
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
      body: Column(
        children: <Widget>[

          // image
          Image.network(book.coverUrl),
          SizedBox(height: 10,),
          // title
          Row(
            children: [
              Text(
                book.title,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
              IconButton(onPressed: () async{
                await BooksDatabase.instance.delete(book.id!);
                // print('Dihapus');
                // print(book)
                // balik
                Navigator.of(context).pop();

              }, icon: const Icon(Icons.delete))
            ],
          ),
          SizedBox(height: 3,),
          Row(
            children: [
              Text(book.createdTime.toString())
            ],
          ),
          // description
          Row(
            children: [
              Text(book.description,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black
                ),),
            ],
          )
        ],
      ),
    );
  }
}
