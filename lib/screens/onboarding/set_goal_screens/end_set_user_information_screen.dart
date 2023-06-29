import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/screens/tab_screen.dart';
import 'package:meal_up/user_information_helper.dart';
import '../../../constant.dart';

class EndSetUserInformationScreen extends StatelessWidget {
  EndSetUserInformationScreen({super.key});

  static String routeName = '/end_set_user_information_screen';

  final UIHelper uiHelper = UIHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: SafeArea(
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  '모든 준비가 완료 되었습니다!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Noto Sans KR',
                  ),
                ),
                const Spacer(),
                const Text(
                  '입력해주신 정보를 바탕으로\n하루 목표 섭취량이 설정되었습니다.\n\n설정된 목표량은 언제든지 변경할 수 있습니다.',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontFamily: 'Noto Sans KR',
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                CupertinoButton(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  onPressed: () {
                    Navigator.pushNamed(context, TabScreen.routeName);
                  },
                  child: const Text(
                    '지금 시작하기',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7265E3),
                      fontFamily: 'Noto Sans KR',
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
