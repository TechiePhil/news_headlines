import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData mainTheme = ThemeData(
  brightness: Brightness.dark,
  // Card Theme
  cardTheme: CardTheme(
    shadowColor: Colors.black12,
    elevation: 6,
  ),
  
  // TextFormField Theme
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.greenAccent,
    focusColor: Colors.black,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(20)
    )
  ),
  
  // TabBar Theme
  tabBarTheme: TabBarTheme(
    labelColor: Colors.greenAccent,
    unselectedLabelColor: Colors.black,
    labelStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    indicator: BoxDecoration(
      border: Border(
        top: BorderSide(width: 4,)
      )
    ),
  ),
  
  // ElevatedButton Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(6),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          fontSize: 18,
          // fontWeight: FontWeight.w800
        )
      ),
      backgroundColor: MaterialStateProperty.all(
        Colors.greenAccent
      ),
      foregroundColor: MaterialStateProperty.all(
        Colors.black
      ),
      shadowColor: MaterialStateProperty.all(
        Colors.greenAccent,
      ),
      shape: MaterialStateProperty.all(
        StadiumBorder(
          side: BorderSide.none
        )
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(vertical: 10, horizontal: 15)
      )
    )
  ),
);