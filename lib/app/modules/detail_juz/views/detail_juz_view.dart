import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/data/models/detail_surah.dart' as detail2;

import 'package:alquran/app/data/models/juz.dart' as juz;
import 'package:alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final juz.Juz detailJuz = Get.arguments["juz"];
  final List<Surah> allSurahInThisJuz = Get.arguments["surah"];

  DetailJuzView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text(
          'Juz ${detailJuz.juz}',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            itemCount: detailJuz.verses?.length ?? 0,
            itemBuilder: (context, index) {
              if (detailJuz.verses == null || detailJuz.verses!.isEmpty) {
                return const Center(
                  child: Text("Data tidak ditemukan"),
                );
              }
              juz.Verses ayat = detailJuz.verses![index];
              if (index != 0) {
                if (ayat.number!.inSurah == 1) {
                  controller.index++;
                }
              }

              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  if (ayat.number!.inSurah == 1)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SurahWidget(
                          surah: allSurahInThisJuz[controller.index],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: appPurpleLight2.withOpacity(0.3),
                    ),
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
                                margin: const EdgeInsets.only(right: 10),
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
                              Text(
                                allSurahInThisJuz[controller.index]
                                        .name
                                        ?.transliteration
                                        ?.id ??
                                    '',
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              JuzAudio(
                                  surah: allSurahInThisJuz[controller.index],
                                  ayat: detail.Verse(
                                    audio: detail.Audio(
                                      primary: ayat.audio?.primary,
                                      // secondary: ayat.audio?.secondary,
                                    ),
                                    number: detail.Number(
                                      inSurah: ayat.number?.inSurah,
                                    ),
                                    meta: detail.Meta(
                                      juz: ayat.meta?.juz,
                                      page: ayat.meta?.page,
                                    ),
                                  ),
                                  detailSurah: detail.DetailSurah(
                                    name: detail.Name(
                                      transliteration: detail.Translation(
                                        id: allSurahInThisJuz[controller.index]
                                            .name
                                            ?.transliteration
                                            ?.id,
                                      ),
                                    ),
                                    number: allSurahInThisJuz[controller.index]
                                        .number,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SurahWidgetTafsir(
                    surah: allSurahInThisJuz[controller.index],
                    ayat: detail.Verse(
                        text: detail.Text(
                          arab: ayat.text?.arab,
                          transliteration: detail.Transliteration(
                            en: ayat.text?.transliteration?.en,
                          ),
                        ),
                        translation: detail.Translation(
                          id: ayat.translation?.id,
                        ),
                        number: detail.Number(inSurah: ayat.number?.inSurah),
                        tafsir: detail.VerseTafsir(
                          id: detail.Id(
                            short: ayat.tafsir?.id?.short,
                            long: ayat.tafsir?.id?.long,
                          ),
                        )),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class SurahWidget extends StatelessWidget {
  const SurahWidget({super.key, required this.surah});
  final Surah surah;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => Get.dialog(
        Dialog(
          child: Container(
            decoration: BoxDecoration(
              color:
                  Get.isDarkMode ? appPurpleLight2.withOpacity(0.3) : appWhite,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Tafsir ${surah.name?.transliteration?.id ?? 'Error'}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Tafsir ${surah.tafsir?.id ?? 'Error'}",
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
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
                style: const TextStyle(
                  color: appWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "(${surah.name?.translation?.id ?? 'Error'})",
                style: const TextStyle(
                  color: appWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${surah.numberOfVerses ?? 'Error'} Ayat | ${surah.revelation?.id ?? 'Error'}",
                style: const TextStyle(
                  color: appWhite,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SurahWidgetTafsir extends StatelessWidget {
  const SurahWidgetTafsir({super.key, required this.surah, required this.ayat});
  final Surah surah;
  final detail.Verse ayat;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => Get.dialog(Dialog(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color:
                  Get.isDarkMode ? appPurpleLight2.withOpacity(0.3) : appWhite,
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
            "${ayat.text?.arab}",
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(height: 10),
          Text(
            "${ayat.text?.transliteration?.en}",
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
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
    );
  }
}

class JuzAudio extends StatelessWidget {
  const JuzAudio(
      {super.key,
      required this.surah,
      required this.ayat,
      required this.detailSurah});
  final Surah surah;
  final detail.Verse ayat;
  final detail2.DetailSurah detailSurah;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailJuzController>(
      builder: (c) => Row(
        children: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "BOOKMARK",
                middleText: "Pilih jenis Bookmark",
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      c.addBookmark(true, detailSurah, ayat, c.index);
                    },
                    child: Text(
                      "Last Read",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appPurple,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      c.addBookmark(false, detailSurah, ayat, c.index);
                    },
                    child: Text(
                      "Bookmark",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appPurple,
                    ),
                  ),
                ],
              );
            },
            icon: Icon(Icons.bookmark_add_outlined),
          ),
          (ayat.kondisiAudio == "stop")
              ? IconButton(
                  onPressed: () {
                    c.playAudio(ayat);
                  },
                  icon: Icon(Icons.play_circle_fill_rounded),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (ayat.kondisiAudio == "playing")
                        ? IconButton(
                            onPressed: () {
                              c.pauseAudio(ayat);
                            },
                            icon: Icon(Icons.pause_circle_filled_rounded),
                          )
                        : IconButton(
                            onPressed: () {
                              c.resumeAudio(ayat);
                            },
                            icon: Icon(Icons.play_circle_fill_rounded),
                          ),
                    IconButton(
                      onPressed: () {
                        c.stopAudio(ayat);
                      },
                      icon: Icon(Icons.stop),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
