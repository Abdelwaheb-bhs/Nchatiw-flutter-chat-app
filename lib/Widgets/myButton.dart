import 'package:flutter/material.dart';



class MyBotton extends StatelessWidget {
  const MyBotton({ required this.color ,required this.textColor , required this.title , required this.onPressed});
  final Color color,textColor;
  final String title ;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: 
    Material(
      elevation: 5,
      color: color,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(onPressed: onPressed,
      minWidth: 20,
      height: 42,
      child: Text(title, style: TextStyle(color: textColor),),
      ),
    )
    ,);
    
  }
}