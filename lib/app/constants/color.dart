import 'package:flutter/material.dart';

const appPurple = Color(0xFF2E0D8A);

const appPurpleLight1 = Color(0xFF6F35A5);

const appPurpleDark1 = Color(0xFF1E0771);

const appPurpleLight2 = Color(0xFFB9A2D8);

const appWhite = Color(0xFFFAF8FC);

const appOrange = Color(0xFFE6704A);

ThemeData themeLight = ThemeData(
    brightness: Brightness.light,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: appPurple),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: appPurple,
    appBarTheme: AppBarTheme(
      elevation: 4,
      backgroundColor: appPurple,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: appPurpleDark1),
      bodyText2: TextStyle(color: appPurpleDark1),
    ),
    listTileTheme: ListTileThemeData(
      textColor: appPurpleDark1,
    ),
    tabBarTheme: TabBarTheme(
        labelColor: appPurpleDark1,
        unselectedLabelColor: Colors.grey,
      
        //  indicatorColor: appPurpleDark1,
        //             labelColor: Get.isDarkMode ? appWhite : appPurpleDark1,
        //             unselectedLabelColor: Colors.grey,

        ));

ThemeData temeDark = ThemeData(
    brightness: Brightness.dark,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: appWhite),
    scaffoldBackgroundColor: appPurpleDark1,
    primaryColor: appPurpleLight2,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: appPurpleDark1,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: appWhite),
      bodyText2: TextStyle(color: appWhite),
    ),
    listTileTheme: ListTileThemeData(
      textColor: appWhite,
    ),
    tabBarTheme: TabBarTheme(
        labelColor: appWhite,
        unselectedLabelColor: Colors.grey,
       
        //  indicatorColor: appPurpleDark1,
        //             labelColor: Get.isDarkMode ? appWhite : appPurpleDark1,
        //             unselectedLabelColor: Colors.grey,

        ));
