import 'package:cryptography_app/layout/home.dart';
import 'package:cryptography_app/layout/onboarding/onboarding.dart';
import 'package:flutter/material.dart';


import 'shared/network/constant.dart';
import 'shared/network/remote/cache.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Cache_Helper.init();

  dynamic onborading = Cache_Helper.getData(key: 'Onboarding');


  if (onborading != null) {
    widgett = const Home_Screen();
  } else {
    widgett = const OnBoarding_Screen();
  }
  runApp(MyApp(widget: widgett!));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.widget});
  final Widget widget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: widgett,
    );
  }
}
