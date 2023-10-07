import 'package:flutter/material.dart';

import '../reading_page/reading_screen.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<String> bookmarks = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    List<String> savedBookmarks = await BookmarkUtil.getBookmarks();
    setState(() {
      bookmarks = savedBookmarks;
    });
  }

  Future<void> _removeBookmark(String text) async {
    await BookmarkUtil.removeBookmark(text);
    _loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          String bookmarkedText = bookmarks[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(bookmarkedText),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _removeBookmark(bookmarkedText);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
