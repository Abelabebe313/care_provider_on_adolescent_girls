import 'package:care_provider_on_adolescent_girls_mobile/screens/pdf_viewer/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SearchResult extends StatefulWidget {
  final String keyword;
  final List<Map<String, dynamic>> data_list;

  const SearchResult(
      {super.key, required this.keyword, required this.data_list});

  @override
  SearchResultState createState() => SearchResultState();
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
    filteredData = widget.data_list;
    // Schedule the request for focus after the widget is built.
    SchedulerBinding.instance?.addPostFrameCallback((_) {
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
          focusNode: _focusNode, // Assign the focus node here
          maxLines: 1,

          controller: inputController,
          style: TextStyle(color: Colors.grey[800], fontSize: 18),
          keyboardType: TextInputType.text,
          onSubmitted: (term) {
            setState(() {
              finishLoading = false;
            });
            delayShowingContent();
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFView(
                  title: item['title'].toUpperCase(),
                  fileName: item['filename'],
                  ttsFileName: item['tts_file_name'],
                ), // Navigate to PDFViewPage
              ),
            );
          },
        );
      },
    );
  }

  void delayShowingContent() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        finishLoading = true;
      });
    });
  }
}
