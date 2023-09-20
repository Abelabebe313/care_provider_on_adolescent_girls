import 'package:flutter/material.dart';

import '../../data/model/guideline.dart';
import 'reading_page/reading_screen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

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

Widget homeCards(List<Map<String, dynamic>> data_list, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: Container(
      color: const Color(0xffF8FAFF),
      width: MediaQuery.of(context).size.width * 0.93,
      height: MediaQuery.of(context).size.height * 0.58,
      child: ListView.builder(
        itemCount: data_list.length,
        itemBuilder: (context, index) {
          final data = data_list[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () async {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PDFView(
                //       title: data['title'].toUpperCase(),
                //       fileName: data['filename'],
                //       ttsFileName: data['tts_file_name'],
                //     ), // Navigate to PDFViewPage
                //   ),
                // );

                Guideline guideline =
                    await createGuidelineFromJson(data['filename']);

                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadingScreen(guideline: guideline,
                   voiceDataPath:data['tts_file_name'] ),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.18,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(190, 196, 202, 0.2),
                      blurRadius: 14,
                      offset: Offset(0, 9),
                    ),
                  ],
                ),
                child: Card(
                  surfaceTintColor: Colors.white,
                  margin: const EdgeInsets.all(0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 110,
                        child: Image.asset(data['image']),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            // textAlign: TextAlign.left,
                            data['title'].toUpperCase(),
                            maxLines: 4,
                            style: const TextStyle(
                                fontSize: 17, fontFamily: "Urbanist-Regular"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
