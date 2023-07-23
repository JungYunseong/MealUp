import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/components/progress_bar.dart';
import 'package:meal_up/model/activity_level.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../components/activity_level_card.dart';
import '../../../constant.dart';

class SelectActivityLevelScreen extends StatelessWidget {
  SelectActivityLevelScreen({super.key});

  static String routeName = '/select_activity_level_screen';

  final List<ActivityLevel> _activityLevelCardList = [
    ActivityLevel(
      level: 1,
      title: '매우 적은 활동량',
      image: 'assets/icons/veryLow.png',
      description: '대부분의 시간을 앉아서 보내며,\n운동을 거의 하지 않습니다.',
    ),
    ActivityLevel(
      level: 2,
      title: '적은 활동량',
      image: 'assets/icons/low.png',
      description: '대부분의 시간을 앉아서 보내지만,\n약간의 운동이나 활동을 합니다.',
    ),
    ActivityLevel(
      level: 3,
      title: '보통 활동량',
      image: 'assets/icons/moderate.png',
      description: '걷기나 가벼운 운동 등을 하며,\n하루에 1시간 정도의 운동을 합니다.',
    ),
    ActivityLevel(
      level: 4,
      title: '많은 활동량',
      image: 'assets/icons/high.png',
      description: '꾸준한 운동을 하며, 하루에\n1시간 30분 이상의 운동을 합니다.',
    ),
    ActivityLevel(
      level: 5,
      title: '매우 많은 활동량',
      image: 'assets/icons/veryHigh.png',
      description: '매우 강도 높은 운동을 하며,\n하루에 2시간 이상의 운동을 합니다.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: backgroundGradient,
      child: Scaffold(
        appBar: const CupertinoNavigationBar(
          middle: ProgressBar(current: 2/6),
          border: Border(bottom: BorderSide(color: Colors.transparent)),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Row(
            children: [
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text('STEP 2/6', style: aiStepText),
                  const SizedBox(height: 10.0),
                  Text(
                    '평소 활동 수준을',
                    style: aiTitleText,
                  ),
                  Text(
                    '알려주세요.',
                    style: aiTitleText,
                  ),
                  const SizedBox(height: 45.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 400.0,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.2,
                        viewportFraction: 0.75,
                        enableInfiniteScroll: false,
                      ),
                      itemCount: _activityLevelCardList.length,
                      itemBuilder: (context, index, realIndex) {
                        final card = _activityLevelCardList[index];
                        return ActivityLevelCard(
                          activityLevel: ActivityLevel(
                            level: card.level,
                            title: card.title,
                            image: card.image,
                            description: card.description,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 45.0),
                  const Spacer(),
                  //
                  const Spacer(),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
