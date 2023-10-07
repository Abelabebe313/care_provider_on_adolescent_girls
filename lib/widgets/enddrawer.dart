import 'dart:developer';
import 'dart:io';

import 'package:care_provider_on_adolescent_girls_mobile/presentation/screens/about/about_us.dart';
import 'package:restart_app/restart_app.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/screens/bookmark/bookmark_page.dart';
import 'help_dialog.dart';

class EndDrawers extends StatefulWidget {
  const EndDrawers({super.key});

  @override
  State<EndDrawers> createState() => _EndDrawersState();
}

class _EndDrawersState extends State<EndDrawers> {
  Future<void> clearPreference(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Image.asset('assets/images/logo.png'),
          ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: Color(0xFF0E5120),
            ),
            title: const Text(
              'About Us',
              style: TextStyle(
                fontFamily: 'Urbanist-Bold',
                fontSize: 16,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AboutUs(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.bookmark_add_outlined,
              color: Color(0xFF0E5120),
            ),
            title: const Text(
              'Bookmarks',
              style: TextStyle(
                fontFamily: 'Urbanist-Bold',
                fontSize: 16,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BookmarkPage(),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.privacy_tip,
          //     color: Color(0xFF0E5120),
          //   ),
          //   title: const Text(
          //     'Privacy',
          //     style: TextStyle(
          //       fontFamily: 'Urbanist-Bold',
          //       fontSize: 16,
          //     ),
          //   ),
          //   onTap: () {
          //     // Handle Privacy action
          //     Navigator.pop(context); // Close the drawer
          //   },
          // ),

          ListTile(
            leading: const Icon(
              Icons.share,
              color: Color(0xFF0E5120),
            ),
            title: const Text(
              'Share This App',
              style: TextStyle(
                fontFamily: 'Urbanist-Bold',
                fontSize: 16,
              ),
            ),
            onTap: () async {
              // close the drawer
              Navigator.pop(context);

              // Share.share("com.example.care_provider_on_adolescent_girls_mobile");
              final result = await Share.shareWithResult(
                  'Center for Adolescent Girls Health. Download The App https://play.google.com/store/apps/details?id=com.example.care_provider_on_adolescent_girls_mobile');

              if (result.status == ShareResultStatus.success) {
                print('Thank you for sharing my website!');
              } else {
                log("Unabele to share");
                print('Unable to share');
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.help,
              color: Color(0xFF0E5120),
            ),
            title: const Text(
              'FAQs',
              style: TextStyle(
                fontFamily: 'Urbanist-Bold',
                fontSize: 16,
              ),
            ),
            onTap: () {
              // FAQDialog()
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FAQScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Color(0xFF0E5120),
            ),
            title: const Text(
              'Log Out',
              style: TextStyle(
                fontFamily: 'Urbanist-Bold',
                fontSize: 16,
              ),
            ),
            onTap: () async {
              await clearPreference('visited_before');
              // exit(0);
              Restart.restartApp();
            },
          ),
        ],
      ),
    );
  }
}
