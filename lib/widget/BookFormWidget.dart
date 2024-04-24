import 'package:flutter/material.dart';

class BookFormWidget extends StatelessWidget {
  final String? title;
  final String? coverUrl;
  final String? description;

  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedCoverUrl;
  final ValueChanged<String> onChangedDescription;

  const BookFormWidget({
    super.key,
    this.title = '',
    this.coverUrl = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedCoverUrl,
    required this.onChangedDescription,
  });

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // isi title nya
          buildTitle(),
          const SizedBox(height: 8,),
          buildCoverUrl(),
          const SizedBox(height: 8,),
          buildDescription(),
          const SizedBox(height: 16,)
        ],
      ),
    );
  }

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    style: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Title',
      hintStyle: TextStyle(color: Colors.black),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'The title cannot be empty' : null,
    onChanged: onChangedTitle,
    keyboardType: TextInputType.text,
  );

  Widget buildCoverUrl() => TextFormField(
    maxLines: 1,
    initialValue: coverUrl,
    style: TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
    decoration: const InputDecoration(
      border: InputBorder.none ,
      hintText: 'Type/Paste Book cover url here...',
      hintStyle: TextStyle(color: Colors.black),
    ),
    validator: (url) {
      if(url == null || url.isEmpty){
        return 'For now Cover URL must be provided';
      }

      if(!Uri.parse(url).isAbsolute){
        return 'URL provided is invalid';
      }
      return null;
    },
    onChanged: onChangedCoverUrl,
    keyboardType: TextInputType.text,
  );

  Widget buildDescription() => TextFormField(
    maxLines: 5,
    initialValue: description,
    style: const TextStyle(color: Colors.black, fontSize: 18),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Type something...',
      hintStyle: TextStyle(color: Colors.black),
    ),
    validator: (title) => title != null && title.isEmpty
        ? 'The description cannot be empty'
        : null,
    onChanged: onChangedDescription,
    keyboardType: TextInputType.text,
  );
}