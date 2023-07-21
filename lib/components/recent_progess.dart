import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:meal_up/model/weight.dart';
import 'package:meal_up/weight_database_helper.dart';

class RecentProgess extends StatefulWidget {
  const RecentProgess({
    super.key,
    required this.weightList,
    required this.onDelete,
  });

  final List<WeightEntry> weightList;
  final Function() onDelete;

  @override
  State<RecentProgess> createState() => _RecentProgessState();
}

class _RecentProgessState extends State<RecentProgess> {
  Widget weightRow(WeightEntry item) {
    final date = DateTime.fromMillisecondsSinceEpoch(item.date).toString();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: const TextStyle(
                color: Color(0xFF2D3142),
                fontSize: 16,
                fontFamily: 'Noto Sans KR',
                fontWeight: FontWeight.w400,
                letterSpacing: 0.23,
              ),
            ),
            Text(
              item.weight.toString(),
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF2D3142),
                fontSize: 16,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.17,
              ),
            )
          ],
        ),
        const SizedBox(height: 20.0),
        Divider(
          height: 1.0,
          color: Colors.black.withOpacity(0.04),
        ),
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
                key: UniqueKey(),
                endActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const ScrollMotion(),
                  children: [
                    const SizedBox(width: 16.0),
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
                      onPressed: () {
                        final dbHelper = WeightDatabaseHelper();
                        dbHelper.deleteWeightEntry(item.id!);
                        widget.onDelete();
                      },
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 8.0),
                  child: weightRow(item),
                ),
              );
            }).toList(),
          )
        else
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
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
