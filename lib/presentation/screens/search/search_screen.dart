import 'package:care_provider_on_adolescent_girls_mobile/presentation/screens/pdf_viewer/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../../data/model/guideline.dart';
import '../reading_page/reading_screen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class SearchResult extends StatefulWidget {
  final List<Map<String, dynamic>> dataList;

  const SearchResult({Key? key, required this.dataList}) : super(key: key);

  @override
  SearchResultState createState() => SearchResultState();
}

// Function to load and parse JSON data from an asset file
Future<Map<String, dynamic>> loadJsonFromAsset(String assetPath) async {
  final jsonString = await rootBundle.loadString(assetPath);
  final jsonData = json.decode(jsonString);
  return jsonData;
}

// Create a Guideline instance from JSON data
Future<Guideline> createGuidelineFromJson(String filename) async {
  final jsonData = await loadJsonFromAsset('assets/files/$filename');

  Guideline guideline = Guideline.fromJson(jsonData);

  return guideline;
}

class SearchResultState extends State<SearchResult> {
  bool finishLoading = true;
  bool showClear = false;
  final TextEditingController inputController = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  List<Map<String, dynamic>> filteredData = [];

  @override
  void initState() {
    super.initState();
    filteredData = widget.dataList;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          focusNode: _focusNode,
          maxLines: 1,
          controller: inputController,
          style: TextStyle(color: Colors.grey[800], fontSize: 18),
          keyboardType: TextInputType.text,
          onSubmitted: (term) {
            setState(() {
              finishLoading = false;
            });
            filterData(term);
          },
          onChanged: (term) {
            setState(() {
              showClear = (term.length > 2);
            });
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(fontSize: 20.0),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          showClear
              ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    inputController.clear();
                    showClear = false;
                    setState(() {});
                  },
                )
              : Container(),
        ],
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedOpacity(
          opacity: finishLoading ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 100),
          child: buildContent(context),
        ),
        AnimatedOpacity(
          opacity: finishLoading ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: buildLoading(context),
        ),
      ],
    );
  }

  Widget buildLoading(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (BuildContext context, int index) {
        final item = filteredData[index];
        return ListTile(
          title: Text(
            item['title'].toUpperCase(),
          ),
          onTap: () async {
            Guideline guideline =
                await createGuidelineFromJson(item['filename']);

            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReadingScreen(
                    guideline: guideline, voiceDataPath: item['tts_file_name']),
              ),
            );
          },
        );
      },
    );
  }

  void filterData(String searchTerm) {
    if (searchTerm.isEmpty) {
      // If the search term is empty, show all the data.
      setState(() {
        filteredData = widget.dataList;
        finishLoading = true;
      });
    } else {
      // Filter the data based on the search term.
      setState(() {
        filteredData = widget.dataList.where((item) {
          final title = item['title'].toUpperCase();
          return title.contains(searchTerm.toUpperCase());
        }).toList();
        finishLoading = true;
      });
    }
  }
}
