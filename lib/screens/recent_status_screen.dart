import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/components/display_weight.dart';
import 'package:meal_up/components/weight_chart.dart';
import 'package:meal_up/model/weight.dart';
import 'package:meal_up/weight_database_helper.dart';
import 'package:provider/provider.dart';
import 'package:pull_down_button/pull_down_button.dart';
import '../components/bmi_card.dart';
import '../components/recent_progess.dart';
import '../constant.dart';
import '../providers/setting_provider.dart';

class RecentStatusScreen extends StatefulWidget {
  const RecentStatusScreen({super.key});

  @override
  State<RecentStatusScreen> createState() => _RecentStatusScreenState();
}

class _RecentStatusScreenState extends State<RecentStatusScreen> {
  String graphType = 'Weekly';

  List<WeightEntry> weightList = [];

  final weightController = TextEditingController();

  final dbHelper = WeightDatabaseHelper();

  void fetchWeight() async {
    final data = await dbHelper.getWeightEntries();
    setState(() {
      weightList = data;
    });
  }

  void addCurrentWeight() {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('현재 체중을 입력해 주세요.'),
            content: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CupertinoTextField(
                controller: weightController,
                textAlign: TextAlign.center,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            actions: [
              CupertinoDialogAction(
                  child: const Text('취소'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text('추가'),
                  onPressed: () {
                    dbHelper.insertWeightEntry(
                      WeightEntry(
                        date: DateTime.now().millisecondsSinceEpoch,
                        weight: double.parse(weightController.text),
                      ),
                    );
                    Navigator.pop(context);
                    fetchWeight();
                  }),
            ],
          );
        });
  }

  @override
  void initState() {
    fetchWeight();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '현황',
          style: navTitle,
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DisplayWeight(
              label: '현재',
              weight: weightList.isEmpty ? 00 : weightList.last.weight.round(),
            ),
            Image.asset(
              'assets/icons/weight.png',
              width: 24.0,
              fit: BoxFit.fitWidth,
            ),
            DisplayWeight(
              label: '목표',
              weight: context.watch<Setting>().goalWeight!,
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              color: Colors.white,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 27.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '나의 현황',
                            style: TextStyle(
                              color: Color(0xFF2D3142),
                              fontSize: 20,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          PullDownButton(
                            itemBuilder: (context) {
                              return [
                                PullDownMenuItem.selectable(
                                  onTap: () {
                                    setState(() {
                                      graphType = 'Weekly';
                                    });
                                  },
                                  title: 'Weekly',
                                ),
                                PullDownMenuItem.selectable(
                                  onTap: () {
                                    setState(() {
                                      graphType = 'Monthly';
                                    });
                                  },
                                  title: 'Monthly',
                                ),
                              ];
                            },
                            buttonBuilder: (context, showMenu) =>
                                CupertinoButton(
                              onPressed: showMenu,
                              padding: EdgeInsets.zero,
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 12.0, 16.0, 12.0),
                                height: 40,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFE3DEFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      graphType,
                                      style: const TextStyle(
                                        color: Color(0xFF7265E3),
                                        fontSize: 12,
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.20,
                                      ),
                                    ),
                                    const SizedBox(width: 4.0),
                                    Image.asset(
                                      'assets/icons/dropdown.png',
                                      width: 10.0,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      const WeightChart(),
                      const SizedBox(height: 40.0),
                      const BMICard(bmi: 25),
                      const SizedBox(height: 56.0),
                      const Row(
                        children: [
                          Text(
                            '최근 현황',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.32,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                RecentProgess(
                  weightList: (weightList.length < 3)
                      ? weightList.reversed.toList()
                      : weightList.reversed.toList().sublist(0, 3),
                  onDelete: () {
                    fetchWeight();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 24.0),
                      SafeArea(
                        child: CupertinoButton(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(16.0),
                          onPressed: () {
                            addCurrentWeight();
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                '체중 업데이트',
                                style: buttonText,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
