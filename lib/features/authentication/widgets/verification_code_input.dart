import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

class VerificationCodeInput extends StatefulWidget {
  final Function(String) onCompleted;
  final Function(String) onChanged;
  final int length;
  final bool hasError;

  const VerificationCodeInput({
    super.key,
    required this.onCompleted,
    required this.onChanged,
    this.length = 6,
    this.hasError = false,
  });

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    focusNodes = List.generate(widget.length, (index) => FocusNode());

    // Auto-focus first field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && focusNodes.isNotEmpty) {
        focusNodes[0].requestFocus();
      }
    });
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleChange(int index, String value) {
    if (!mounted) return;
    
    if (value.isEmpty) {
      // Handle backspace
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    } else if (value.length == 1) {
      // Move to next field
      if (index < widget.length - 1) {
        focusNodes[index + 1].requestFocus();
      } else {
        // Last field - check if all fields are filled
        focusNodes[index].unfocus();
      }
    } else if (value.length > 1) {
      // Handle paste
      _handlePaste(value);
      return;
    }

    // Notify parent of change
    final code = controllers.map((c) => c.text).join();
    widget.onChanged(code);

    // Check if completed
    if (code.length == widget.length) {
      widget.onCompleted(code);
    }
  }

  void _handlePaste(String value) {
    if (!mounted) return;
    
    // Remove any non-digit characters
    final digits = value.replaceAll(RegExp(r'\D'), '');

    for (int i = 0; i < widget.length && i < digits.length; i++) {
      controllers[i].text = digits[i];
    }

    // Focus last filled field or last field
    final lastIndex =
        digits.length < widget.length ? digits.length : widget.length - 1;
    focusNodes[lastIndex].requestFocus();

    final code = controllers.map((c) => c.text).join();
    widget.onChanged(code);

    if (code.length == widget.length) {
      widget.onCompleted(code);
    }
  }

  void clear() {
    if (!mounted) return;
    
    for (var controller in controllers) {
      controller.clear();
    }
    if (focusNodes.isNotEmpty) {
      focusNodes[0].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (index) => _buildCodeField(index)),
    );
  }

  Widget _buildCodeField(int index) {
    return Container(
      width: 50.w,
      height: 60.h,
      decoration: BoxDecoration(
        color:
            widget.hasError
                ? AppColors.error.withOpacity(0.1)
                : AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color:
              widget.hasError
                  ? AppColors.error
                  : focusNodes[index].hasFocus
                  ? AppColors.primary
                  : AppColors.grey.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          if (focusNodes[index].hasFocus)
            BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: widget.hasError ? AppColors.error : AppColors.textPrimary,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) => _handleChange(index, value),
      ),
    );
  }
}
