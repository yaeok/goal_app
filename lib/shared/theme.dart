import 'package:fill/shared/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData myTheme() => ThemeData(
      colorScheme:
          ColorScheme.fromSwatch(primarySwatch: AppColors.pink).copyWith(
        secondary: AppColors.green,
      ),
      scaffoldBackgroundColor: AppColors.lightGrey,
      fontFamily: 'NotoSerif',
      textTheme: const TextTheme(
        // 帯などのテキストを設定
        titleMedium: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      //アプリバーの背景
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.green,
      ),

      //バーの文字の色
      primaryTextTheme: const TextTheme(
        titleLarge: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),

      // ボタン設定
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 80,
            vertical: 15,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          textStyle: const TextStyle(
            fontSize: 15.0,
            fontFamily: 'NotoSerif',
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.pink,
          padding: const EdgeInsets.symmetric(
            horizontal: 80,
            vertical: 15,
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          textStyle: const TextStyle(
            fontSize: 15.0,
            fontFamily: 'NotoSerif',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
