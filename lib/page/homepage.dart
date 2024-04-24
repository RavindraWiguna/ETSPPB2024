import 'package:etsppb/db/BooksDatabase.dart';
import 'package:flutter/material.dart';
import '../model/book.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Book> books;
  bool isLoading=false;

  Future refreshBooks() async{
    setState(() {
      isLoading=true;
    });

    // get book from db
    books = await BooksDatabase.instance.readAllBook();

    setState(() {
      isLoading=false;
    });
  }

  @override
  void initState(){
    super.initState();
    refreshBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Collections',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      // body: ,
      // floatingActionButton: FloatingActionButton(

      // ),
    );
  }
}
