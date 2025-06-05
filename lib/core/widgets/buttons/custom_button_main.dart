 
import 'package:flutter/material.dart'; 

class CustomButtonNew extends StatelessWidget {
  final Color buttonColor;
  final Color shadowColor;
  final String label;
  final Color labelColor;
  final VoidCallback? onPressed;
  final double? width;
  final IconData? icon;
  final Color? iconColor;
  final MainAxisAlignment? mainAxisAlignment;
  const CustomButtonNew({
    super.key, required this.buttonColor, required this.shadowColor, required this.label, required this.labelColor, this.onPressed, this.width, this.icon, this.iconColor, this.mainAxisAlignment,
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
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
        children: [
          TextButton(onPressed: onPressed, child: 
           Text(label, style: TextStyle(color: labelColor, fontSize: 16, fontWeight: FontWeight.bold))),
          if (icon != null && iconColor != null) 
            Icon(icon, color: iconColor, size: 20),
        ],
      ),
    );
  }
}
