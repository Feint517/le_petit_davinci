import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';

enum BubblePosition { left, center, right }

/// Un widget réutilisable pour afficher une mascotte avec une bulle de dialogue.
class MascotWidget extends StatelessWidget {
  /// Le texte à afficher dans la bulle de dialogue
  final String speechText;

  final String assetPath;

  /// L'identifiant de l'asset SVG de la mascotte (par défaut bearMasscot)
  //final String? mascotAssetId;

  /// Couleur de fond personnalisée pour la bulle (optionnel)
  final Color bubbleColor;

  /// Couleur du texte personnalisée pour la bulle (optionnel)
  final Color? textColor;

  /// Taille de la mascotte (optionnel, par défaut 120.h)
  final double? mascotSize;

  /// Largeur maximale de la bulle de dialogue (optionnel)
  final double? maxBubbleWidth;

  /// Taille du texte dans la bulle (optionnel)
  final double? textSize;

  /// Position de la bulle par rapport à la mascotte (optionnel, par défaut center)
  final BubblePosition bubblePosition;

  const MascotWidget({
    super.key,
    required this.speechText,
    this.assetPath = SvgAssets.bearMasscot,
    this.bubbleColor = AppColors.primary,
    this.textColor,
    this.mascotSize,
    this.maxBubbleWidth,
    this.textSize,
    this.bubblePosition = BubblePosition.center,
  });

  @override
  Widget build(BuildContext context) {
    // Calculer la hauteur approximative du texte pour ajuster la position de la mascotte
    final textSpan = TextSpan(
      text: speechText,
      style: TextStyle(
        fontSize: textSize ?? 14.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'DynaPuff_SemiCondensed',
        height: 1.3,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: 10,
    );

    // Ajuster la largeur contrainte pour le calcul
    final maxWidth = maxBubbleWidth ?? 280.w;
    textPainter.layout(
      maxWidth: maxWidth - 32.w,
    ); // Soustraire le padding horizontal

    // Ajuster l'espacement vertical en fonction de la hauteur du texte
    final textHeight = textPainter.height;
    final adjustedSpacing =
        (textHeight > 100) ? 16.h + (textHeight / 10).h : 8.h;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //* Bulle de dialogue positioned above mascot
        _buildSpeechBubble(),

        //* Espacement entre la bulle et la mascotte, ajusté dynamiquement
        Gap(adjustedSpacing),

        //* Mascotte
        ResponsiveImageAsset(assetPath: assetPath, width: 120),
      ],
    );
  }

  /// Construit la bulle de dialogue avec le texte
  Widget _buildSpeechBubble() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxBubbleWidth ?? 280.w,
        minWidth: 160.w,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Corps principal de la bulle
          Container(
            width: maxBubbleWidth,
            //height: 100.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: CustomShadowStyle.customCircleShadows(
                color: bubbleColor,
              ),
            ),
            child: SingleChildScrollView(
              child: Text(
                speechText,
                style: TextStyle(
                  fontSize:
                      textSize ??
                      14.sp, // Utiliser la taille de texte personnalisée si fournie
                  fontWeight: FontWeight.w500,
                  color: textColor ?? AppColors.white,
                  fontFamily: 'DynaPuff_SemiCondensed',
                  height: 1.3,
                ),
                textAlign: _getTextAlignment(),
              ),
            ),
          ),

          // Queue de la bulle (pointer vers la mascotte)
          Positioned(
            bottom: -6.h,
            left: 0,
            right: 0,
            child: _buildBubbleTail(),
          ),
        ],
      ),
    );
  }

  /// Détermine l'alignement du texte basé sur la position de la bulle
  TextAlign _getTextAlignment() {
    switch (bubblePosition) {
      case BubblePosition.left:
        return TextAlign.left;
      case BubblePosition.center:
        return TextAlign.center;
      case BubblePosition.right:
        return TextAlign.right;
    }
  }

  /// Construit la queue de la bulle positionnée selon bubblePosition
  Widget _buildBubbleTail() {
    Widget tail = CustomPaint(
      size: Size(12.w, 8.h),
      painter: _BubbleTailPainter(color: bubbleColor),
    );

    switch (bubblePosition) {
      case BubblePosition.left:
        return Align(
          alignment: Alignment.centerLeft,
          child: Padding(padding: EdgeInsets.only(left: 20.w), child: tail),
        );
      case BubblePosition.center:
        return Center(child: tail);
      case BubblePosition.right:
        return Align(
          alignment: Alignment.centerRight,
          child: Padding(padding: EdgeInsets.only(right: 20.w), child: tail),
        );
    }
  }
}

/// Painter personnalisé pour dessiner la queue de la bulle de dialogue
class _BubbleTailPainter extends CustomPainter {
  final Color color;

  const _BubbleTailPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final Path path = Path();

    // Créer la forme triangulaire de la queue
    path.moveTo(size.width / 2 - 6, 0); // Point gauche
    path.lineTo(size.width / 2 + 6, 0); // Point droit
    path.lineTo(size.width / 2, size.height); // Point du bas (centre)
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
