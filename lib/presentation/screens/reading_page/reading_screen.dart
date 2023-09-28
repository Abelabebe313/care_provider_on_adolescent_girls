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

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
      });
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

  @override
  Widget build(BuildContext context) {
    List<Widget> guidelineItems = [];

    // Combine titles, images, and content into a single list
    List<String> combinedData = [];
    for (var i = 0; i < widget.guideline.titles!.length; i++) {
      combinedData.add(widget.guideline.titles![i]);
      combinedData.add(widget.guideline.images![i]);
      combinedData.add(widget.guideline.content![i]);
    }

    for (var data in combinedData) {
      // Check if the data is an image path
      if (data == "") {
        // do nothing
      } else if (data.startsWith("assets/")) {
        guidelineItems.add(
          Container(height: 20),
        );
        guidelineItems.add(SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.asset(
            Img.get(data),
            fit: BoxFit.cover,
          ),
        ));
      } else if (data.startsWith("x")) {
      } else if (data.startsWith("_")) {
        guidelineItems.add(
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(data.substring(1).replaceAll('\\n', '\n'),
                style: MyText.headline(context)!.copyWith(
                    color: MyColors.grey_90, fontWeight: FontWeight.bold)),
          ),
        );
      } else {
        guidelineItems.add(const Divider(height: 20));
        guidelineItems.add(Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              children: parseText(
                data.replaceAll('\\n', '\n'),
              ),
            ),
          ),
        ));
      }
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
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
                icon:
                    const Icon(Icons.bookmark_border, color: MyColors.grey_60),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.volume_up,
                  color: MyColors.grey_60,
                ),
                onPressed: _playPauseAudio, // Toggle play/pause
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate(guidelineItems),
            ),
          ),
        ],
      ),
    );
  }
}
