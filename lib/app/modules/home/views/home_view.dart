import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/models/juz.dart' as juz;
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
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Get.toNamed(Routes.INTRODUCTION),
        ),
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
                "Assalamualaikum, 'Aidina Nur Faizin",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GetBuilder<HomeController>(
                builder: (c) => FutureBuilder<Map<String, dynamic>?>(
                  future: c.getLastRead(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              appPurpleLight1,
                              appPurpleDark1,
                            ],
                          ),
                        ),
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
                                      "Loading",
                                      style: TextStyle(
                                        fontSize: 20,
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
                      );
                    }
                    Map<String, dynamic>? lastRead = snapshot.data;
                    return Container(
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
                          onLongPress: () {
                            if (lastRead != null) {
                              Get.defaultDialog(
                                  title: "Hapus Last Read",
                                  middleText:
                                      "Apakah anda yakin menghapus last read?",
                                  actions: [
                                    OutlinedButton(
                                        onPressed: () => Get.back(),
                                        child: Text("Batal")),
                                    ElevatedButton(
                                      onPressed: () {
                                        c.deleteLastRead(lastRead["id"]);
                                      },
                                      child: Text(
                                        "Hapus",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: appPurpleDark1,
                                      ),
                                    ),
                                  ]);
                            }
                          },
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            if (lastRead != null) {
                              Get.toNamed(
                                Routes.DETAIL_SURAH,
                                arguments: {
                                  "name": lastRead["surah"]
                                      .toString()
                                      .replaceAll("+", "'"),
                                  "number": lastRead["number_surah"],
                                  "bookmark": lastRead,
                                },
                              );
                            }
                          },
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      if (lastRead != null)
                                        Text(
                                          "${lastRead['surah'].toString().replaceAll("+", "'")}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: appWhite,
                                          ),
                                        ),
                                      Text(
                                        lastRead == null
                                            ? "Belum ada data"
                                            : "Juz ${lastRead['juz']} | ayat ${lastRead['ayat']}",
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
                    );
                  },
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

                        // print(snapshot.data);

                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Surah surah = snapshot.data![index];
                              return ListTile(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.DETAIL_SURAH,
                                    arguments: {
                                      "name": surah.name!.transliteration!.id,
                                      "number": surah.number!,
                                    },
                                  );
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
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
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
                    FutureBuilder<List<juz.Juz>>(
                      future: controller.getAllJuz(),
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
                            juz.Juz detailJuz = snapshot.data![index];

                            String nameStart =
                                detailJuz.juzStartInfo?.split(" - ").first ??
                                    "";
                            String nameEnd =
                                detailJuz.juzEndInfo?.split(" - ").first ?? "";

                            List<Surah> rawAllSurahInJuz = [];
                            List<Surah> allSurahInJuz = [];

                            for (Surah item in controller.allSurah) {
                              rawAllSurahInJuz.add(item);
                              if (item.name!.transliteration!.id == nameEnd) {
                                break;
                              }
                            }

                            for (Surah item
                                in rawAllSurahInJuz.reversed.toList()) {
                              allSurahInJuz.add(item);
                              if (item.name!.transliteration!.id == nameStart) {
                                break;
                              }
                            }

                            // allSurahInJuz.forEach((element) {
                            //   print("[");
                            //   print(element.name!.transliteration!.id);
                            //   print("]");
                            // });

                            return ListTile(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_JUZ, arguments: {
                                  "juz": detailJuz,
                                  "surah": allSurahInJuz.reversed.toList()
                                });
                              },
                              leading: Obx(
                                () => Container(
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
                                      "${index + 1}",
                                      // style: TextStyle(
                                      //   color: appPurpleDark1,
                                      // ),
                                    ))),
                              ),
                              title: Text(
                                "Juz ${index + 1}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              isThreeLine: true,
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Mulai dari Surah ${detailJuz.juzStartInfo}",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    "Sampai Surah ${detailJuz.juzEndInfo}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    GetBuilder<HomeController>(
                      builder: (c) {
                        return FutureBuilder(
                          future: c.getBookmark(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (snapshot.data?.length == 0) {
                              return Center(
                                child: Text("Belum ada Bookmark"),
                              );
                            }

                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> data =
                                    snapshot.data![index];
                                return ListTile(
                                  onTap: () {
                                    // switch (data["via"]) {
                                    //   case "juz":
                                    //     print("go to juz");
                                    //     break;
                                    //   default:
                                    // Get.toNamed(
                                    //   Routes.DETAIL_SURAH,
                                    //   arguments: {
                                    //     "name": data["surah"]
                                    //         .toString()
                                    //         .replaceAll("+", "'"),
                                    //     "number": data["number_surah"],
                                    //     "bookmark": data,
                                    //   },
                                    // );
                                    //     break;
                                    // }

                                    //by default
                                    Get.toNamed(
                                      Routes.DETAIL_SURAH,
                                      arguments: {
                                        "name": data["surah"]
                                            .toString()
                                            .replaceAll("+", "'"),
                                        "number": data["number_surah"],
                                        "bookmark": data,
                                      },
                                    );
                                  },
                                  leading: Obx(
                                    () => Container(
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
                                          "${index + 1}",
                                          // style: TextStyle(
                                          //   color: appPurpleDark1,
                                          // ),
                                        ))),
                                  ),
                                  title: Text(
                                      "${data["surah"].toString().replaceAll("+", "'")}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(
                                    "Ayat ${data["ayat"]} - via ${data["via"]}",
                                    style: TextStyle(color: Colors.grey[500]),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: "Hapus Bookmark",
                                        titleStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        middleText:
                                            "Apakah anda yakin ingin menghapus bookmark ini?",
                                        confirm: ElevatedButton(
                                          onPressed: () {
                                            c.deleteBookmark(data["id"]);
                                          },
                                          child: Text(
                                            "Hapus",
                                            style: TextStyle(color: appWhite),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: appPurpleDark1,
                                          ),
                                        ),
                                        cancel: OutlinedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text(
                                            "Batal",
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.changeThemeMode(),
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
