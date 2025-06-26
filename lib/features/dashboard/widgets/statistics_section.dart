import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/features/dashboard/widgets/pie_indicator.dart';
import 'package:le_petit_davinci/features/home/widgets/section_heading.dart';

class StatisticsSection extends StatelessWidget {
  const StatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(sectionName: "Statistiques"),
        const Gap(AppSizes.spaceBtwItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(
                      centerSpaceRadius: 50,
                      sectionsSpace: 0,
                      sections: [
                        PieChartSectionData(
                          showTitle: false,
                          radius: 20,
                          value: 40,
                          color: _getColor(BadgeVariant.french),
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          radius: 20,
                          value: 15,
                          color: _getColor(BadgeVariant.english),
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          radius: 20,
                          value: 20,
                          color: _getColor(BadgeVariant.math),
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          radius: 20,
                          value: 10,
                          color: _getColor(BadgeVariant.dailyLife),
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          radius: 20,
                          value: 15,
                          color: _getColor(BadgeVariant.games),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Durée totale d'utilisation",
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 10),
                          ),
                          Text(
                            '4 heures',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Indicator(
                  color: _getColor(BadgeVariant.french),
                  text: 'Français',
                ),
                Indicator(
                  color: _getColor(BadgeVariant.math),
                  text: 'Mathématiques',
                ),
                Indicator(
                  color: _getColor(BadgeVariant.english),
                  text: 'Anglais',
                ),
                Indicator(
                  color: _getColor(BadgeVariant.dailyLife),
                  text: 'Vie quotidienne',
                ),
                Indicator(
                  color: _getColor(BadgeVariant.games),
                  text: 'Jeux éducatifs',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Color _getColor(BadgeVariant badgeVariant) {
    switch (badgeVariant) {
      case BadgeVariant.french:
        return AppColors.primary;
      case BadgeVariant.math:
        return AppColors.secondary;
      case BadgeVariant.english:
        return AppColors.accent;
      case BadgeVariant.dailyLife:
        return AppColors.accent3;
      case BadgeVariant.games:
        return AppColors.accent2;
    }
  }
}
