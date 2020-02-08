import 'package:http/http.dart' as http;
// اضفنا هذي المكتبه من أجل استخدام الكلمة المفتاحية @required
import 'package:flutter/cupertino.dart';
// هذي المكتبه راح نستخدمها في عملية تحويل البيانات من Json نصي الى Object
import 'dart:convert';

//عرفنا كلاس جديد و سميناه بهذا الاسم
class NetworkHelper {
  // عرفنا متغير راح نستخدمه في عملية ارسال الرابط الخاص بال api
  final String url;
  // هنا المُنشأ أو الباني للكلاس عند انشاء أي Object منه، بحيث يسمح لنا عند انشاء اي كلاس جديد لازم نرسل له رابط ال api  و خلينا وضعه @required يعني مطلوب اذا لما ندخله راح يطلع معنا خطأ
  NetworkHelper({@required this.url});
//  عرفنا هنا ميثود تجرع بيانات من نوع Future
  Future getData() async {
    print(this.url);
    // هنا بدأنا بتجهيز الاتصال
    var client = http.Client();
    try {
      // قمنا بطلب الرابط سوف ننتظر الرد بالكلمة المفتاحية await أو ما تصل نتيجة راح يكمل باقي خطوات التطبيق
      var response = await client.get(this.url);
      // اذا رجع لنا الاتصال بقيمة 200 معناه نجح الاتصال و رجع لنا بيانات
      if (response.statusCode == 200) {
        //  هنا راح نسحب النتيجه الي وصلتنا  من  الاتصال و التي تكون داخل body  تبع الاتصال
        var data = response.body;
        // طبعا البيانات راح توصلنا بشكل Json نصي و عشان نتعامل معاها بالدرات لازم نحولها الى Object  عشان نوصل للبيانات الي داخلها بالتفصيل
        return jsonDecode(data);
        //  هنا في اي حاله فشل الاتصال ممكن بسبب ما عندنا صلاحيه او ما فيه خدمه بالسيرفر أو ما فيه شبكه بالجوال
      } else {
        // هنا سوينا طباعه لحالة الخطأ ، لكن لابد نخليه يظهر رساله للمستخدم انو حصل خطأ
        print(response.statusCode);
      }
    } finally {
      // هنا قمنا باقفال الطلب لانه انهى مهمته
      client.close();
    }
  }
}
