import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/models/juz.dart' as juz;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final juz.Juz detailJuz = Get.arguments;
  //const DetailJuzView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Juz ${detailJuz.juz}',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: detailJuz.verses?.length ?? 0,
          itemBuilder: (context, index) {
            if(detailJuz.verses == null || detailJuz.verses?.length == 0) {
              return Center(
                child: Text("Data tidak ditemukan"),
              );
            }
            juz.Verses ayat = detailJuz.verses![index];
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
                                        "${ayat.number?.inSurah}",
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
                                        onPressed: () {},
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
                          Text(
                            "${ayat.text?.arab}",
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
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 50),
                        ],
                      );
          },
        ));
  }
}
