import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/constant.dart';
import 'package:meal_up/model/weight.dart';
import 'package:meal_up/utils/chart_calculater.dart';

class WeightChart extends StatefulWidget {
  const WeightChart({
    super.key,
    required this.installDate,
    required this.chartType,
    required this.weightList,
  });

  final DateTime installDate;
  final String chartType;
  final List<WeightEntry> weightList;

  @override
  State<WeightChart> createState() => _WeightChartState();
}

class _WeightChartState extends State<WeightChart> {
  double xInterval = 86400000;

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
    text = converXtoLabel(
        chartType: widget.chartType,
        list: widget.weightList,
        value: value,
        style: style);

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
    text = converYtoLabel(value: value, style: style);

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  List<FlSpot> spots() {
    return widget.weightList.map((data) {
      return FlSpot(data.date.toDouble(), data.weight.toDouble());
    }).toList();
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: getYInterval(widget.weightList),
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
            interval: 10800000,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: getYInterval(widget.weightList),
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
      minX: getMinX(chartType: widget.chartType, list: widget.weightList),
      maxX: getMaxX(widget.weightList),
      minY: getMinY(widget.weightList),
      maxY: getMaxY(widget.weightList),
      lineBarsData: [
        LineChartBarData(
          spots: spots(),
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
                '${converXtoString(chartType: widget.chartType, x: e.x.toInt())} |  ${e.y} kg',
                const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Noto Sans KR',
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
