import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paainet/features/Presentation/pages/profile/profile.dart';
import 'package:paainet/features/Presentation/pages/you/you.dart';
import 'package:paainet/utils/themeData/const.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> screens = [
    const You(),
    const Profile(), // <- Dummy second screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text.rich(
          TextSpan(
            style: GoogleFonts.lato(
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
            children: const [
              TextSpan(text: "P", style: TextStyle(color: AppColors.text)),
              TextSpan(text: "a", style: TextStyle(color: AppColors.text)),
              TextSpan(text: "a", style: TextStyle(color: Colors.blue)),
              TextSpan(text: "i", style: TextStyle(color: Colors.red)),
              TextSpan(text: "Net", style: TextStyle(color: AppColors.text)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? BottomNavigationBar(
              backgroundColor: AppColors.background,
              currentIndex: _selectedIndex,
              unselectedItemColor: AppColors.button.withOpacity(0.1),
              selectedItemColor: AppColors.button,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "You",
                ),
              ],
            )
          : null,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
              backgroundColor: AppColors.background,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text("Home"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Text("You"),
                ),
              ],
              labelType: NavigationRailLabelType.all,
              selectedIconTheme: const IconThemeData(color: AppColors.text),
              unselectedIconTheme: IconThemeData(
                color: AppColors.text.withOpacity(0.5),
              ),
              selectedLabelTextStyle: const TextStyle(color: AppColors.text),
              unselectedLabelTextStyle: TextStyle(
                color: AppColors.text.withOpacity(0.5),
              ),
            ),
          Expanded(
            child: screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
