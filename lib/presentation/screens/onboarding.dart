import 'package:care_provider_on_adolescent_girls_mobile/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
              note: demo_data[index].note,
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
                    backgroundColor: const Color(0xFF0E5120)),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  child: const Text(
                    'SKIP',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Spacer(),
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
                TextButton(
                  onPressed: () {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.ease);
                  },
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
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
      width: isActive ? 10 : 10,
      decoration: BoxDecoration(
          color: isActive ? const Color(0xFF0E5120) : Colors.grey,
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
    title: 'Health promotion and \n'
        'SRH counselling services',
    image: 'assets/images/habesha_girl.png',
    note:
        'Encourage adolescent clients to know the physical, psychological and social aspects of Sexual and reproductive health(SRH) care.',
  ),
  Onboard(
    title: 'Contraceptive counselling\n'
        '\t\t\t          and services',
    image: 'assets/images/contraceptive.png',
    note:
        'Service providers should provide counselling and services to adolescent girls to improve access to contraceptive services and to reduce occurrence of unplanned pregnancies',
  ),
  Onboard(
    title: 'Comprehensive abortion\n'
        '\t\t\t                care',
    image: 'assets/images/Diet Nutrition.jpg',
    note:
        'Health care providers provide a variety of individualized, culturally sensitive abortion-related care services for women.',
  ),
  Onboard(
    title: 'Prevention & treatment\n'
        '\t\t\t         of STIs/HIV',
    image: 'assets/images/iconmonstr-medical-16-240.png',
    note:
        'Sexually transmitted infections can be controlled through providing information and services',
  ),
  Onboard(
    title: 'Maternal & newborn\n'
        'health care services',
    image: 'assets/images/habesha_mom.png',
    note:
        'Healthcare providers who are motivated, competent, and compassionate should Create a safe, warm environment for the mother and newborn with high-quality care',
  ),
  Onboard(
    title: 'Adolescent Nutrition',
    image: 'assets/images/Diet Nutrition.jpg',
    note:
        "Protein, iron, and other micro nutrients are required to support adolescent growth and meet the body's increased demand for iron during menstruation.",
  ),
  Onboard(
    title: 'Gender-based violence',
    image: 'assets/images/violence.png',
    note:
        'Many women and girls are victims of violence. Midwives and other service providers should identify and assist GBV-affected women and girls',
  ),
];

class onboardingContent extends StatelessWidget {
  const onboardingContent(
      {super.key,
      required this.title,
      required this.image,
      required this.note});
  final String title;
  final String image;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins-SemiBold',
              fontSize: 22,
              color: const Color(0xFF0E5120),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Center(
            child: Image.asset(image), //Lottie.asset(image),
          ),
        ),
        Text(
          note,
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Urbanist-Light', fontSize: 17),
        ),
      ],
    );
  }
}
