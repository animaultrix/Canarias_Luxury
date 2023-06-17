

import 'package:flutter/material.dart';

class AppTheme {

  //Color dorado
  static const Color dorado =  Color(0xffac862e);
  static const Color blanco =  Color(0xffffffff);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
        //Appbar theme
        appBarTheme: const AppBarTheme(
          color: dorado,
          elevation: 0,
          titleTextStyle: TextStyle(
          fontFamily: "MulishM",
          fontSize: 18,
          ),
          toolbarTextStyle: TextStyle(
            fontFamily: "MulishM",
            fontSize: 18,
          ),
        ),
        //Elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style:  ElevatedButton.styleFrom(        
          textStyle: const TextStyle(
            fontSize: 18,
            fontFamily: "MulishM",
          ),
          foregroundColor: blanco,
          backgroundColor: dorado,
          padding: const EdgeInsets.symmetric(horizontal: 50),                              
          ),
        ),
        //Text field theme
        inputDecorationTheme: const InputDecorationTheme(          
          labelStyle:  TextStyle(
            fontFamily: "MulishM"
          ),
          hintStyle:  TextStyle(
            fontFamily: "MulishM"
          ),
          floatingLabelStyle: TextStyle(color: dorado),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: dorado),
          ),
        ),
        //Text theme
        textTheme:  TextTheme(
          bodyText2: TextStyle(
            fontFamily: "MulishM",
            color: Colors.grey.shade800
          ),
          subtitle1: TextStyle(
            fontFamily: "MulishM",
            color: Colors.grey.shade800
          ),
          subtitle2: TextStyle(
            fontFamily: "MulishM",
            color: Colors.grey.shade800
          ),
          headline6: TextStyle(
            fontFamily: "MulishM",
            color: dorado, // Cambia el color según lo desees
          ),        
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: dorado,
          foregroundColor: blanco,
        ), 
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return blanco;
            }
            return Colors.black;
          }),
          fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return dorado;
            }
            return Colors.grey;
          }),
        ),
        );
             
}