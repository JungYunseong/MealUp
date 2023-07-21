import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/constant.dart';

class WeightChart extends StatefulWidget {
  const WeightChart({super.key});

  @override
  State<WeightChart> createState() => _WeightChartState();
}

class _WeightChartState extends State<WeightChart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.40,
          child: LineChart(
            mainData(),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xFF4C5980),
      fontSize: 12,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w400,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('20', style: style);
        break;
      case 5:
        text = const Text('22', style: style);
        break;
      case 8:
        text = const Text('24/03', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xFF4C5980),
      fontSize: 12,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w400,
    );
    String text;
    switch (value.toInt()) {
      case 40:
        text = '    40';
        break;
      case 50:
        text = '    50';
        break;
      case 60:
        text = '    60';
        break;
      case 70:
        text = '    70';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 10,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xFFD0D0D0),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 10,
            getTitlesWidget: rightTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xFFD0D0D0), width: 1.0),
        ),
      ),
      minX: 0,
      maxX: 11,
      minY: 40,
      maxY: 70,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 68),
            FlSpot(2.6, 64),
            FlSpot(4.9, 55),
            FlSpot(6.8, 57),
            FlSpot(8, 62),
            FlSpot(9.5, 58),
            FlSpot(11, 60),
          ],
          isCurved: true,
          color: const Color(0xFFAF8EFF),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: Colors.transparent,
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchSpotThreshold: 15.0,
        getTouchedSpotIndicator: (barData, spotIndexes) {
          return spotIndexes.map((e) {
            return TouchedSpotIndicatorData(
              const FlLine(color: Color(0xFFAF8EFF), strokeWidth: 1.0),
              FlDotData(
                getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(
                  radius: 5.0,
                  color: secondaryColor,
                  strokeColor: const Color(0xFFE3DEFF),
                  strokeWidth: 7.0,
                ),
              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipPadding:
              const EdgeInsets.symmetric(horizontal: 11.0, vertical: 12.0),
          tooltipRoundedRadius: 10.0,
          tooltipBgColor: secondaryColor,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((e) {
              return LineTooltipItem(
                'APR 4  |  ${e.y} kg',
                const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
