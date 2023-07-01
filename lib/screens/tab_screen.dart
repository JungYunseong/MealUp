import 'package:flutter/material.dart';
import 'package:meal_up/constant.dart';
import 'package:provider/provider.dart';
import '../components/bottom_navigation_bar/bottom_navigation_bar.dart';
import '../providers/setting_provider.dart';
import 'home_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  static String routeName = '/tab_screen';

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  bool isLoading = true;

  int selectedTab = 0;

  @override
  void initState() {
    context.read<Setting>().getSettingValue().then((_) {
      setState(() => isLoading = false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    } else {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: secondaryColor,
          body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                if (selectedTab == 0) const HomeScreen(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CurvedNavigationBar(
                    items: [
                      Icon(
                        Icons.home,
                        size: 30,
                        color: selectedTab == 0
                            ? const Color(0xFF2D3142)
                            : const Color(0xFFD6D9E0),
                      ),
                      Icon(
                        Icons.person,
                        size: 30,
                        color: selectedTab == 1
                            ? const Color(0xFF2D3142)
                            : const Color(0xFFD6D9E0),
                      ),
                    ],
                    onTap: (index) {
                      setState(() {
                        selectedTab = index;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
