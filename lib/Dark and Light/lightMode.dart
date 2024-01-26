import 'package:flutter/material.dart';

ThemeData lightTheme=ThemeData(
  cardColor: Color.fromARGB(255, 0, 193, 164),
  focusColor: Color.fromARGB(255, 20, 187, 145),
  canvasColor: Color.fromARGB(246, 53, 209, 201),
  primaryColor:Colors.black ,
  errorColor: Color.fromARGB(255, 84, 133, 123) ,
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Color.fromARGB(255, 9, 214, 169) ,
  ),
  colorScheme: ColorScheme.dark( 
    primary: Colors.grey[50]!,
   background:Colors.grey[100]!,
    secondary: Colors.grey[200]!,
    error: Colors.grey[900]!
     )
);