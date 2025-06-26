import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/features/home/widgets/section_heading.dart';

class ExercicesSection extends StatelessWidget {
  const ExercicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(sectionName: "Nombre d'exercices réalisés"),
        const Gap(AppSizes.spaceBtwItems),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true, drawVerticalLine: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final days = [
                        'Lun',
                        'Mar',
                        'Mer',
                        'Jeu',
                        'Ven',
                        'Sam',
                        'Dim',
                      ];

                      if (value.toInt() >= 0 && value.toInt() < days.length) {
                        return Text(days[value.toInt()]);
                      }
                      return const Text('');
                    },
                    interval: 1,
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              minX: 0,
              maxX: 6,
              minY: 0,
              maxY: 25,
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  color: AppColors.accent2,
                  barWidth: 2,
                  dotData: FlDotData(show: false),
                  spots: [
                    FlSpot(0, 2),
                    FlSpot(1, 4),
                    FlSpot(2, 3),
                    FlSpot(3, 7),
                    FlSpot(4, 6),
                    FlSpot(5, 8),
                    FlSpot(6, 5),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
