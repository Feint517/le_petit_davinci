import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/core/widgets/misc/map_buttons.dart';
import 'package:le_petit_davinci/features/Mathematic/models/section_data_model.dart';
import 'package:le_petit_davinci/features/Mathematic/widgets/section_title.dart';

class MapSection extends StatelessWidget {
  const MapSection({super.key, required this.data});

  final SectionData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionTitle(title: data.title),
        const Gap(24.0),
        ...List.generate(
          9,
          (index) =>
              index % 9 != 4
                  ? Container(
                    margin: EdgeInsets.only(
                      bottom: index != 8 ? 24.0 : 0,
                      left: getLeft(index),
                      right: getRight(index),
                    ),
                    child: MapButton(
                      iconPath: SvgAssets.chat,
                      backgroundColor: AppColors.pinkLight,
                      level: data.levels[index],
                    ),
                  )
                  : Container(
                    margin: const EdgeInsets.only(bottom: 24.0),
                    child: const ResponsiveImageAsset(
                      assetPath: 'assets/test/cofre-ruta.svg',
                      width: 72,
                      height: 72,
                    ),
                  ),
        ),
      ],
    );
  }

  double getLeft(int indice) {
    const margin = 72.0;
    int pos = indice % 9;

    if (pos == 1) {
      return margin;
    }
    if (pos == 2) {
      return margin * 2;
    }
    if (pos == 3) {
      return margin;
    }

    return 0.0;
  }

  double getRight(int indice) {
    const margin = 72.0;
    int pos = indice % 9;

    if (pos == 5) {
      return margin;
    }
    if (pos == 6) {
      return margin * 2;
    }
    if (pos == 7) {
      return margin;
    }

    return 0.0;
  }
}
