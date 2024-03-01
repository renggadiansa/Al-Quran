import 'dart:convert';

import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/db/bookmark.dart';
import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sqflite/sqflite.dart';

class DetailSurahController extends GetxController {

  AutoScrollController scrollC = AutoScrollController();

  final player = AudioPlayer();
  Verse? lastVerse;

  DatabaseManager database = DatabaseManager.instance;

  Future<void> addBookmark(
      bool lastRead, DetailSurah surah, Verse ayat, int indexAyat) async {
    Database db = await database.db;
    bool flexExist = false;

    if (lastRead = lastRead) {
      await db.delete("bookmark", where: "last_read = 1");
    } else {
      List checkData = await db.query(
          "bookmark", 
          columns: ["surah", "number_surah" ,"ayat", "juz", "via", "index_ayat", "last_read"],
          where: "surah = '${surah.name!.transliteration!.id!.replaceAll("'", "+")}' and number_surah = ${surah.number!} and ayat = ${ayat.number!.inSurah!} and juz = ${ayat.meta!.juz!} and via = 'surah' and index_ayat = $indexAyat and last_read = 0");
      if (checkData.length != 0) {
        flexExist = true;
      }
    }

    if (flexExist == false) {
      await db.insert("bookmark", {
        "surah": "${surah.name!.transliteration!.id!.replaceAll("'", "+")}",
        "number_surah": surah.number!,
        "ayat": ayat.number!.inSurah!,
        "juz": ayat.meta!.juz!,
        "via": "surah",
        "index_ayat": indexAyat,
        "last_read": lastRead == true ? 1 : 0,
      });

      Get.back();
      if(lastRead == true){
        Get.snackbar("Berhasil", "Berhasil menambahkan terakhir dibaca",
            colorText: appWhite);
      // } else if(lastRead != flexExist ){
      //   Get.snackbar("Gagal", "Terakhir dibaca sudah ada",
      //       colorText: appWhite);
      } else {
        Get.snackbar("Berhasil", "Berhasil menambahkan bookmark",
            colorText: appWhite);
      }
    } else {
      Get.back();
      Get.snackbar("Gagal", "Bookmark sudah ada", colorText: appWhite);
    }

    var data = await db.query("bookmark");
    print(data);
  }

  Future<DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://myquran-api.vercel.app/surah/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    return DetailSurah.fromJson(data);
  }

  void stopAudio(Verse ayat) async {
    try {
      await player.stop();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: e.message.toString(),
      );
      //print("Error code: ${e.code}");
      //print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      //print("Connection aborted: ${e.message}");
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Connection aborted: ${e.message}",
      );
    } catch (e) {
      //print('An error occured: $e');
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak dapat stop audio",
      );
    }
  }

  void resumeAudio(Verse ayat) async {
    try {
      ayat.kondisiAudio = "playing";
      update();
      await player.play();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: e.message.toString(),
      );
      //print("Error code: ${e.code}");
      //print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      //print("Connection aborted: ${e.message}");
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Connection aborted: ${e.message}",
      );
    } catch (e) {
      //print('An error occured: $e');
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak dapat resume audio",
      );
    }
  }

  void pauseAudio(Verse ayat) async {
    try {
      await player.pause();
      ayat.kondisiAudio = "pause";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: e.message.toString(),
      );
      //print("Error code: ${e.code}");
      //print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      //print("Connection aborted: ${e.message}");
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Connection aborted: ${e.message}",
      );
    } catch (e) {
      //print('An error occured: $e');
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak dapat pause audio",
      );
    }
  }

  void playAudio(Verse? ayat) async {
    if (ayat?.audio?.primary != null) {
      // Catching errors at load time

      if (lastVerse == null) {
        lastVerse = ayat;
      }
      lastVerse!.kondisiAudio = "stop";
      lastVerse = ayat;
      lastVerse!.kondisiAudio = "stop";
      update();
      try {
        await player.stop();
        await player.setUrl(ayat!.audio!.primary!);
        ayat.kondisiAudio = "playing";
        update();
        await player.play();
        ayat.kondisiAudio = "stop";
        await player.stop();
        update();
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.message.toString(),
        );
        //print("Error code: ${e.code}");
        //print("Error message: ${e.message}");
      } on PlayerInterruptedException catch (e) {
        //print("Connection aborted: ${e.message}");
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}",
        );
      } catch (e) {
        //print('An error occured: $e');
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat memutar audio",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Audio tidak ditemukan",
      );
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
