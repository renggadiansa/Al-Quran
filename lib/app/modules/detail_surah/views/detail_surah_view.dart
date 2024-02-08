import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  //const DetailSurahView({Key? key}) : super(key: key);
  final Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          title: Text(
            'Surah ${surah.name?.transliteration?.id ?? 'Error'}',
            style: TextStyle(color: appWhite),
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
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
            SizedBox(height: 20),
            FutureBuilder<detail.DetailSurah>(
                future: controller.getDetailSurah(surah.number.toString()),
                builder: (context, snapshot) {
                  print(snapshot.data);

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
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.verses?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (snapshot.data?.verses?.length == 0) {
                        return SizedBox();
                      }
                      detail.Verse? ayat = snapshot.data?.verses?[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: appPurpleLight2.withOpacity(0.3)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.bookmark_add_outlined),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          controller.playAudio(ayat?.audio?.primary);
                                        },
                                        icon: Icon(
                                            Icons.play_circle_fill_rounded),
                                      ),
                                    ],
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
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic),
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
                      );
                    },
                  );
                })
          ],
        ));
  }
}
