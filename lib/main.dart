import 'package:crud/ui/screens/AddProduct.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'ui/screens/HomePage.dart';

void main() {
  runApp( DevicePreview(
    builder: (context) => MyApp(),
  )
  );

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'CRUd app',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => HomePage(),
        AddProduct.name : (context) => AddProduct(),

      },
    );
  }
}




