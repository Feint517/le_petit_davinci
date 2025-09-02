import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

class Numpad extends StatelessWidget {
  final void Function(String) onNumberPressed;
  final VoidCallback onBackspacePressed;

  const Numpad({
    super.key,
    required this.onNumberPressed,
    required this.onBackspacePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 2 / 1.5,
      children: [
        ...List.generate(9, (index) {
          final number = (index + 1).toString();
          return _buildButton(context, number, () => onNumberPressed(number));
        }),
        // Empty space for layout
        const SizedBox.shrink(),
        // Zero button
        _buildButton(context, '0', () => onNumberPressed('0')),
        // Backspace button
        _buildButton(context, Icons.backspace_outlined, onBackspacePressed),
      ],
    );
  }

  Widget _buildButton(
    BuildContext context,
    dynamic child,
    VoidCallback onPressed,
  ) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: Colors.grey.shade300, width: 2),
        backgroundColor: AppColors.white,
      ),
      child:
          child is String
              ? Text(
                child,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: AppColors.black),
              )
              : Icon(child as IconData, color: AppColors.black),
    );
  }
}
