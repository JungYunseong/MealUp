import 'package:flutter/material.dart';
import 'package:meal_up/constant.dart';
import 'package:meal_up/screens/recent_status_screen.dart';
import 'package:provider/provider.dart';
import '../components/bottom_navigation_bar/bottom_navigation_bar.dart';
import '../providers/setting_provider.dart';
import '../utils/app_install_date.dart';
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

  DateTime installDate = DateTime.now();

  @override
  void initState() {
    AppInstallDate().installDate.then((DateTime dateTime) {
      context.read<Setting>().getSettingValue().then((_) {
        setState(() {
          installDate = dateTime;
          isLoading = false;
        });
      });
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
          resizeToAvoidBottomInset: false,
          backgroundColor: secondaryColor,
          body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                if (selectedTab == 0) HomeScreen(installDate: installDate),
                if (selectedTab == 1)
                  RecentStatusScreen(installDate: installDate),
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
