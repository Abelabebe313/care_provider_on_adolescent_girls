import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.menu),
          // ),
          title: Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Image.asset('assets/images/title.png'),
            ),
          ),
        ),
        body: Column(
          children: [
            // Search Bar
            Expanded(
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
                  border: OutlineInputBorder(
                    
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
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
          ],
        ));
  }
}
