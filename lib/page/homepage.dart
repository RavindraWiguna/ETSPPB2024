import 'package:etsppb/db/BooksDatabase.dart';
import 'package:etsppb/widget/BookWidget.dart';
import 'package:flutter/material.dart';
import '../model/book.dart';
import '../page/addEditBook.dart';

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
      body: Center(
        child: isLoading? CircularProgressIndicator():
        books.isEmpty? Text(
          'No Book yet',
          style: TextStyle(
              color: Colors.black,
              fontSize: 24
          ),
        ) : buildBooks(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[800],
        child: const Icon(
            Icons.add,
            color: Colors.white,
        ),
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddEditBook(book: null)
          ));
        },
      ),
    );
  }

  Widget buildBooks(){
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2
        ),
        itemCount: books.length,
        itemBuilder: (BuildContext ctx, index) {
          return BookWidget(
            title: books[index].title,
            coverUrl: books[index].coverUrl,
            description: books[index].description,
            bookId: books[index].id,
          );
        });
  }
}
