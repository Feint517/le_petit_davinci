import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/features/Games/controllers/tic_tac_toe_controller.dart';

class GameControls extends GetView<TicTacToeController> {
  const GameControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //* Sound toggle button
        GameToggles2(
          icon: Icons.volume_up,
          changedIcon: Icons.volume_off,
          onPressed: controller.toggleSound,
        ),

        //const BoardSizeDropdown(),

        //* Reset button
        GameToggles2(
          icon: Icons.refresh_rounded,
          onPressed: controller.clearGame,
        ),
      ],
    );
  }
}

class GameToggles2 extends StatefulWidget {
  const GameToggles2({
    super.key,
    this.color = AppColors.secondary,
    required this.icon,
    this.changedIcon,
    this.iconColor,
    this.onPressed,
  });

  final Color color;
  final IconData icon;
  final IconData? changedIcon;
  final Color? iconColor;
  final VoidCallback? onPressed;

  @override
  State<GameToggles2> createState() => _GameToggles2State();
}

class _GameToggles2State extends State<GameToggles2>
    with SingleTickerProviderStateMixin {
  bool _toggled = false;
  late AnimationController controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );

    _animation = Tween<double>(
      begin: 1,
      end: 0.9,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(_animation.value),
          child: GestureDetector(
            onTap: () {
              controller.forward(from: 0);
              controller.addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  controller.reverse();
                }
                if (widget.changedIcon != null) {
                  setState(() {
                    _toggled = !_toggled;
                  });
                }
                widget.onPressed?.call();
              });
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 9, 0, 9),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(7),
                boxShadow: CustomShadowStyle.customCircleShadows(
                  color: widget.color,
                ),
              ),
              child: Icon(
                (_toggled && widget.changedIcon != null)
                    ? widget.changedIcon
                    : widget.icon,
                color: widget.iconColor ?? AppColors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
