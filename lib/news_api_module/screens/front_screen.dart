import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_read_api_project/news_api_module/screens/aboutUs_screen.dart';
import 'package:flutter_read_api_project/news_api_module/screens/home.dart';
import 'package:flutter_read_api_project/news_api_module/screens/read_api.dart';

class FrontScreen extends StatefulWidget {
  const FrontScreen({super.key});

  @override
  State<FrontScreen> createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  bool showBottomBar = true;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showBottomBar = true;
        setState(() {});
      } else {
        showBottomBar = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottom(),
    );
  }

  Widget _buildBody() {
    return IndexedStack(
      index: _currentIndex,
      children: [
        Home(
          scrollController: _scrollController,
        ),
        const Readapi(),
        AboutUsScreen(
          ref: (int index) {
            _currentIndex = index;
            setState(() {});
          },
        )
      ],
    );
  }

  Widget _buildBottom() {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 150,
      ),
      height: showBottomBar ? 58 : 0,
      curve: Curves.easeInSine,
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: "About"),
        ],
      ),
    );
  }
}
