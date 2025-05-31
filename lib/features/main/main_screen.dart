import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/features/bookmark/bookmark_screen.dart';
import 'package:news_app/features/home/home_screen.dart';
import 'package:news_app/features/profile/profile_screen.dart';
import 'package:news_app/features/search/view/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentScreenIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const BookmarkScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentScreenIndex = index;
          });
        },
        currentIndex: _currentScreenIndex,
        items: [
          /// TODO : Task - Add Svg Picture Instead Of Icons
          BottomNavigationBarItem(
            icon: CustomSVG(
              imgPath: "assets/images/homeIcon.svg",
              isSelected: _currentScreenIndex == 0,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomSVG(
              imgPath: "assets/images/searchIcon.svg",
              isSelected: _currentScreenIndex == 1,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: CustomSVG(
              imgPath: "assets/images/BookMarkIcon.svg",
              isSelected: _currentScreenIndex == 2,
            ),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: CustomSVG(
              imgPath: "assets/images/profileIcon.svg",
              isSelected: _currentScreenIndex == 3,
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: _screens[_currentScreenIndex],
    );
  }
}

class CustomSVG extends StatelessWidget {
  const CustomSVG({super.key, required this.imgPath, required this.isSelected});
  final String imgPath;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imgPath,
      colorFilter:
          isSelected ? const ColorFilter.mode(Colors.red, BlendMode.srcIn) : null,
    );
  }
}
