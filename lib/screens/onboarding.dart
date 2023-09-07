import 'package:care_provider_on_adolescent_girls_mobile/screens/home.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          Expanded(
              child: PageView.builder(
            itemCount: demo_data.length,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _pageIndex = index;
              });
            },
            itemBuilder: (context, index) => onboardingContent(
              title: demo_data[index].title,
              image: demo_data[index].image,
            ),
          )),
          onBoardingNavigation(
              pageIndex: _pageIndex, pageController: _pageController),
        ],
      ),
    );
  }
}

class onBoardingNavigation extends StatelessWidget {
  const onBoardingNavigation({
    super.key,
    required int pageIndex,
    required PageController pageController,
  })  : _pageIndex = pageIndex,
        _pageController = pageController;

  final int _pageIndex;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return _pageIndex == demo_data.length - 1
        ? Container(
            padding: const EdgeInsets.only(bottom: 10),
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.only(left: 50, right: 50),
              height: 60,
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: const Color(0xFF376AED)),
                child: const Text(
                  'Get Started',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.only(bottom: 10),
            color: Colors.white,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  child: Text('Skip'),
                ),
                const SizedBox(
                  width: 50,
                ),
                ...List.generate(
                  demo_data.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: DotIndicator(
                      isActive: index == _pageIndex,
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 60,
                  width: 88,
                  child: ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.ease);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: const Color(0xFF376AED)),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
              ],
            ),
          );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 18 : 12,
      decoration: BoxDecoration(
          color: isActive ? const Color(0xFF376AED) : Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}

class Onboard {
  late final String title;
  late final String image;
  late final String note;

  Onboard({required this.title, required this.image, required this.note});
}

final List<Onboard> demo_data = [
  Onboard(
    title: 'Health promotion and SRH counselling services',
    image: 'assets/images/13.png',
    note: '',
  ),
  Onboard(
    title: 'Contraceptive counselling and services',
    image: 'assets/images/13.png',
    note: '',
  ),
  Onboard(
    title: 'Comprehensive abortion care',
    image: 'assets/images/13.png',
    note: '',
  ),
  Onboard(
    title: 'Prevention and treatment of STIs/HIV',
    image: 'assets/images/14.png',
    note: '',
  ),
  Onboard(
    title: 'Maternal and newborn health care services',
    image: 'assets/images/15.png',
    note: '',
  ),
  Onboard(
    title: 'Adolescent Nutrition',
    image: 'assets/images/16.png',
    note: '',
  ),
  Onboard(
    title: 'Gender-based violence',
    image: 'assets/images/17.png',
    note: '',
  ),
];

class onboardingContent extends StatelessWidget {
  const onboardingContent(
      {super.key, required this.title, required this.image});
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontFamily: 'Urbanist-Italic', fontSize: 24),
        ),
        Image.asset(image),
        Text(
          'Read the article you want \n'
          'instantly',
          style: TextStyle(fontFamily: 'Urbanist-Italic', fontSize: 24),
        ),
      ],
    );
  }
}
