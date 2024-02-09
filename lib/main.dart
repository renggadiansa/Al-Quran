import 'package:alquran/app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async{
  await GetStorage.init();x
  final box = GetStorage();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: box.read("temeDark") == null ? themeLight : temeDark,
      //darkTheme: themeLight,
      title: "Application",
      initialRoute: Routes.INTRODUCTION,
      getPages: AppPages.routes,
    ),
  );
}
