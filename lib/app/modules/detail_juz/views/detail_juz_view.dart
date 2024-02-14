import 'package:alquran/app/constants/color.dart';
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
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.bookmark_add_outlined),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.play_circle_fill_rounded),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "${ayat.text?.arab}",
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${ayat.text?.transliteration?.en}",
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "${ayat.translation?.id}",
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 50),
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
