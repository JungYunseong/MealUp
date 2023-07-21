import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:meal_up/model/weight.dart';

class RecentProgess extends StatefulWidget {
  const RecentProgess({super.key, required this.weightList});

  final List<WeightEntry> weightList;

  @override
  State<RecentProgess> createState() => _RecentProgessState();
}

class _RecentProgessState extends State<RecentProgess> {
  Widget weightRow(WeightEntry item) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '오늘',
              style: TextStyle(
                color: Color(0xFF2D3142),
                fontSize: 16,
                fontFamily: 'Noto Sans KR',
                fontWeight: FontWeight.w400,
                height: 14,
                letterSpacing: 0.23,
              ),
            ),
            Text(
              '50.5',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF2D3142),
                fontSize: 14,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                height: 14,
                letterSpacing: 0.17,
              ),
            )
          ],
        ),
        Divider(height: 1.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.weightList.isNotEmpty)
          Column(
            children: widget.weightList.map((item) {
              return Slidable(
                endActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const ScrollMotion(),
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.red,
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {},
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28.0,
                    vertical: 16.0,
                  ),
                  child: weightRow(item),
                ),
              );
            }).toList(),
          )
        else
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              '현재 체중을 추가해주세요.',
              style: TextStyle(
                color: Color(0xFF9C9DB9),
                fontSize: 14,
                fontFamily: 'Noto Sans KR',
                fontWeight: FontWeight.w400,
                letterSpacing: 0.20,
              ),
            ),
          ),
      ],
    );
  }
}
