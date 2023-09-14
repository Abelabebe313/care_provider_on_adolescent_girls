import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_icons/simple_icons.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  Future<void> _launchSocialMediaAppIfInstalled({
    required String url,
  }) async {
    try {
      bool launched = await launch(url,
          forceSafariVC: false); // Launch the app if installed!

      if (!launched) {
        launch(url); // Launch web view if app is not installed!
      }
    } catch (e) {
      launch(url); // Launch web view if app is not installed!
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 250,
            height: 100,
            child: Image.asset('assets/icon/logo.png'),
          ),
          const Text(
            'Center for Adolescent Girls’ Health',
            style: TextStyle(
              fontFamily: 'Urbanist-Bold',
              color: Color(0xFF0E5120),
              fontSize: 20,
            ),
          ),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  _launchSocialMediaAppIfInstalled(
                      url: 'cagh@adolescentgirlseth.org');
                },
                child: const Text(
                  'cagh@adolescentgirlseth.org',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF0E5120),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _launchSocialMediaAppIfInstalled(
                      url: 'https://aster1621@gmail.com');
                },
                child: const Text(
                  'aster1621@gmail.com',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF0E5120),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _launchSocialMediaAppIfInstalled(
                      url: 'https://cpd@adolescentgirlseth.org');
                },
                child: const Text(
                  'cpd@adolescentgirlseth.org',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF0E5120),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'The Center for Adolescent Girls’ Health (CAGH) was established by a pool of volunteer experts as a non-profit organization and registered under the Ethiopian Authority for Civil Society Organizations (ACSO) and given legal personality under registration number 5998. The CAGH promotes and advocates for the quality and equity of health care services for girls, women, and children, as well as improving health care services in any setting for adolescent girls and preventing teen pregnancy.',
              style: TextStyle(
                fontFamily: 'Urbanist-Regular',
                fontSize: 14,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  _launchSocialMediaAppIfInstalled(url: 'https://t.me/');
                },
                icon: const Icon(
                  SimpleIcons.telegram,
                  color: Color(0xFF0E5120),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  _launchSocialMediaAppIfInstalled(
                      url: 'https://www.linkedin.com/');
                },
                icon: const Icon(
                  SimpleIcons.linkedin,
                  color: Color(0xFF0E5120),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  _launchSocialMediaAppIfInstalled(url: 'https://github.com/');
                },
                icon: const Icon(
                  SimpleIcons.github,
                  color: Color(0xFF0E5120),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  _launchSocialMediaAppIfInstalled(
                      url: 'https://www.facebook.com/');
                },
                icon: const Icon(
                  SimpleIcons.facebook,
                  color: Color(0xFF0E5120),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
