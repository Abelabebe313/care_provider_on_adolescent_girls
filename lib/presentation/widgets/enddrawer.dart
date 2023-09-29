import 'package:care_provider_on_adolescent_girls_mobile/presentation/screens/about/about_us.dart';
import 'package:restart_app/restart_app.dart';
import 'package:flutter/material.dart';

class EndDrawers extends StatefulWidget {
  const EndDrawers({super.key});

  @override
  State<EndDrawers> createState() => _EndDrawersState();
}

class _EndDrawersState extends State<EndDrawers> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Image.asset('assets/images/group_woman.jpg'),
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
              Icons.privacy_tip,
              color: Color(0xFF0E5120),
            ),
            title: const Text(
              'Privacy',
              style: TextStyle(
                fontFamily: 'Urbanist-Bold',
                fontSize: 16,
              ),
            ),
            onTap: () {
              // Handle Privacy action
              Navigator.pop(context); // Close the drawer
            },
          ),
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
            onTap: () {
              // Handle Share This App action
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.help,
              color: Color(0xFF0E5120),
            ),
            title: const Text(
              'Help',
              style: TextStyle(
                fontFamily: 'Urbanist-Bold',
                fontSize: 16,
              ),
            ),
            onTap: () {
              // Handle Help action
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
