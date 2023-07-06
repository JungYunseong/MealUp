import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant.dart';

class AddFoodScreen extends StatelessWidget {
  const AddFoodScreen({super.key});

  static String routeName = '/add_food_screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: backgroundGradient,
      child: Scaffold(
        appBar: const CupertinoNavigationBar(
          middle: Text(
            '음식 검색',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF2D3142),
              fontSize: 16,
              fontFamily: 'Noto Sans KR',
              fontWeight: FontWeight.w500,
            ),
          ),
          border: Border(bottom: BorderSide(color: Colors.transparent)),
          transitionBetweenRoutes: false,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16.0),
                    Container(
                      height: 60,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x144075CD),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(20.0),
                            suffixIcon: CupertinoButton(
                                child: const Icon(CupertinoIcons.search),
                                onPressed: () {
                                  
                                }),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 27.0),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 17.0),
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(16.0),
                            onPressed: () {},
                            child: Text(
                              '바코드 스캔',
                              style: buttonText,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 17.0),
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(16.0),
                            onPressed: () {},
                            child: Text(
                              '빠른 추가',
                              style: buttonText,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
