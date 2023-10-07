import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../core/my_colors.dart';
import '../../../core/my_text.dart';
import '../reading_page/reading_screen.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<String> bookmarks = [];
  String title = 'Title';
  String content = 'Content';
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

  List<InlineSpan> parseText(String input) {
    List<InlineSpan> textSpans = [];

    RegExp exp = RegExp(r'<b>(.*?)<\/b>');

    List<RegExpMatch> matches = exp.allMatches(input).toList();

    int previousMatchEnd = 0;

    for (RegExpMatch match in matches) {
      // Add the non-bold text
      textSpans.add(
        TextSpan(
          text: input.substring(previousMatchEnd, match.start),
          style: MyText.subhead(context)!.copyWith(color: MyColors.grey_80),
        ),
      );

      // Add the bold text
      textSpans.add(
        TextSpan(
          text: match.group(1), // Extract the text within <b> tags
          style: MyText.subhead(context)!
              .copyWith(color: MyColors.grey_80, fontWeight: FontWeight.bold),
        ),
      );

      previousMatchEnd = match.end;
    }

    // Add any remaining non-bold text
    if (previousMatchEnd < input.length) {
      textSpans.add(
        TextSpan(
          text: input.substring(previousMatchEnd),
          style: MyText.subhead(context)!.copyWith(color: MyColors.grey_80),
        ),
      );
    }

    return textSpans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyColors.grey_90,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Bookmarks'),
      ),
      body: ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          String bookmarkedText = bookmarks[index];

          List<String> parts = bookmarkedText.split('|');

          if (parts.length >= 2) {
            title = parts[0].trim(); // Trim to remove leading/trailing spaces
            content = parts[1].trim(); // Trim to remove leading/trailing spaces

            // Now you can use the 'title' and 'content' variables as needed.
            log('Bookmark Loadded');
          } else {
            // Handle the case where the bookmarked text does not contain '|'
            log('Invalid bookmark format');
          }

          return Card(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _removeBookmark(bookmarkedText);
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(title.substring(1).replaceAll('\\n', '\n'),
                        style: MyText.headline(context)!.copyWith(
                            color: MyColors.grey_90,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        children: parseText(
                          content.replaceAll('\\n', '\n'),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
