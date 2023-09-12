import 'dart:async';
import 'package:care_provider_on_adolescent_girls_mobile/screens/home_cards.dart';
import 'package:care_provider_on_adolescent_girls_mobile/screens/pdf_viewer/view.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> titleList = [
    'INTRODUCTION',
    'ADOLESCENT SEXUAL AND REPRODUCTIVE HEALTH SERVICE',
    'CONTRACEPTIVE COUNSELLING AND SERVICES',
    'COMPREHENSIVE ABORTION CARE',
    'Sexually Transmitted Infections Preventions, Control and Treatment',
    'HIV PREVENTION, CONTROL AND TREATMENT',
    'Antenatal, Intrapartum and Postnatal Care Services',
    'GENDER BASED VIOLENCE SERVICES',
    'ADOLESCENT NUTRITION SERVICES',
    'MONITORING',
    'SUMMARY',
  ];

  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;
  int current = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF8FAFF),
        appBar: AppBar(
          backgroundColor: const Color(0xffF8FAFF),
          title: Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Image.asset('assets/images/title.png'),
            ),
          ),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              // Search Bar
              Center(
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search an article...",
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins-ExtraLight',
                        color: Colors.grey.shade400,
                        fontSize: 15,
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 10, top: 12, bottom: 12), // Add padding here
                      border: InputBorder.none,
                      suffixIcon: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0E5120),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.search,
                            size: 32,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PDFView(
                                  title: 'Introduction',
                                  fileName: 'introduction_file_0.pdf',
                                ), // Navigate to PDFViewPage
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // Slider poster
              Container(
                height: 130,
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  // scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width),
                      child: ClipRRect(
                        child: Image.asset(
                          'assets/images/slider 1.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width),
                      child: ClipRRect(
                        child: Image.asset(
                          'assets/images/slider 2.png.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width),
                      child: ClipRRect(
                        child: Image.asset(
                          'assets/images/slider 3.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Text(
                  'Catagories',
                  style: TextStyle(
                    fontFamily: 'Urbanist-Regular',
                    color: Color(0xFF0E5120),
                    fontSize: 20,
                  ),
                ),
              ),
              homeCards(titleList, context),
            ],
          ),
        ));
  }
}
