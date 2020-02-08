import 'network.dart';

const baseURL = "http://api.alquran.cloud/v1";

class AlquranModel {
  Future<dynamic> getAyahOfTheQuran(int surah, int ayah) async {
    // قمنا بتعريف Object من الكلاس الذي قمنا سابقاً بانشائه و الذي يتطلب ارسال Url له
    NetworkHelper networkHelper =
        NetworkHelper(url: '$baseURL/ayah/$surah:$ayah');
    // قمنا باستخدام await لانتظار النتيجة القادمة من كلاس network ووضعنا النتيجة في متغير
    // لماذا ااستخدمنا متغير غير معرف لانه Json و قد تكون البيانات التي ترجع غير محدده بالضبط ما هيا
    var ayahData = await networkHelper.getData();
    // قمنا بارجاع البيانات التي وصلت لنا
    return ayahData;
  }
}
