import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (Get.isDarkMode) {
      controller.isDark.value = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Al Quran',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.FIND_PAGE),
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assalamuaaikum 'Aidina Nur Faizin",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      appPurpleLight1,
                      appPurpleDark1,
                    ],
                  ),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Get.toNamed(Routes.LAST_READ),
                    child: Container(
                      height: 150,
                      width: Get.width,
                      child: Stack(
                        children: [
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Opacity(
                                opacity: 0.5,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    child: Image.asset(
                                      "assets/images/alquran.png",
                                      fit: BoxFit.contain,
                                    )),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book_rounded,
                                      color: appWhite,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Terakhir Dibaca",
                                      style: TextStyle(
                                        color: appWhite,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Al-Fatihah",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: appWhite,
                                  ),
                                ),
                                Text(
                                  "Ayat nomor..",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: appWhite,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            appPurpleDark1,
                            appPurpleLight1,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TabBar(tabs: [
                Tab(
                  text: "Surah",
                ),
                Tab(
                  text: "Juz",
                ),
                Tab(
                  text: "Bookmark",
                )
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    FutureBuilder<List<Surah>>(
                      future: controller.getAllSurah(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("Data Kosong"),
                          );
                        }

                        print(snapshot.data);

                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Surah surah = snapshot.data![index];
                              return ListTile(
                                onTap: () {
                                  Get.toNamed(Routes.DETAIL_SURAH,
                                      arguments: surah);
                                },
                                leading: Obx(() => Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(controller
                                                  .isDark.isTrue
                                              ? "assets/images/octagonal_dark.png"
                                              : "assets/images/octagonal.png"),
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "${surah.number}",
                                        // style: TextStyle(
                                        //   color: Get.isDarkMode
                                        //       ? appWhite
                                        //       : appPurpleDark1,
                                        // ),
                                      )),
                                    )),
                                title: Text(
                                  "Surah ${surah.name?.transliteration?.id ?? 'Error'}",
                                  // style: TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Get.isDarkMode
                                  //         ? appWhite
                                  //         : appPurpleDark1),
                                ),
                                subtitle: Text(
                                  "${surah.numberOfVerses} ayat | ${surah.revelation?.id ?? 'Error'}",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                trailing: Text(
                                  "${surah.name?.short ?? 'Error'}",
                                  // style: TextStyle(
                                  //   color: Get.isDarkMode
                                  //       ? appWhite
                                  //       : appPurpleDark1,
                                  // ),
                                ),
                              );
                            });
                      },
                    ),
                    ListView.builder(
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return ListTile(
                            onTap: () {
                              // Get.toNamed(Routes.DETAIL_SURAH,
                              //     arguments: surah);
                            },
                            leading: Obx(
                              () => Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(controller.isDark.isTrue
                                          ? "assets/images/octagonal_dark.png"
                                          : "assets/images/octagonal.png"),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "${index + 1}",
                                    // style: TextStyle(
                                    //   color: appPurpleDark1,
                                    // ),
                                  ))),
                            ),
                            title: Text(
                              "Juz ${index + 1}",
                              // style: TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //     color: appPurpleDark1),
                            ));
                      },
                    ),
                    Center(
                      child: Text("Page 3"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.isDarkMode
              ? Get.changeTheme(themeLight)
              : Get.changeTheme(temeDark);
          controller.isDark.value = !controller.isDark.value;
        },
        child: Obx(
          () => controller.isDark.isTrue
              ? Icon(
                  Icons.light_mode,
                   color: controller.isDark.isTrue ? appPurpleDark1 : appWhite,
                )
              : Icon(
                  Icons.dark_mode,
                  color: controller.isDark.isTrue ? appPurpleDark1 : appWhite,
                ),
        ),
      ),
    );
  }
}
