import 'package:flutter/material.dart';

ThemeData darkTheme=ThemeData(
  cardColor: Color.fromARGB(255, 5, 171, 129),
  focusColor: Color.fromARGB(255, 20, 187, 145),
  canvasColor: Color.fromARGB(255, 15, 121, 94),
  primaryColor:Colors.white ,
  errorColor: Color.fromARGB(255, 178, 254, 239) ,
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Color.fromARGB(255, 15, 121, 94)
  ),
  colorScheme: ColorScheme.dark( 
    primary: Colors.grey[900]!,
   background:Colors.black ,
    secondary: Colors.grey[800]!,
    error: Colors.grey[200]!
     )
);