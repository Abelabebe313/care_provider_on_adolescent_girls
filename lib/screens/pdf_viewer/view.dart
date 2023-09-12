import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PDFView extends StatefulWidget {
  final String title;
  final String fileName;
  final String ttsFileName;
  const PDFView(
      {super.key,
      required this.title,
      required this.fileName,
      required this.ttsFileName});

  @override
  State<PDFView> createState() => _PDFViewState();
}

enum TtsState { playing, stopped, paused, continued }

class _PDFViewState extends State<PDFView> {
  late PdfViewerController _pdfViewerController;
  late PdfTextSearchResult _searchResult;
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 1.0;
  double pitch = 0.9;
  double rate = 0.4;
  bool isCurrentLanguageInstalled = false;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;
  bool not_stopped = false;

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      if (mounted) {
        setState(() {
          log("Playing");
          ttsState = TtsState.playing;
        });
      }
    });

    if (isAndroid) {
      flutterTts.setInitHandler(() {
        if (mounted) {
          setState(() {
            log("TTS Initialized");
          });
        }
      });
    }

    flutterTts.setCompletionHandler(() {
      if (mounted) {
        setState(() {
          log("Complete");
          ttsState = TtsState.stopped;
        });
      }
    });

    flutterTts.setCancelHandler(() {
      if (mounted) {
        setState(() {
          log("Cancel");
          ttsState = TtsState.stopped;
        });
      }
    });

    flutterTts.setPauseHandler(() {
      if (mounted) {
        setState(() {
          log("Paused");
          ttsState = TtsState.paused;
        });
      }
    });

    flutterTts.setContinueHandler(() {
      if (mounted) {
        setState(() {
          log("Continued");
          ttsState = TtsState.continued;
        });
      }
    });

    flutterTts.setErrorHandler((msg) {
      if (mounted) {
        setState(() {
          log("Error: $msg");
          ttsState = TtsState.stopped;
        });
      }
    });
  }

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
    initTts();
    super.initState();
  }

  Future<dynamic> _getLanguages() async => await flutterTts.getLanguages;

  Future<dynamic> _getEngines() async => await flutterTts.getEngines;

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      log(engine.toString());
    }
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      log(voice.toString());
    }
  }

  Future _pause() async {
    var result = await flutterTts.stop();
    if (result == 1) {
      {
        setState(() {
          //not_stopped = true;
          ttsState = TtsState.stopped;
        });
      }
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> playTts() async {
    if (mounted) {
      setState(() {
        ttsState = TtsState.playing;
      });
    }

    String ttsFilePath = "assets/tts/${widget.ttsFileName}";
    log("Text: $ttsFilePath");

    try {
      final String ttsContent = await rootBundle.loadString(ttsFilePath);
      late String content = "Welcome. ";

      LineSplitter.split(ttsContent).forEach((line) {
        if (line.isNotEmpty) {
          content += line;
        }
      });
      await flutterTts.setVolume(volume);
      await flutterTts.setSpeechRate(rate);
      await flutterTts.setPitch(pitch);
      // await flutterTts.setSilence(2);
      //  await flutterTts.speak(content);
      var play;
      var count = content.length;
      log(count.toString());
      var max = 4000;
      var loopCount = count ~/ max;

      for (var i = 0; i <= loopCount; i++) {
        if (i != loopCount) {
          play = content.substring(i * max, (i + 1) * max);
          await flutterTts.speak(play);
        } else {
          var end = (count - ((i * max)) + (i * max));
          play = content.substring(i * max, end);
          await flutterTts.speak(play);
        }
      }

      log("Text is Readed");
      if (mounted) {
        setState(() {
          ttsState = TtsState.stopped;
        });
      }
    } catch (e) {
      log("Can't load file: $e");
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 16),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Color.fromARGB(255, 15, 15, 15),
            ),
            onPressed: () {
              _searchResult = _pdfViewerController.searchText('',
                  searchOption: TextSearchOption.caseSensitive);
              if (kIsWeb) {
                if (mounted) {
                  setState(() {});
                }
              } else {
                _searchResult.addListener(() {
                  if (_searchResult.hasResult) {
                    setState(() {});
                  }
                });
              }
            },
          ),
          IconButton(
            icon: Icon(
              ttsState == TtsState.playing ? Icons.pause : Icons.volume_up,
              color: const Color.fromARGB(255, 39, 39, 39),
            ),
            onPressed: () async {
              if (ttsState == TtsState.playing) {
                _pause();
              } else {
                playTts();
              }
            },
          ),
          Visibility(
            visible: _searchResult.hasResult,
            child: IconButton(
              icon: const Icon(
                Icons.clear,
                color: Color.fromARGB(255, 15, 15, 15),
              ),
              onPressed: () {
                if (mounted) {
                  setState(() {
                    _searchResult.clear();
                  });
                }
              },
            ),
          ),
          Visibility(
            visible: _searchResult.hasResult,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_up,
                color: Color.fromARGB(255, 15, 15, 15),
              ),
              onPressed: () {
                _searchResult.previousInstance();
              },
            ),
          ),
          Visibility(
            visible: _searchResult.hasResult,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Color.fromARGB(255, 15, 15, 15),
              ),
              onPressed: () {
                _searchResult.nextInstance();
              },
            ),
          ),
        ],
      ),
      body: SfPdfViewer.asset(
        'assets/files/${widget.fileName}',
        controller: _pdfViewerController,
        currentSearchTextHighlightColor: Colors.yellow.withOpacity(0.6),
        otherSearchTextHighlightColor: Colors.yellow.withOpacity(0.3),
      ),
    );
  }
}
