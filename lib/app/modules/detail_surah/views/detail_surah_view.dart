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
          title: Text('Surah ${surah.name?.transliteration?.id ?? 'Error'}'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Surah ${surah.name?.transliteration?.id ?? 'Error'}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "(${surah.name?.translation?.id ?? 'Error'})",
                      style: TextStyle(
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
                        fontSize: 16,
                      ),
                    )
                  ],
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
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    child: Text("${index + 1}"),
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
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 50),
                        ],
                      );
                    },
                  );
                })
          ],
        ));
  }
}
