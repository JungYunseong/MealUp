import 'package:flutter/material.dart';
import '../constant.dart';

class ProgressBar extends StatelessWidget {
  final double current;
  final Color color;

  const ProgressBar(
      {Key? key, required this.current, this.color = primaryColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var width = 120;
        var percent = current * width;
        return Stack(
          children: [
            Container(
              width: width.toDouble(),
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xFFE1DDF5),
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: percent,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ],
        );
      },
    );
  }
}
