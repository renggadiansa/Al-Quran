import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/models/juz.dart' as juz;
import 'package:alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final juz.Juz detailJuz = Get.arguments["juz"];
  final List<Surah> allSurahInThisJuz = Get.arguments["surah"];

  final Surah surah = Get.arguments["surah"];
  //const DetailJuzView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    allSurahInThisJuz.forEach((element) {
      print(element.name!.transliteration!.id);
    });
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          title: Text(
            'Juz ${detailJuz.juz}',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(20),
              itemCount: detailJuz.verses?.length ?? 0,
              itemBuilder: (context, index) {
                if (detailJuz.verses == null || detailJuz.verses?.length == 0) {
                  return Center(
                    child: Text("Data tidak ditemukan"),
                  );
                }
                juz.Verses ayat = detailJuz.verses![index];
                if (index != 0) {
                  if (ayat.number?.inSurah == 1) {
                    controller.index++;
                  }
                }

                return ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    if (ayat.number?.inSurah == 1)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
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
                                          "Tafsir ${surah.name?.transliteration?.id ?? 'Error'}",
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
                            child: Container(
                              width: Get.width,
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
                                      "Surah ${allSurahInThisJuz[controller.index].name?.transliteration?.id ?? 'Error'}",
                                      style: TextStyle(
                                        color: appWhite,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "(${allSurahInThisJuz[controller.index].name?.translation?.id ?? 'Error'})",
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
                                      "${allSurahInThisJuz[controller.index].numberOfVerses ?? 'Error'} Ayat | ${allSurahInThisJuz[controller.index].revelation?.id ?? 'Error'}",
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
                          SizedBox(height: 20),
                        ],
                      ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: appPurpleLight2.withOpacity(0.3)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
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
                                      "${ayat.number?.inSurah}",
                                    ),
                                  ),
                                ),
                                // Text(
                                //   "${allSurahInThisJuz[controller.index].name?.transliteration?.id ?? ''}",
                                //   style: TextStyle(
                                //     fontStyle: FontStyle.italic,
                                //     fontSize: 20,
                                //   ),
                                // )
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.bookmark_add_outlined),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.play_circle_fill_rounded),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "${ayat.text?.arab}",
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${ayat.text?.transliteration?.en}",
                      textAlign: TextAlign.end,
                      style:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 25),
                    Text(
                      "${ayat.translation?.id}",
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 50),
                  ],
                );
              },
            ),
          ],
        ));
  }
}
