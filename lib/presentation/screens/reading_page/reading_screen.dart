import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:care_provider_on_adolescent_girls_mobile/core/my_colors.dart';
import 'package:care_provider_on_adolescent_girls_mobile/core/my_text.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../core/img.dart';
import '../../../data/model/guideline.dart';

class ReadingScreen extends StatefulWidget {
  final Guideline guideline;
  final String voiceDataPath;

  const ReadingScreen(
      {super.key, required this.guideline, required this.voiceDataPath});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  bool isBookmarked = false;
  late int expandedIndex; // Track the index of the currently expanded panel
  String theTextToBookmark = "Sample";
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
      });
    });

    // First panel is expanded by default
    expandedIndex = 0;
  }

  void _onPanelTapped(int index) {
    log("clicked: $index");
    setState(() {
      // Toggle the expansion state
      if (expandedIndex == index) {
        expandedIndex = -1; // Collapse the panel if it's already expanded
      } else {
        expandedIndex = index; // Expand the tapped panel
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void _playPauseAudio() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      //final uri = Uri.file();
      await audioPlayer.play(AssetSource('tts/${widget.voiceDataPath}'));
    }

    setState(() {
      isPlaying = !isPlaying;
    });
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

  ExpansionPanel buildExpansionPanel(int index) {
    var title = widget.guideline.titles![index];
    var image = widget.guideline.images![index];
    var content = widget.guideline.content![index];

    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          contentPadding: const EdgeInsets.only(left: 10),
          title: GestureDetector(
            onTap: () {
              _onPanelTapped(index);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title.substring(1).replaceAll('\\n', '\n'),
                  style: MyText.headline(context)!.copyWith(
                      color: MyColors.grey_90,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        );
      },
      body: Column(
        children: [
          // Display image if available
          if (image.isNotEmpty && image.startsWith("assets/"))
            Image.asset(
              Img.get(image),
              fit: BoxFit.cover,
              height: 200,
            ),
          // Display description if available and if expanded
          if (expandedIndex == index && content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
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
      ),
      isExpanded: expandedIndex == index,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
      interactive: true,
      thickness: 6,
      radius: const Radius.circular(30),
      child: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          backgroundColor: MyColors.grey_10,
          floating: true,
          pinned: false,
          snap: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: MyColors.grey_60),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: isBookmarked ? Colors.blue : MyColors.grey_60,
              ),
              onPressed: () {
                setState(() {
                  isBookmarked = !isBookmarked;
                  if (isBookmarked) {
                    BookmarkUtil.addBookmark(theTextToBookmark);
                  } else {
                    BookmarkUtil.removeBookmark(theTextToBookmark);
                  }
                });
              },
            ),
            IconButton(
              icon: Icon(
                isPlaying ? Icons.pause : Icons.volume_up,
                color: MyColors.grey_60,
              ),
              onPressed: _playPauseAudio,
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: widget.guideline.titles!.length,
              (BuildContext context, int index) {
                return ExpansionPanelList(
                  dividerColor: Colors.black,
                  elevation: 1,
                  expandedHeaderPadding: const EdgeInsets.all(0),
                  expansionCallback: (int panelIndex, bool isExpanded) {
                    _onPanelTapped(index); // Handle expansion state
                  },
                  children: [
                    buildExpansionPanel(index),
                  ],
                );
              },
            ),
          ),
        ),
      ]),
    ));
  }
}

class ExpansionItem {
  final String title;
  final String image;
  final String content;
  bool isExpanded;

  ExpansionItem({
    required this.title,
    required this.image,
    required this.content,
    required this.isExpanded,
  });
}

class BookmarkUtil {
  static const String _bookmarkKey = 'bookmarks';

  static Future<List<String>> getBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? bookmarks = prefs.getStringList(_bookmarkKey);
    return bookmarks ?? [];
  }

  static Future<void> addBookmark(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = await getBookmarks();
    bookmarks.add(text);
    await prefs.setStringList(_bookmarkKey, bookmarks);
  }

  static Future<void> removeBookmark(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = await getBookmarks();
    bookmarks.remove(text);
    await prefs.setStringList(_bookmarkKey, bookmarks);
  }
}
