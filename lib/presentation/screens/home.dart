import 'dart:async';
import 'package:care_provider_on_adolescent_girls_mobile/presentation/screens/home_cards.dart';
import 'search/search_screen.dart';
import '../widgets/enddrawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> data_list = [
    {
      'title': 'Health Promotion and SRH counselling services',
      'image': 'assets/images/counselling.png',
      'filename': 'chapter_1.json',
      'tts_file_name': 'chapter_1.wav',
    },
    {
      'title': 'CONTRACEPTIVE COUNSELLING AND SERVICES',
      'image': 'assets/images/counselling.png',
      'filename': 'chapter_1.json',
      'tts_file_name': 'chapter_1.wav',
    },
    {
      'title': 'COMPREHENSIVE ABORTION CARE',
      'image': 'assets/images/mother_care.png',
      'filename': 'chapter_1.json',
      'tts_file_name': 'chapter_1.wav',
    },
    {
      'title': 'Prevention and Treatment of STIs/HIV',
      'image': 'assets/images/HIV.png',
      'filename': 'chapter_1.json',
      'tts_file_name': 'chapter_1.wav',
    },
    {
      'title': 'Maternal and newborn health care services',
      'image': 'assets/images/violence.png',
      'filename': 'chapter_1.json',
      'tts_file_name': 'chapter_1.wav',
    },
    {
      'title': 'Gender Based Violence',
      'image': 'assets/images/doctor_monitoring.png',
      'filename': 'chapter_1.json',
      'tts_file_name': 'chapter_1.wav',
    },
    {
      'title': 'ADOLESCENT NUTRITION SERVICES',
      'image': 'assets/images/nutrition.png',
      'filename': 'chapter_1.json',
      'tts_file_name': 'chapter_1.wav',
    },
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
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(seconds: 1),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchResult(dataList: data_list),
                  ),
                );
              },
              child: Center(
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IgnorePointer(
                    ignoring: true, // Disable interaction with the text field
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search content...",
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
                            onPressed: () {},
                          ),
                        ),
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
                        'assets/images/slider 4.jpg',
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
                        'assets/images/slider 4.jpg',
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
                'Contents',
                style: TextStyle(
                  fontFamily: 'Urbanist-Bold',
                  color: Color(0xFF0E5120),
                  fontSize: 20,
                ),
              ),
            ),
            homeCards(data_list, context),
          ],
        ),
      ),
      endDrawer: EndDrawers(),
    );
  }
}
