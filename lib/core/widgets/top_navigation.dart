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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.backgroundLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 10),
            label: const Text('Home', style: TextStyle(color: Colors.black, fontSize: 10)),
          ),
          Container( 
            padding: const EdgeInsets.symmetric(horizontal: 10.0 ,vertical: 5.0),
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