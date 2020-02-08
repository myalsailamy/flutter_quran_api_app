import 'package:flutter/material.dart';
import './alquran.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // قمنا بتعريف متغيير نصي بما أننا نعلم بأن الأيات عبارة عن نص
  String ayahResult = "";

  // عرفنا Void مهمتها تحديث الواجهه عند رجوع بيانات الخاصه بالأية و التي نعلم حتى الأن أنها بصيغة Json لذلك نوعها سيكون dynamic
  void updateUI(dynamic ayahData) {
    // أمر تحديث واجهات widget لكي نخبر الواجهات بان هناك بيانات جديدة و يجب عليه عكسها على واجهة المستخدم
    setState(() {
      // نفحص البيانات هل هي فارغه من اجل حدوث مشكلة بالتطبيق أثناء عمله
      if (ayahData == null) {
        // نخبر المستخدم بأنه حصل خطأ ما غير مقصود لك حرية اظهارها اما بتنبيه و تلوينه بالأحمر أما انا سأكتب Error
        ayahResult = 'Error';
        // يخرج من ال void بدون أن يعرض الآية ، لانه لم يجدها
        return;
      } else {
        // في حالة وجود بيانات فإنه سيقوم بسحب الآية من ال Json بالطريقة هذه و عبر تحديد مسار البيانات في ملف Json
        ayahResult = ayahData['data']['text'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              // ال widget التي سوف تعرض الآيه على الواجهه
              ayahResult,
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // الزر الذي سيقوم بتنفيذ الاجراء عندما يقوم المستخدم بالضغط عليه
        // وبما أنه سيتعامل مع شيء بالمستقبل بشكل مباشر نضع async
        onPressed: () async {
          // و بما أنه لدينا async بشكل مباشر نحدد السطر الي سيأخر تنفيذه و نضع أمامه await
          // نقوم بتعريف Object من الكلاس الذي أنشأناه سابقاً ونرسل معه رقم السورة ة رقم الآيه
          // في هذه الحاله  ادخلنا رقم السورة 112 وهي سورة الاخلاص ، الآية الثانيه 2
          var ayahData = await AlquranModel().getAyahOfTheQuran(112, 2);
          // عند وصول البيانات لابد أن نطلب من الفلاتر تحديث الواجهات بالبيانات الجديدة
          updateUI(ayahData);
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
