import 'package:flutter/material.dart';
import 'package:http_currency_converter/controller.dart';
import 'package:http_currency_converter/home.dart';
import 'package:okito/okito.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Okito.inject(ConverterController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OkitoMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenHome(),
    );
  }
}
