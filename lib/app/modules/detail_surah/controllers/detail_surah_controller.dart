import 'dart:convert';

import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {
  final player = AudioPlayer();
  Verse? lastVerse;

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
