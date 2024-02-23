import 'package:alquran/app/data/db/bookmark.dart';
import 'package:alquran/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import 'package:sqflite/sqflite.dart';
import 'package:alquran/app/constants/color.dart';

import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:just_audio/just_audio.dart';

class DetailJuzController extends GetxController {
  int index = 0;

  final homeC = Get.find<HomeController>();

  DatabaseManager database = DatabaseManager.instance;

  void addBookmark(
      bool lastRead, DetailSurah surah, Verse ayat, int indexAyat) async {
    Database db = await database.db;
    bool flexExist = false;

    if (lastRead = lastRead) {
      await db.delete("bookmark", where: "last_read = 1");
    } else {
      List checkData = await db.query("bookmark",
          columns: [
            "surah",
            "number_surah",
            "ayat",
            "juz",
            "via",
            "index_ayat",
            "last_read"
          ],
          where:
              "surah = '${surah.name!.transliteration!.id!.replaceAll("'", "+")}' and number_surah = ${surah.number!} and ayat = ${ayat.number!.inSurah!} and juz = ${ayat.meta!.juz!} and via = 'juz' and index_ayat = $indexAyat and last_read = 0");
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
        "via": "juz",
        "index_ayat": indexAyat,
        "last_read": lastRead == true ? 1 : 0,
      });

      Get.back();
      homeC.update();
      Get.snackbar("Berhasil", "Berhasil menambahkan bookmark",
          colorText: appWhite);
    } else {
      Get.back();
      Get.snackbar("Gagal", "Bookmark sudah ada", colorText: appWhite);
    }

    var data = await db.query("bookmark");
    print(data);
  }

  final player = AudioPlayer();
  Verse? lastVerse;

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
