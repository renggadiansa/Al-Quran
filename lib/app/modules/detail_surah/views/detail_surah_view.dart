import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  //const DetailSurahView({Key? key}) : super(key: key);
  // final Surah surah = Get.arguments;
  Map<String, dynamic>? bookmark;

  final homeC = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text(
          'Surah ${Get.arguments["name"]}',
          style: TextStyle(color: appWhite),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<detail.DetailSurah>(
        future: controller.getDetailSurah(Get.arguments["number"].toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text("Data Kosong"),
            );
          }

          if (Get.arguments["bookmark"] != null) {
            bookmark = Get.arguments["bookmark"];
            if (bookmark!["index_ayat"] > 0) {
              controller.scrollC.scrollToIndex(
                bookmark!["index_ayat"] + 2,
                preferPosition: AutoScrollPosition.begin,
              );
            }
          }
          print(bookmark);

          detail.DetailSurah surah = snapshot.data!;

          List<Widget> allAyat = List.generate(
            snapshot.data?.verses?.length ?? 0,
            (index) {
              detail.Verse? ayat = snapshot.data?.verses?[index];
              return AutoScrollTag(
                key: ValueKey(index + 2),
                index: index + 2,
                controller: controller.scrollC,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: appPurpleLight2.withOpacity(0.3)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(Get.isDarkMode
                                      ? "assets/images/octagonal_dark.png"
                                      : "assets/images/octagonal.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                ),
                              ),
                            ),
                            GetBuilder<DetailSurahController>(
                              builder: (c) => Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: "BOOKMARK",
                                        middleText: "Pilih jenis Bookmark",
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              await c.addBookmark(true,
                                                  snapshot.data!, ayat!, index);
                                              homeC.update();
                                            },
                                            child: Text(
                                              "Last Read",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: appPurple,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              c.addBookmark(false,
                                                  snapshot.data!, ayat!, index);
                                            },
                                            child: Text(
                                              "Bookmark",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: appPurple,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    icon: Icon(Icons.bookmark_add_outlined),
                                  ),
                                  (ayat?.kondisiAudio == "stop")
                                      ? IconButton(
                                          onPressed: () {
                                            c.playAudio(ayat);
                                          },
                                          icon: Icon(
                                              Icons.play_circle_fill_rounded),
                                        )
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            (ayat?.kondisiAudio == "playing")
                                                ? IconButton(
                                                    onPressed: () {
                                                      c.pauseAudio(ayat!);
                                                    },
                                                    icon: Icon(Icons
                                                        .pause_circle_filled_rounded),
                                                  )
                                                : IconButton(
                                                    onPressed: () {
                                                      c.resumeAudio(ayat!);
                                                    },
                                                    icon: Icon(Icons
                                                        .play_circle_fill_rounded),
                                                  ),
                                            IconButton(
                                              onPressed: () {
                                                c.stopAudio(ayat!);
                                              },
                                              icon: Icon(Icons.stop),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onLongPress: () => Get.dialog(Dialog(
                        child: SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Get.isDarkMode
                                  ? appPurpleLight2.withOpacity(0.3)
                                  : appWhite,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.all(25),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    "Tafsir Surah ${surah.name?.transliteration?.id ?? 'Error'} Ayat ${ayat.number?.inSurah ?? 'Error'}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    )),
                                SizedBox(height: 20),
                                Text(
                                  "Tafsir Pendek",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "${ayat.tafsir?.id?.short ?? 'Error'}",
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(height: 30),
                                Text(
                                  "Tafsir Panjang",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "${ayat.tafsir?.id?.long ?? 'Error'}",
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${ayat!.text?.arab}",
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${ayat.text?.transliteration?.en}",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 18, fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: 25),
                          Text(
                            "${ayat.translation?.id}",
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 50),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );

          return ListView(
            controller: controller.scrollC,
            padding: EdgeInsets.all(20),
            children: [
              AutoScrollTag(
                key: ValueKey(0),
                index: 0,
                controller: controller.scrollC,
                child: GestureDetector(
                  onLongPress: () => Get.dialog(Dialog(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? appPurpleLight2.withOpacity(0.3)
                                : appWhite,
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.all(25),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                "Tafsir Surah ${surah.name?.transliteration?.id ?? 'Error'}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 20),
                            Text(
                              "Tafsir ${surah.tafsir?.id ?? 'Error'}",
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        )),
                  )),
                  // onTap: () => Get.defaultDialog(
                  //     contentPadding:
                  //         EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  //     title: "Tafsir ${surah.name?.transliteration?.id ?? 'Error'}",
                  //     titleStyle: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //     content: Container(
                  //       color: Colors.transparent,
                  //       child: Text(
                  //         "Tafsir ${surah.tafsir?.id ?? 'Error'}",
                  //         textAlign: TextAlign.justify,
                  //       ),
                  //     )),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          appPurpleDark1,
                          appPurpleLight1,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            "Surah ${surah.name?.transliteration?.id ?? 'Error'}",
                            style: TextStyle(
                              color: appWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "(${surah.name?.translation?.id ?? 'Error'})",
                            style: TextStyle(
                              color: appWhite,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${surah.numberOfVerses ?? 'Error'} Ayat | ${surah.revelation?.id ?? 'Error'}",
                            style: TextStyle(
                              color: appWhite,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AutoScrollTag(
                  key: ValueKey(1),
                  index: 1,
                  controller: controller.scrollC,
                  child: SizedBox(height: 20)),
              ...allAyat,
            ],
          );
        },
      ),
    );
  }
}
