import 'package:flutter/material.dart';
import '../components/date_picker/date_picker_widget.dart';
import '../components/target_intake_card.dart';
import '../constant.dart';
import '../utils/app_install_date.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  DateTime startDate = DateTime.now();
  DateTime _selectedValue = DateTime.now();

  @override
  void initState() {
    AppInstallDate().installDate.then((DateTime dateTime) {
      setState(() {
        startDate = dateTime;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '식단관리',
          style: navTitle,
        ),
        const SizedBox(height: 16.0),
        DatePicker(
          startDate,
          initialSelectedDate: DateTime.now(),
          onDateChange: (date) {
            setState(() {
              _selectedValue = date;
            });
          },
        ),
        const SizedBox(height: 24.0),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.0),
              ),
              color: Color(0xFFF4F6FA),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 27.0),
                  TargetIntake(selectedValue: _selectedValue),
                  const SizedBox(height: 550),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
