import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

class TopNavigation extends StatelessWidget {
  final String text;
  final Color buttonColor;

  const TopNavigation({
    Key? key,
    required this.text, required this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.borderSecondary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                ),
              ],
            ),
            child: TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              label: const Text('Home', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: buttonColor,
              
            ),
            child: Center(child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          ),
        ],
      ),
    );
  }
}