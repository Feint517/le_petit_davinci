 
import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

class CustomButtonNew extends StatelessWidget {
  final Color buttonColor;
  final Color shadowColor;
  final String label;
  final Color labelColor;
  final VoidCallback? onPressed;
  final double? width;
  const CustomButtonNew({
    super.key, required this.buttonColor, required this.shadowColor, required this.label, required this.labelColor, this.onPressed, this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width  ?? MediaQuery.of(context).size.width * 0.35,
      height: 50,
     decoration: BoxDecoration(
       color: buttonColor,
       borderRadius: BorderRadius.circular(10),
       boxShadow: [
         BoxShadow(
           color: shadowColor,
           spreadRadius: 2,
           blurRadius: 0,
           offset: const Offset(3, 3), // changes position of shadow
         )
       ],),
      child: TextButton(onPressed: onPressed, child: 
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
         child: Text(label, style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold)),
       )),
    );
  }
}
