import 'package:etsppb/db/BooksDatabase.dart';
import 'package:etsppb/model/book.dart'; // ( auto fill dari android studio)
import 'package:flutter/material.dart';
import '../widget/BookFormWidget.dart';


class AddEditBook extends StatefulWidget {
  final Book? book;

  const AddEditBook({super.key, this.book});

  @override
  State<AddEditBook> createState() => _AddEditBookState();
}

class _AddEditBookState extends State<AddEditBook> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String coverUrl;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.book?.title?? '';
    coverUrl = widget.book?.coverUrl??'';
    description = widget.book?.description ?? '';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [buildButton()],
      ),
      body: Form(
        key: _formKey,
        child: BookFormWidget(
          title: title,
          description: description,
          coverUrl: coverUrl,
          onChangedTitle: (title) => setState(() {
            this.title=title;
          }),
          onChangedCoverUrl: (url) => setState(() {
            this.coverUrl=url;
          }),
          onChangedDescription: (desc) => setState(() {
            this.description=desc;
          }),
        ),
      ),
    );
  }

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: const Text('Save Book'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.book != null;

      if (isUpdating) {
        await updateBook();
      } else {
        await addBook();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateBook() async {
    final updatedBook = widget.book!.copy(
      title: title,
      description: description,
      coverUrl: coverUrl,
    );

    await BooksDatabase.instance.update(updatedBook);
  }

  Future addBook() async {
    final newBook = Book(
      title: title,
      coverUrl: coverUrl,
      description: description,
      createdTime: DateTime.now(),
    );

    await BooksDatabase.instance.create(newBook);
  }
}
