import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// [
//   [........], juz 1 => index 0
//   [.........], juz 2 => index 1
//   ...
//   [........], juz 30 => index 29
// ]



// [
//   {
//     "juz": 1,
//     "start": Ayat,
//     "end": Ayat,
//     "verses" : [......],
//   },
  // .......
//   {
//     "juz": 30,
//     "start": Ayat,
//     "end": Ayat,
//     "verses" : [......],
//   },
// ]

// List<Map<String, dynamic>>


void main() async {
  int juz = 1;

  List<Map<String, dynamic>> penampungAyat = [];
  List<Map<String, dynamic>> allJuz = [];

  for (var i = 0; i < 114; i++) {
    var res = await http.get(Uri.parse("https://api.quran.gading.dev/surah/$i"));
    
    // Periksa jika respon HTTP berhasil
    if (res.statusCode == 200) {
      Map<String, dynamic> rawData = json.decode(res.body)["data"];

      // Periksa jika rawData tidak null
      if (rawData != null) {
        DetailSurah data = DetailSurah.fromJson(rawData);

        if (data.verses != null) {
          data.verses!.forEach((ayat) {
            if (ayat.meta?.juz == juz) {
              penampungAyat.add({
                "surah": data.name?.transliteration?.id ?? '',
                "ayat": ayat,
              });
            } else {
              print("========");
              print("Berhasil memasukan juz $juz");
              if (penampungAyat.isNotEmpty) {
                print("START...");
                print("ayat: ${(penampungAyat[0]["ayat"] as Verse)?.number?.inSurah}");
                print((penampungAyat[0]["ayat"] as Verse)?.text?.arab);
                print("END...");
                print("ayat: ${(penampungAyat[penampungAyat.length - 1]["ayat"] as Verse)?.number?.inSurah}");
                print((penampungAyat[penampungAyat.length - 1]["ayat"] as Verse)?.text?.arab);
              }
              allJuz.add({
                "juz": juz,
                "juzStartInfo": penampungAyat.isNotEmpty ? penampungAyat[0] : null,
                "juzEndInfo": penampungAyat.isNotEmpty ? penampungAyat[penampungAyat.length - 1] : null,
                "verses": penampungAyat,
              });
              juz++;
              penampungAyat.clear();
              penampungAyat.add({
                "surah": data.name?.transliteration?.id ?? '',
                "ayat": ayat,
              });
            }
          });
        }
      } else {
        print("Error: Response body is null.");
      }
    } else {
      // Tangani error respon HTTP
      print("Error fetching data: ${res.statusCode}");
    }
  }

  print("========");
  print("Berhasil memasukan juz $juz");
  if (penampungAyat.isNotEmpty) {
    print("START...");
    print("ayat: ${(penampungAyat[0]["ayat"] as Verse)?.number?.inSurah}");
    print((penampungAyat[0]["ayat"] as Verse)?.text?.arab);
    print("END...");
    print("ayat: ${(penampungAyat[penampungAyat.length - 1]["ayat"] as Verse)?.number?.inSurah}");
    print((penampungAyat[penampungAyat.length - 1]["ayat"] as Verse)?.text?.arab);
  }
  allJuz.add({
    "juz": juz,
    "start": penampungAyat.isNotEmpty ? penampungAyat[0] : null,
    "end": penampungAyat.isNotEmpty ? penampungAyat[penampungAyat.length - 1] : null,
    "verses": penampungAyat,
  });
}
