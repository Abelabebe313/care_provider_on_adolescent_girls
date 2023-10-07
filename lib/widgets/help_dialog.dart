import 'package:flutter/material.dart';

import '../core/my_colors.dart';

class FAQScreen extends StatelessWidget {
  final List<FAQItem> _faqs = [
    FAQItem(
      question: 'What is the Center for Adolescent Girls’ Health (CAGH)?',
      answer:
          'The Center for Adolescent Girls’ Health (CAGH) was established by a pool of volunteer experts as a non-profit organization and registered under the Ethiopian Authority for Civil Society Organizations (ACSO) and given legal personality under registration number 5998. The CAGH promotes and advocates for the quality and equity of health care services for girls, women, and children, as well as improving health care services in any setting for adolescent girls and preventing teen pregnancy.',
      isExpanded: true,
    ),
    FAQItem(
      question: 'What services does CAGH provide?',
      answer:
          'CAGH provides quality and equitable health care services for girls, women, and children. They focus on improving healthcare services for adolescent girls and work towards preventing teen pregnancy.',
      isExpanded: false,
    ),
    // Add more FAQ items as needed
  ];

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
        title: Text('FAQs'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _faqs.map<Widget>((FAQItem faq) {
            return ExpansionPanelList(
              elevation: 1,
              expandedHeaderPadding: const EdgeInsets.all(0),
              children: [
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(faq.question),
                    );
                  },
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(faq.answer),
                  ),
                  isExpanded: faq.isExpanded,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FAQItem {
  String question;
  String answer;
  bool isExpanded;

  FAQItem({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });
}
