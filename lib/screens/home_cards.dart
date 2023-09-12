import 'package:care_provider_on_adolescent_girls_mobile/screens/pdf_viewer/view.dart';
import 'package:flutter/material.dart';

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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PDFView(
                      title: data['title'].toUpperCase(),
                      fileName: data['filename'],
                      ttsFileName: data['tts_file_name'],
                    ), // Navigate to PDFViewPage
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
